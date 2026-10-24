-- Behavioral checks against the shipped bundle and unmodified upstream addons.
local passed = 0
local function check(name, callback)
    callback();passed+=1;print("PASS compatibility: "..name)
end
local function eq(a,b)assert(a==b,tostring(a).." ~= "..tostring(b))end
local function newWindow(method, extra)
    local lib=loadLibrary()
    local config={Title="API compatibility",Logo=false,Acrylic=false,Appearance=false,Profiles=true}
    for k,v in pairs(extra or {})do config[k]=v end
    local window=lib[method or "CreateWindow"](lib,config)
    return lib,window
end
local function input(key,mouse)
    return {KeyCode=Enum.KeyCode[key or "Unknown"],UserInputType=Enum.UserInputType[mouse or "Keyboard"],Position=Vector2.new(0,0)}
end

check("window, tab and section aliases share one implementation",function()
    for _,method in ipairs({"CreateWindow","AddWindow","Window"})do
        local lib,window=newWindow(method)
        eq(lib.Window,window);eq(lib.CreatedWindow,window)
        eq(lib:Window({Title="same"}),window)
        local tabs={window:AddTab({Title="Original"}),window:CreateTab({Title="Renewed"}),window:Tab({Title="Short"})}
        for i,tab in ipairs(tabs)do
            eq(tab.Index,i)
            tab:AddSection("Original"):AddToggle("old"..i,{Title="Old",Default=false})
            tab:CreateSection({Title="Renewed"}):CreateToggle("new"..i,{Title="New",Value=true})
            tab:Section("Short"):Toggle("short"..i,{Title="Short",Default=false})
            window:SelectTab(i,true);assert(tab.Selected)
        end
        eq(lib.Flags,lib.Options);assert(lib.Loaded and not lib.Unloaded)
        lib:Destroy()
    end
end)

check("all eight element types accept both signatures and aliases",function()
    local lib,window=newWindow()
    local tab=window:AddTab({Title="Mixed"})
    local configs={
        Button={Title="Button"},Paragraph={Title="Paragraph",Content="text"},Toggle={Title="Toggle",Value=true},
        Slider={Title="Slider",Value=4,Max=10},Dropdown={Title="Dropdown",Values={"one","two"},Value="two"},
        Input={Title="Input",Value="hello"},Keybind={Title="Keybind",Value=Enum.KeyCode.RightControl},
        Colorpicker={Title="Color",Value=Color3.fromRGB(10,20,30)},
    }
    for kind,config in pairs(configs)do
        for _,prefix in ipairs({"Add","Create",""})do
            local id=prefix..kind
            local option=tab[prefix..kind](tab,id,config)
            eq(option,lib.Options[id]);assert(option.Instance and type(option.Instance.CreatedAt)=="number")
            option.Instance:SetTitle("Title updated");eq(option.Instance.TitleLabel.Text,"Title updated")
            option.Instance.Title="Title again";eq(option.Instance.TitleLabel.Text,"Title again")
            option.Instance.Description="Description";eq(option.Instance.DescLabel.Text,"Description")
        end
        local configOnly=table.clone(config);configOnly.Id="table-"..kind
        eq(tab["Create"..kind](tab,configOnly),lib.Options[configOnly.Id])
    end
    local a=tab:AddToggle({Title="Automatic"});local b=tab:CreateInput({Title="Automatic"})
    assert(a.Id~=b.Id);eq(lib.Options[a.Id],a);eq(lib.Options[b.Id],b)
    tab:CreateColorPicker("caps",configs.Colorpicker);tab:AddTextBox("textalias",configs.Input)
    eq(configs.Toggle.Default,nil) -- Caller configuration tables stay untouched.
    lib:Destroy()
end)

check("paragraph content, alignment and original returned card fields",function()
    local lib,window=newWindow();local tab=window:AddTab({Title="Text"})
    local paragraph=tab:AddParagraph({Title="Old",Content="before"})
    assert(paragraph.Frame and paragraph.TitleLabel and paragraph.DescLabel)
    paragraph:SetDesc("old API");eq(paragraph.Value,"old API")
    local renewed=tab:CreateParagraph("paragraph",{Title="Renewed",Content="before",TitleAlignment="Middle",ContentAlignment=Enum.TextXAlignment.Right})
    local seen;renewed:OnChanged(function(value)seen=value end)
    renewed:SetContent("after");eq(seen,"after");eq(renewed.Value,"after");eq(renewed.DescLabel.Text,"after")
    renewed:SetValue("again");eq(renewed.DescLabel.Text,"again")
    eq(renewed.TitleLabel.TextXAlignment,Enum.TextXAlignment.Center);eq(renewed.DescLabel.TextXAlignment,Enum.TextXAlignment.Right)
    renewed:Destroy();eq(lib.Options.paragraph,nil);assert(renewed.Destroyed)
    lib:Destroy()
end)

check("Enum/string keybinds, all mouse formats and minimize binding",function()
    local lib,window=newWindow("CreateWindow",{MinimizeKey="RightControl"})
    local tab=window:AddTab({Title="Keys"});local key=tab:CreateKeybind("key",{Title="Key",Default=Enum.KeyCode.F6})
    eq(key.Value,"F6");key:SetValue("Enum.KeyCode.F7","Hold");eq(key.Value,"F7");eq(key.Mode,"Hold")
    local inputService=Mock.Services.UserInputService
    inputService.InputBegan:Fire(input("RightControl"));inputService.InputEnded:Fire(input("RightControl"));assert(window.Minimized)
    window:SetMinimized(false)
    for _,name in ipairs({"MB1","MouseButton1","LeftMousebutton","MouseLeft","MB2","MouseButton2","RightMousebutton","MouseRight","MB3"})do
        local count=0
        key:SetValue(name,"Toggle");key:OnClick(function()count+=1 end)
        local mouse=(name=="MB3"and "MouseButton3")or ((name:find("2")or name:find("Right"))and "MouseButton2"or "MouseButton1")
        inputService.InputBegan:Fire(input(nil,mouse));eq(count,1)
    end
    key:SetValue(Enum.UserInputType.MouseButton2,"Hold");eq(key.Value,"MouseButton2")
    local oldMouse=inputService.IsMouseButtonPressed
    inputService.IsMouseButtonPressed=function(_,button)return button==Enum.UserInputType.MouseButton2 end
    assert(key:GetState());inputService.IsMouseButtonPressed=oldMouse
    assert(lib.Profiles:Save("mouse"));key:SetValue("F8");assert(lib.Profiles:Load("mouse"));eq(key.Value,"MouseButton2")
    lib:Destroy()
end)

check("inline toggle keybind controls the same toggle and cleans up",function()
    local lib,window=newWindow();local tab=window:CreateTab({Title="Inline"})
    local toggle=tab:CreateToggle("toggle",{Title="Toggle",Default=false})
    local key=toggle:Keybind("inline-key",{Default="F6"})
    eq(toggle.Keybind,key);eq(key.Instance,toggle.Instance)
    Mock.Services.UserInputService.InputBegan:Fire(input("F6"));assert(toggle.Value)
    key:Destroy();eq(lib.Options["inline-key"],nil);assert(not toggle.Instance.Destroyed)
    Mock.Services.UserInputService.InputBegan:Fire(input("F6"));assert(toggle.Value)
    toggle:Destroy();eq(lib.Options.toggle,nil);lib:Destroy()
end)

check("dropdown display functions, object values, maps and defaults",function()
    local lib,window=newWindow();local tab=window:AddTab({Title="Dropdowns"})
    local object=Instance.new("Folder")
    local dropdown=tab:CreateDropdown("d",{Title="Objects",Values={first=object,second=Enum.KeyCode.F6},Default=object,Displayer=function(value)return value==object and "Folder"or "Key"end})
    eq(dropdown.Value,object);eq(#dropdown.Values,2)
    dropdown:SetValue(Enum.KeyCode.F6);eq(dropdown.Value,Enum.KeyCode.F6)
    local multi=tab:Dropdown("multi",{Title="Multi",Values={"a","b","c"},Default={"b","c"},Multi=true,AllowNull=true,AutoDeselect=true})
    assert(multi.Value.b and multi.Value.c)
    multi:SetValue({a=true,b=false});assert(multi.Value.a and not multi.Value.b)
    multi:Open();multi.Buttons[3].Activated:Fire();assert(not multi.Opened and multi.Value.c)
    multi:SetValues({only="a"});eq(#multi.Values,1);assert(multi.Value.a and not multi.Value.c)
    local single=tab:AddDropdown("single",{Title="Single",Values={false,true},Default=false});eq(single.Value,false)
    local number=tab:AddDropdown("number",{Title="Number",Values={5,10},Default=2});eq(number.Value,10)
    lib:Destroy()
end)

check("slider defaults, old-value callbacks and zero-length ranges",function()
    local lib,window=newWindow();local tab=window:AddTab({Title="Sliders"})
    local slider=tab:Slider("s",{Max=10,Value=5})
    local newValue,oldValue
    slider:OnChanged(function(value,old)newValue,oldValue=value,old end)
    slider:SetValue(7);eq(newValue,7);eq(oldValue,5)
    slider:SetValue(99);eq(slider.Value,10)
    local fixed=tab:CreateSlider("fixed",{Title="Fixed",Min=2,Max=2,Default=2});fixed:SetValue(7);eq(fixed.Value,2)
    local reversed=tab:CreateSlider("reversed",{Title="Reversed",Min=1,Max=0,Default=99});eq(reversed.Value,1)
    lib:Destroy()
end)

check("Renewed input clearing preserves its committed value on mobile",function()
    local lib,window=newWindow();local tab=window:AddTab({Title="Input"})
    local option=tab:CreateInput("input",{Title="Input",Finished=true,ClearOnFocusLost=true})
    local field
    for _,node in ipairs(option.Instance.Frame:GetDescendants())do if node.ClassName=="TextBox"then field=node end end
    assert(field);field.Text="committed";field.FocusLost:Fire(false)
    eq(option.Value,"committed");eq(field.Text,"")
    lib:Destroy()
end)

check("all Renewed themes and atlas icons are actually present",function()
    local lib,window=newWindow()
    eq(#lib.Themes,58)
    for _,name in ipairs(lib.Themes)do lib:SetTheme(name);eq(lib.Theme,name);assert(lib.Utilities.Creator.GetThemeProperty("Text"))end
    lib:SetTheme("Amethyst Dark");eq(lib.Theme,"Amethyst Dark")
    local icon=lib.Utilities:GetIcon("phosphor-users-bold");assert(icon and icon.ImageRectSize.X==64)
    local tab=window:CreateTab({Title="Icon",Icon="phosphor-users-bold"})
    eq(tab.Icon.Image,icon.Image);eq(tab.Icon.ImageRectOffset.X,icon.ImageRectOffset.X);eq(tab.Icon.ImageRectSize.X,64)
    assert(lib:GetIcon("settings") and lib:GetIcon("lucide-settings"))
    lib.Utilities.Icons:SetIcon(tab.Icon,"settings");eq(tab.Icon.ImageRectSize.X,0)
    local count=0
    for _,name in ipairs(UpstreamIconNames)do
        local data=lib.Utilities:GetIcon(name);assert(data and data.Image and data.ImageRectOffset and data.ImageRectSize,name);count+=1
    end
    eq(count,10616);lib:Destroy()
end)

check("lifecycle, theme and window events fire with valid state",function()
    local lib,window=newWindow();local count=0
    lib.ThemeChanged:Once(function(name)eq(name,"Aqua");count+=1 end)
    lib:SetTheme("Aqua");lib:SetTheme("Dark");Scheduler.flush();eq(count,1)
    window.PostMinimized:Connect(function(_,visible)eq(visible,not window.Minimized);count+=1 end)
    window:SetMinimized(true);Scheduler.flush();window:SetMinimized(false);Scheduler.flush();eq(count,3)
    window.PostMaximized:Connect(function()count+=1 end)
    window.Maximize(true);window.Maximize(false);Scheduler.flush();eq(count,5)
    lib.OnUnload:Connect(function()assert(lib.Unloaded and not lib.Loaded);count+=1 end)
    lib.PostUnload:Connect(function()assert(window.Destroyed);count+=1 end)
    lib:Destroy();Scheduler.flush();eq(count,7)
end)

check("dialog close signal resumes Yield and survives window destruction",function()
    local lib,window=newWindow();local returned=false
    task.spawn(function()window:Dialog({Title="Yield",Content="Text",Yield=true,Buttons={{Title="OK"}}});returned=true end)
    Scheduler.flush();assert(not returned)
    lib:Destroy();Scheduler.flush();assert(returned)
end)

check("actual original and Renewed managers create controls and round-trip configs",function()
    for _,loaders in ipairs(AddonFamilies)do
        local lib,window=newWindow()
        local section=window:CreateTab({Title="Settings"})
        local interface,save=loaders.Interface(),loaders.Save()
        interface:SetLibrary(lib);interface:SetFolder("Compat/"..loaders.Name)
        save:SetLibrary(lib);save:SetFolder("Compat/"..loaders.Name.."/Game");save:IgnoreThemeSettings()
        interface:BuildInterfaceSection(section);save:BuildConfigSection(section)
        assert(lib.MinimizeKeybind and lib.MinimizeKeybind.Value=="LeftControl")
        local main=window:CreateTab({Title="Main"})
        local toggle=main:CreateToggle("round-toggle",{Title="Toggle",Default=true})
        local slider=main:AddSlider("round-slider",{Title="Slider",Min=0,Max=10,Default=7})
        local text=main:Input("round-input",{Title="Input",Value="saved"})
        local multi=main:CreateDropdown("round-multi",{Title="Multi",Multi=true,Values={"a","b"},Default={"b"}})
        local key=main:CreateKeybind("round-key",{Title="Key",Default=Enum.KeyCode.F8})
        local color=main:AddColorpicker("round-color",{Title="Color",Default=Color3.fromRGB(32,64,128),Transparency=0.3})
        assert(save:Save("test"))
        if loaders.Name~="original"then
            local document=Mock.Services.HttpService:JSONDecode(Mock.Files[save.Folder.."/settings/test.json"])
            local previous=0
            for _,entry in ipairs(document.objects)do assert(entry.Timestamp>=previous);previous=entry.Timestamp end
        end
        toggle:SetValue(false);slider:SetValue(1);text:SetValue("changed");multi:SetValue({a=true});key:SetValue("F9");color:SetValueRGB(Color3.new(1,0,0),0)
        assert(save:Load("test"));Scheduler.flush()
        assert(toggle.Value);eq(slider.Value,7);eq(text.Value,"saved");assert(multi.Value.b and not multi.Value.a);eq(key.Value,"F8")
        eq(color.Value:ToHex(),"204080");eq(color.Transparency,0.3)
        eq(save:RefreshConfigList()[1],"test")
        Mock.Files[save.Folder.."/settings/autoload.txt"]="test"
        slider:SetValue(2);save:LoadAutoloadConfig();Scheduler.flush();eq(slider.Value,7)
        lib:Destroy();Scheduler.flush()
    end
end)

check("Renewed Resize and Mobile options preserve a usable phone panel",function()
    local camera=Mock.Services.Workspace.CurrentCamera
    local inputService=Mock.Services.UserInputService
    local before=camera.ViewportSize;local touch,keyboard=inputService.TouchEnabled,inputService.KeyboardEnabled
    camera.ViewportSize=Vector2.new(390,844);inputService.TouchEnabled=true;inputService.KeyboardEnabled=false
    local lib,window=newWindow("CreateWindow",{Size=UDim2.fromOffset(830,525),MinSize=Vector2.new(470,380),Resize=true,
        Mobile={Size=UDim2.fromOffset(30,30),GetIcon=function(minimized)return minimized and "phosphor-eye"or "phosphor-eye-slash"end}})
    window:CreateTab({Title="Phone"});Scheduler.flush()
    assert(window.Mobile);eq(window.Size.X.Offset,351);eq(window.Size.Y.Offset,525)
    assert(window.Size.Y.Offset-window.ContentTop>300)
    window:SetMinimized(true);assert(window.RestoreIcon and window.RestoreButton.Visible)
    eq(window.RestoreButton.Size.X.Offset,44);eq(window.RestoreIcon.ImageRectSize.X,64)
    window.RestoreButton.Activated:Fire();assert(not window.Minimized)
    lib:Destroy();camera.ViewportSize=before;inputService.TouchEnabled=touch;inputService.KeyboardEnabled=keyboard
end)

for _,notice in ipairs(Mock.Notices)do assert(notice.Content~="Callback error",tostring(notice.SubContent))end
print("All "..passed.." compatibility scenarios passed (Roblox APIs mocked).")
