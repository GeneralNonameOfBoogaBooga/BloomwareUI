local completed = 0
local function test(name, callback)
    callback(); completed = completed + 1; print("PASS " .. name)
end
local function equal(actual, expected, message)
    assert(actual == expected, (message or "values differ") .. ": " .. tostring(actual) .. " / " .. tostring(expected))
end
local png = "\137PNG\13\10\26\10" .. string.rep("p",32)
local jpg = "\255\216\255" .. string.rep("j",32)
local library = loadLibrary()
function library:Notify(config) table.insert(Mock.Notices, config); return config end
local window = library:CreateWindow({Title="Bloomware", Logo=false, Acrylic=false})
local farm = window:AddTab({Title="Overview"})
local settings = window:AddTab({Title="Settings"})
local appearance = library.Appearance
Scheduler.flush()

test("Settings reused; first page and search preserved", function()
    equal(farm.Index,1)
    equal(settings.Index,2)
    equal(window:AddTab({Title="Settings"}),settings)
    equal(window:AddTab({Title="Настройки"}),settings)
    equal(appearance.Attached,settings)
    equal(#window.TabHolder:GetChildren(),3) -- layout + two tabs
    local results = library.Search:Search("image")
    assert(#results > 0)
    equal(appearance.Paint.BackgroundImage.Visible,false)
end)

test("PNG URL applies with unique asset cache and profile state", function()
    Mock.Http["https://test.invalid/a.png"] = png
    assert(library:SetBackgroundImage(" https://test.invalid/a.png "))
    equal(appearance.State.Source,"")
    assert(appearance.Loading)
    assert(not library.Profiles:Save("pending"))
    assert(not library.Profiles:Export())
    Scheduler.flush()
    equal(appearance.State.Source,"https://test.invalid/a.png")
    assert(appearance.Paint.BackgroundImage.Visible)
    assert(appearance.Paint.BackgroundOverlay.Visible)
    equal(appearance.Paint.BackgroundImage.Size.X.Scale,1)
    equal(appearance.Paint.BackgroundImage.Size.Y.Scale,1)
    equal(Mock.Files["bloomware-ui-logo.png"],nil)
    assert(library.Profiles:Save("wallpaper"))
    equal(library.Profiles.Data.wallpaper.UI.Background.Source,appearance.State.Source)
    equal(library.Profiles.Data.wallpaper.Options.Bloomware_BackgroundURL,nil)
end)

test("Downloaded images bypass false local-preloader failures", function()
    for _,mode in ipairs({"not-loaded", "error", "stall"}) do
        local source = "https://test.invalid/local-" .. mode .. ".jpg"
        Mock.Http[source] = jpg
        Mock.LocalPreloadMode = mode
        local calls = #Mock.PreloadCalls
        local notices = #Mock.Notices
        assert(library:SetBackgroundImage(source))
        Scheduler.flush()
        equal(appearance.State.Source,source,"valid local image was rejected")
        equal(appearance.Loading,false)
        equal(appearance.Probe,nil)
        equal(#Mock.PreloadCalls,calls,"local image still depends on native preloader")
        equal(#Mock.Notices,notices)
        assert(appearance.Paint.BackgroundImage.Visible)
    end
    Mock.LocalPreloadMode = nil
end)

test("Native preload success is enough when hidden IsLoaded stays false", function()
    Mock.Preload["rbxassetid://112"] = function(object, callback)
        object.IsLoaded = false
        if callback then callback(object.Image,Enum.AssetFetchStatus.Success) end
    end
    library:SetBackgroundImage("112"); Scheduler.flush()
    equal(appearance.State.Source,"rbxassetid://112")
    equal(appearance.Loading,false)
end)

test("Native image may become ready after the preload call returns", function()
    Mock.Preload["rbxassetid://113"] = function(object) object.IsLoaded = false end
    local before = appearance.State.Source
    library:SetBackgroundImage("113"); Scheduler.flush()
    equal(appearance.State.Source,before)
    assert(appearance.Loading)
    local probe = appearance.Probe
    assert(probe and not probe.IsLoaded)
    probe.IsLoaded = true
    probe:GetPropertyChangedSignal("IsLoaded"):Fire()
    equal(appearance.State.Source,"rbxassetid://113")
    equal(appearance.Loading,false)
    assert(probe._destroyed)
end)

test("Unconfirmed native image times out without replacing the background", function()
    Mock.Preload["rbxassetid://114"] = function(object) object.IsLoaded = false end
    local before = appearance.State.Source
    library:SetBackgroundImage("114"); Scheduler.flush()
    local probe = appearance.Probe
    Scheduler.advance(21)
    equal(appearance.State.Source,before)
    equal(appearance.Loading,false)
    assert(probe._destroyed)
    assert(appearance.Status:find("asset ID",1,true))
end)

test("Native preloader exceptions retain the background and give a distinct error", function()
    Mock.Preload["rbxassetid://115"] = function() error("preload unavailable") end
    local before = appearance.State.Source
    library:SetBackgroundImage("115"); Scheduler.flush()
    equal(appearance.State.Source,before)
    equal(appearance.Loading,false)
    assert(appearance.Status:find("verify the Roblox asset ID",1,true))
    equal(appearance.Probe,nil)
end)

test("Native IDs, opacity, dimming and fitting update immediately", function()
    assert(library:SetBackgroundImage(123456))
    Scheduler.flush()
    equal(appearance.State.Source,"rbxassetid://123456")
    library:SetBackgroundTransparency(0.55)
    library:SetBackgroundDarkness(0.6)
    library:SetBackgroundScaleType("Fit")
    equal(appearance.Controls.Transparency.Value,55)
    equal(appearance.Paint.BackgroundImage.ImageTransparency,0.55)
    assert(math.abs(appearance.Paint.BackgroundOverlay.BackgroundTransparency-0.4)<0.0001)
    equal(appearance.Paint.BackgroundImage.ScaleType,Enum.ScaleType.Fit)
    assert(library.Profiles.Dirty)
end)

test("Invalid URL, HTML, oversized response and HTTP failure retain background", function()
    local before = appearance.State.Source
    assert(not library:SetBackgroundImage("file:///bad.png"))
    Mock.Http["https://test.invalid/page"] = "<html>no image</html>"
    library:SetBackgroundImage("https://test.invalid/page"); Scheduler.flush()
    equal(appearance.State.Source,before)
    Mock.Http["https://test.invalid/large"] = string.rep("x",12*1024*1024+1)
    library:SetBackgroundImage("https://test.invalid/large"); Scheduler.flush()
    equal(appearance.State.Source,before)
    Mock.Http["https://test.invalid/error"] = function() error("network error") end
    library:SetBackgroundImage("https://test.invalid/error"); Scheduler.flush()
    equal(appearance.State.Source,before)
    equal(appearance.Loading,false)
    assert(#Mock.Notices>=4)
end)

test("No URL bridge gives a clear error; native asset IDs still work", function()
    local register, writer = getcustomasset, writefile
    getcustomasset, writefile = nil, nil
    local before = appearance.State.Source
    library:SetBackgroundImage("https://test.invalid/unavailable.png"); Scheduler.flush()
    equal(appearance.State.Source,before)
    assert(appearance.Status:find("rbxassetid://ID",1,true))
    library:SetBackgroundImage("987654"); Scheduler.flush()
    equal(appearance.State.Source,"rbxassetid://987654")
    getcustomasset, writefile = register, writer
end)

test("Decode/moderation failure preserves the displayed image", function()
    Mock.Preload["rbxassetid://111"] = function(object, callback)
        object.IsLoaded = false
        if callback then callback(object.Image,Enum.AssetFetchStatus.Failure) end
    end
    local before = appearance.Paint.BackgroundImage.Image
    library:SetBackgroundImage("111"); Scheduler.flush()
    equal(appearance.Paint.BackgroundImage.Image,before)
    equal(appearance.Probe,nil)
    equal(appearance.Loading,false)
end)

test("Slow previous download cannot replace a newer choice", function()
    Mock.Http["https://test.invalid/slow"] = function() return Scheduler.gate("slow-http") end
    library:SetBackgroundImage("https://test.invalid/slow"); Scheduler.flush()
    library:SetBackgroundImage("222"); Scheduler.flush()
    equal(appearance.State.Source,"rbxassetid://222")
    Scheduler.release("slow-http",png)
    equal(appearance.State.Source,"rbxassetid://222")
    equal(appearance.Probe,nil)
end)

test("Clear cancels pending preload and destroys its hidden probe", function()
    Mock.Preload["rbxassetid://333"] = function(object)
        Scheduler.gate("slow-preload"); object.IsLoaded = true
    end
    library:SetBackgroundImage("333"); Scheduler.flush()
    local probe = appearance.Probe
    assert(probe and probe.Parent)
    library:ClearBackgroundImage()
    assert(probe._destroyed)
    equal(appearance.State.Source,"")
    equal(appearance.Controls.Source.Value,"")
    equal(appearance.Paint.BackgroundImage.Visible,false)
    Scheduler.release("slow-preload")
    equal(appearance.State.Source,"")
    equal(appearance.Probe,nil)
end)

test("Download timeout leaves existing background and ignores late data", function()
    library:SetBackgroundImage("444"); Scheduler.flush()
    Mock.Http["https://test.invalid/timeout"] = function() return Scheduler.gate("timeout-http") end
    library:SetBackgroundImage("https://test.invalid/timeout"); Scheduler.flush()
    Scheduler.advance(21)
    equal(appearance.Loading,false)
    equal(appearance.State.Source,"rbxassetid://444")
    assert(appearance.Status:find("took too long",1,true))
    Scheduler.release("timeout-http",jpg)
    equal(appearance.State.Source,"rbxassetid://444")
end)

test("Background saved and restored with profile; old profiles remain compatible", function()
    assert(library.Profiles:Load("wallpaper")); Scheduler.flush()
    equal(appearance.State.Source,"https://test.invalid/a.png")
    equal(appearance.State.Transparency,0.25)
    equal(appearance.State.Darkness,0.35)
    equal(appearance.State.ScaleType,"Crop")
    equal(library.Profiles.Dirty,false)
    library.Profiles.Data.old = {Format="BloomwareProfile",Version=1,Options={},UI={Theme="Light",Transparency=false}}
    assert(library.Profiles:Load("old")); Scheduler.flush()
    equal(library.Theme,"Light")
    equal(appearance.State.Source,"https://test.invalid/a.png")
    local malformed = library.Profiles:Capture("invalid")
    malformed.UI.Background.Transparency = 0/0
    library.Profiles.Data.invalid = malformed
    assert(not library.Profiles:Load("invalid"))
    equal(library.Profiles.Active,"old")
    equal(appearance.State.Transparency,0.25)
end)

test("Apply button loads a draft; editing URL alone makes no request", function()
    appearance.Controls.Source:SetValue("https://test.invalid/button.jpg")
    Mock.Http["https://test.invalid/button.jpg"] = jpg
    equal(Mock.Calls["https://test.invalid/button.jpg"],nil)
    local apply
    for _,node in ipairs(settings.Container:GetDescendants()) do
        if node.ClassName == "TextLabel" and node.Text == "Apply Background" then apply=node.Parent.Parent end
    end
    assert(apply,"missing apply button")
    apply.Activated:Fire(); Scheduler.flush()
    equal(Mock.Calls["https://test.invalid/button.jpg"],1)
    equal(appearance.State.Source,"https://test.invalid/button.jpg")
end)

test("Mobile layout retains a background sized to its window", function()
    Mock.Services.Workspace.CurrentCamera.ViewportSize=Vector2.new(390,844)
    Mock.Services.Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Fire()
    Scheduler.flush()
    assert(window.Mobile)
    assert(window.Size.X.Offset < 390 * 0.94,"mobile window fills the screen width")
    assert(window.Size.Y.Offset < 844 * 0.85,"mobile window fills the screen height")
    equal(window.Scale.Scale,1)
    equal(appearance.Paint.BackgroundImage.Size.X.Scale,1)
    equal(appearance.Paint.BackgroundImage.Size.Y.Scale,1)
end)

test("Unload cancels requests and releases image probes", function()
    Mock.Preload["rbxassetid://555"] = function(object)
        Scheduler.gate("destroy-preload"); object.IsLoaded = true
    end
    library:SetBackgroundImage("555"); Scheduler.flush()
    local probe = appearance.Probe
    library:Destroy()
    equal(appearance.Destroyed,true)
    assert(probe._destroyed)
    Scheduler.release("destroy-preload")
    equal(appearance.Probe,nil)
    equal(library.Window,nil)
end)

test("Settings automatically appended and reused by a later host call", function()
    Mock.Services.Workspace.CurrentCamera.ViewportSize=Vector2.new(1280,720)
    local lib = loadLibrary()
    local win=lib:CreateWindow({Title="Auto Settings",Logo=false})
    equal(win:AddTab({Title="Overview"}).Index,1)
    equal(win:AddTab({Title="Controls"}).Index,2)
    Scheduler.flush()
    equal(win.AppearanceTab.Index,3)
    equal(win:AddTab({Title="Settings"}),win.AppearanceTab)
    lib:Destroy()
end)

test("Code defaults and Appearance=false remain available", function()
    local lib = loadLibrary()
    local win=lib:CreateWindow({Title="Configured",Logo=false,Appearance=false,
        BackgroundImage="777",BackgroundTransparency=0.4,BackgroundDarkness=0.5,BackgroundScaleType="Stretch"})
    win:AddTab({Title="Overview"})
    Scheduler.flush()
    equal(win.AppearanceTab,nil)
    equal(lib.Appearance.State.Source,"rbxassetid://777")
    equal(lib.Appearance.Paint.BackgroundImage.ScaleType,Enum.ScaleType.Stretch)
    equal(lib.Appearance.Paint.BackgroundImage.ImageTransparency,0.4)
    lib:Destroy()
end)

local function setViewport(width,height)
    local camera=Mock.Services.Workspace.CurrentCamera
    camera.ViewportSize=Vector2.new(width,height)
    camera:GetPropertyChangedSignal("ViewportSize"):Fire()
end
local function phone(width,height,options)
    local input=Mock.Services.UserInputService
    input.TouchEnabled=true;input.KeyboardEnabled=false;input.PreferredInput=Enum.PreferredInput.Touch
    input.OnScreenKeyboardVisible=false;input.OnScreenKeyboardSize=Vector2.new(0,0)
    setViewport(width,height)
    local lib=loadLibrary()
    local win=lib:CreateWindow(options or {Title="Bloomware",SubTitle="Example project",Logo="rbxassetid://123"})
    win:AddTab({Title="Overview"});Scheduler.flush()
    return lib,win
end
local function inBounds(win,width,height)
    local x,y=win.Position.X.Offset,win.Position.Y.Offset
    assert(x>=0 and y>=0,"window starts outside viewport")
    assert(x+win.Size.X.Offset*win.Scale.Scale<=width+0.01,"window overflows right edge")
    assert(y+win.Size.Y.Offset*win.Scale.Scale<=height+0.01,"window overflows bottom edge")
end
local function touch(x,y)
    return {UserInputType=Enum.UserInputType.Touch,KeyCode=Enum.KeyCode.Unknown,Position=Vector2.new(x,y)}
end

test("Phone and tablet sizes stay compact with full-size touch targets", function()
    for _,size in ipairs({{320,568},{390,844},{430,932},{568,320},{667,375},{844,390},{915,412},{720,1280},{1280,720},{768,1024},{1024,768}})do
        local lib,win=phone(size[1],size[2])
        assert(win.Mobile,"touch device did not get mobile layout")
        assert(win.Size.X.Offset<size[1]*0.94,"mobile width fills viewport")
        assert(win.Size.Y.Offset<size[2]*0.85,"mobile height fills viewport")
        assert(win.Size.X.Offset<=720 and win.Size.Y.Offset<=560)
        equal(win.Scale.Scale,1)
        inBounds(win,size[1],size[2])
        assert(win.Size.Y.Offset-win.ContentTop-12>=100,"content area is too short")
        equal(win.TitleBar.MenuButton.Frame.Size.Y.Offset,44)
        equal(win.TitleBar.MinButton.Frame.Size.Y.Offset,44)
        equal(win.TitleBar.CloseButton.Frame.Size.Y.Offset,44)
        equal(win.TitleBar.Frame.Size.Y.Offset,56)
        assert(win.TitleBar.DragArea.Size.X.Scale*win.Size.X.Offset+win.TitleBar.DragArea.Size.X.Offset>100)
        assert(win.AppearanceTab)
        win:SetDrawer(true)
        equal(win.DrawerOpen,true)
        equal(win.Root.Sidebar.Visible,true)
        win:SelectTab(1,true)
        equal(win.DrawerOpen,false)
        lib:Destroy()
    end
end)

test("Mobile window can be dragged, clamped and does not snap back", function()
    local lib,win=phone(844,390)
    local input=Mock.Services.UserInputService
    local gesture=touch(200,100)
    local x,y=win.Position.X.Offset,win.Position.Y.Offset
    win.TitleBar.DragArea.InputBegan:Fire(gesture)
    gesture.Position=Vector2.new(220,110);input.InputChanged:Fire(gesture)
    equal(win.Position.X.Offset,x+20)
    equal(win.Position.Y.Offset,y+10)
    local other=touch(1000,1000)
    input.InputChanged:Fire(other);input.InputEnded:Fire(other)
    equal(win.Position.X.Offset,x+20)
    gesture.Position=Vector2.new(9999,9999);input.InputChanged:Fire(gesture)
    inBounds(win,844,390)
    gesture.Position=Vector2.new(-9999,-9999);input.InputChanged:Fire(gesture)
    equal(win.Position.X.Offset,16);equal(win.Position.Y.Offset,16)
    input.InputEnded:Fire(gesture)
    win.RefreshLayout()
    equal(win.Position.X.Offset,16);equal(win.Position.Y.Offset,16)
    lib:Destroy()
end)

test("Rotation reflows the panel and cancels an old drag gesture", function()
    local lib,win=phone(390,844)
    local gesture=touch(100,100)
    win.TitleBar.DragArea.InputBegan:Fire(gesture)
    setViewport(844,390);Scheduler.flush()
    inBounds(win,844,390)
    local x,y=win.Position.X.Offset,win.Position.Y.Offset
    gesture.Position=Vector2.new(400,400);Mock.Services.UserInputService.InputChanged:Fire(gesture)
    equal(win.Position.X.Offset,x);equal(win.Position.Y.Offset,y)
    assert(win.Size.X.Offset>win.Size.Y.Offset)
    setViewport(390,844);Scheduler.flush()
    inBounds(win,390,844)
    assert(win.Size.X.Offset<win.Size.Y.Offset)
    equal(win.ContentTop,108)
    lib:Destroy()
end)

test("Portrait keyboard avoids overlap and restores the original window position", function()
    local lib,win=phone(390,844)
    local x,y,height=win.Position.X.Offset,win.Position.Y.Offset,win.Size.Y.Offset
    local input=Mock.Services.UserInputService
    input.OnScreenKeyboardSize=Vector2.new(390,300);input.OnScreenKeyboardVisible=true
    input:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Fire();Scheduler.flush()
    inBounds(win,390,544)
    equal(win.Scale.Scale,1)
    input.OnScreenKeyboardVisible=false
    input:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Fire();Scheduler.flush()
    equal(win.Size.Y.Offset,height)
    equal(win.Position.X.Offset,x);equal(win.Position.Y.Offset,y)
    lib:Destroy()
end)

test("Landscape keyboard keeps the input area available and restores page controls", function()
    local lib,win=phone(844,390)
    local input=Mock.Services.UserInputService
    input.OnScreenKeyboardSize=Vector2.new(844,190);input.OnScreenKeyboardVisible=true
    input:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Fire();Scheduler.flush()
    inBounds(win,844,200)
    equal(win.ContentTop,64)
    assert(win.Size.Y.Offset-win.ContentTop-12>=80)
    equal(win.TabDisplay.Visible,false)
    equal(win.SearchButton.Frame.Visible,false)
    input.OnScreenKeyboardVisible=false
    input:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Fire();Scheduler.flush()
    equal(win.ContentTop,108)
    equal(win.TabDisplay.Visible,true)
    equal(win.SearchButton.Frame.Visible,true)
    equal(win.ProfileButton.Frame.Visible,true)
    lib:Destroy()
end)

test("Mobile search keeps tappable results above the landscape keyboard", function()
    local lib,win=phone(844,390)
    assert(win:ShowSearch("background"))
    local input=Mock.Services.UserInputService
    input.OnScreenKeyboardSize=Vector2.new(844,190);input.OnScreenKeyboardVisible=true
    input:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Fire();Scheduler.flush()
    local panel=win.SearchPanel
    equal(panel.Status.Visible,false)
    local panelHeight=win.Size.Y.Offset+panel.Frame.Size.Y.Offset
    local listHeight=panelHeight+panel.List.Size.Y.Offset
    assert(listHeight>=44,"keyboard left no tappable search results")
    assert(#panel.Rows>0)
    equal(panel.Rows[1].Frame.Size.Y.Offset,56)
    input.OnScreenKeyboardVisible=false
    input:GetPropertyChangedSignal("OnScreenKeyboardVisible"):Fire();Scheduler.flush()
    equal(panel.Status.Visible,true)
    equal(panel.Rows[1].Frame.Size.Y.Offset,70)
    lib:Destroy()
end)

test("Narrow mobile fields fill their card width and remain usable by touch", function()
    local lib,win=phone(390,844)
    local option=lib.Appearance.Controls.Source
    local card=option._Element
    local width=win.Size.X.Offset-2*win.ContentLeft-8
    card.Frame.AbsoluteSize=Vector2.new(width,120)
    card.Frame:GetPropertyChangedSignal("AbsoluteSize"):Fire()
    local field
    for _,node in ipairs(card.Frame:GetChildren())do
        if node.ClassName=="Frame" and node:FindFirstChild("TextBox",true)then field=node end
        for _,child in ipairs(node:GetChildren())do
            if child:FindFirstChildOfClass("TextBox")then field=node end
        end
    end
    assert(field,"background URL control was not found")
    equal(field.Size.X.Offset,width-28)
    equal(field.Size.Y.Offset,44)
    lib:Destroy()
end)

test("Desktop layout, forced mode and mouse-first touch screens stay supported", function()
    local input=Mock.Services.UserInputService
    input.OnScreenKeyboardVisible=false;input.TouchEnabled=true
    input.KeyboardEnabled=true;input.PreferredInput=Enum.PreferredInput.KeyboardAndMouse
    setViewport(1366,768)
    local lib=loadLibrary()
    local win=lib:CreateWindow({Title="Desktop",Logo=false})
    win:AddTab({Title="Overview"});Scheduler.flush()
    equal(win.Mobile,false)
    equal(win.Size.X.Offset,840);equal(win.Size.Y.Offset,560)
    equal(win.ContentTop,120);equal(win.TitleBar.Frame.Size.Y.Offset,64)
    input.PreferredInput=Enum.PreferredInput.Touch
    input:GetPropertyChangedSignal("PreferredInput"):Fire()
    equal(win.Mobile,true)
    input.PreferredInput=Enum.PreferredInput.KeyboardAndMouse
    input:GetPropertyChangedSignal("PreferredInput"):Fire()
    equal(win.Mobile,false)
    equal(win.Size.X.Offset,840);equal(win.Size.Y.Offset,560)
    lib:Destroy()
    local forced,forcedWin=phone(844,390,{Title="Forced desktop",Logo=false,MobileMode=false})
    equal(forcedWin.Mobile,false)
    inBounds(forcedWin,844,390)
    forced:Destroy()
end)

test("Minimize, rotation and restore keep the mobile panel accessible", function()
    local lib,win=phone(390,844)
    win:SetMinimized(true)
    equal(win.RestoreButton.Visible,true);equal(win.Root.Visible,false)
    setViewport(844,390);Scheduler.flush()
    win.RestoreButton.Activated:Fire()
    equal(win.Minimized,false);equal(win.Root.Visible,true)
    inBounds(win,844,390)
    lib:Destroy()
end)

print("All " .. completed .. " scenarios passed (Roblox APIs mocked).")
