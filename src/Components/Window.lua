-- Bloomware UI, based on Fluent by dawid (MIT).
local UserInputService=game:GetService("UserInputService")
local Workspace=game:GetService("Workspace")
local Creator=require(script.Parent.Parent.Creator)
local Flipper=require(script.Parent.Parent.Packages.Flipper)
local Acrylic=require(script.Parent.Parent.Acrylic)
local Assets=require(script.Parent.Assets)
local New=Creator.New
local Compatibility=require(script.Parent.Parent.Compatibility)
return function(config)
    local Library=require(script.Parent.Parent)
    local camera=Workspace.CurrentCamera
    local viewport=camera and camera.ViewportSize or Vector2.new(1280,720)
    local minimum=config.MinSize or Vector2.new(560,380)
    local minWidth,minHeight=math.clamp(minimum.X,240,2048),math.clamp(minimum.Y,180,2048)
    local width=config.Size.X.Offset+config.Size.X.Scale*viewport.X
    local height=config.Size.Y.Offset+config.Size.Y.Scale*viewport.Y
    if config.Resize==true and not Compatibility.MobileMode(config.MobileMode,viewport,UserInputService) then
        width,height=Library.Utilities:Resize(width,height)
        minWidth,minHeight=Library.Utilities:Resize(minWidth,minHeight)
        minWidth,minHeight=math.max(240,minWidth),math.max(180,minHeight)
    end
    width,height=math.max(minWidth,width),math.max(minHeight,height)
    local Window={Minimized=false,Maximized=false,Destroyed=false,CurrentPos=0,Mobile=false,
        Size=UDim2.fromOffset(width,height),Position=UDim2.fromOffset(0,0),TabWidth=config.TabWidth,
        ContentTop=120,ContentLeft=config.TabWidth+30,ToolActive=nil,DrawerOpen=false,
        MinSize=Vector2.new(minWidth,minHeight),Config=config,
        OnMinimized=Compatibility.Signal(),PostMinimized=Compatibility.Signal(),
        OnMaximized=Compatibility.Signal(),PostMaximized=Compatibility.Signal()}
    Window.AcrylicPaint=Acrylic.AcrylicPaint()
    Window.Scale=New("UIScale",{Scale=1})
    Window.Root=New("Frame",{Name="BloomwareWindow",BackgroundTransparency=1,Size=Window.Size,Parent=config.Parent},{Window.AcrylicPaint.Frame,Window.Scale})
    local root=Window.Root
    local sidebar=New("Frame",{Name="Sidebar",Position=UDim2.fromOffset(10,74),Size=UDim2.new(0,Window.TabWidth,1,-86),
        BackgroundTransparency=0.12,Parent=root,ThemeTag={BackgroundColor3="Sidebar"}},{New("UICorner",{CornerRadius=UDim.new(0,12)})})
    New("TextLabel",{Text="WORKSPACE",TextSize=10,FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Bold),
        TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(1,-24,0,16),Position=UDim2.fromOffset(14,12),Parent=sidebar,ThemeTag={TextColor3="SubText"}})
    Window.TabHolder=New("ScrollingFrame",{Name="Tabs",Size=UDim2.new(1,-16,1,-74),Position=UDim2.fromOffset(8,36),BackgroundTransparency=1,
        ScrollBarThickness=2,ScrollBarImageTransparency=0.6,CanvasSize=UDim2.fromOffset(0,0),ScrollingDirection=Enum.ScrollingDirection.Y,Parent=sidebar,
        ThemeTag={ScrollBarImageColor3="Accent"}},{New("UIListLayout",{Padding=UDim.new(0,6),SortOrder=Enum.SortOrder.LayoutOrder})})
    New("Frame",{Size=UDim2.new(1,-24,0,1),Position=UDim2.new(0,12,1,-31),BackgroundTransparency=0.35,Parent=sidebar,ThemeTag={BackgroundColor3="TitleBarLine"}})
    New("TextLabel",{Text="BLOOMWARE  /  UI",TextSize=9,FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Medium),
        Size=UDim2.new(1,-24,0,20),Position=UDim2.new(0,12,1,-26),TextXAlignment=Enum.TextXAlignment.Left,Parent=sidebar,ThemeTag={TextColor3="SubText"}})
    Window.TabDisplay=New("TextLabel",{Name="PageTitle",Text="",TextSize=26,RichText=true,FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Bold),
        TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,Size=UDim2.new(1,-Window.TabWidth-52,0,32),
        Position=UDim2.fromOffset(Window.TabWidth+30,78),Parent=root,ThemeTag={TextColor3="Text"}})
    Window.ContainerHolder=New("CanvasGroup",{Name="PageContent",BackgroundTransparency=1,Size=UDim2.new(1,-Window.TabWidth-46,1,-136),
        Position=UDim2.fromOffset(Window.TabWidth+30,120),Parent=root})
    Window.ContainerBackMotor=Flipper.SingleMotor.new(0)
    Window.ContainerPosMotor=Flipper.SingleMotor.new(120)
    Window.SelectorPosMotor=Flipper.SingleMotor.new(0)
    Window.SelectorSizeMotor=Flipper.SingleMotor.new(16)
    Window.ContainerBackMotor:onStep(function(value)Window.ContainerHolder.GroupTransparency=value end)
    Window.ContainerPosMotor:onStep(function(value)Window.ContainerHolder.Position=UDim2.fromOffset(Window.ContentLeft,value)end)
    Window.TitleBar=require(script.Parent.TitleBar)({Title=config.Title,SubTitle=config.SubTitle,Logo=config.Logo,Parent=root,Window=Window})
    if Library.UseAcrylic then Window.AcrylicPaint.AddParent(root)end
    local scrim=New("TextButton",{Name="NavigationBackdrop",Text="",Visible=false,ZIndex=20,Size=UDim2.new(1,0,1,-64),Position=UDim2.fromOffset(0,64),
        BackgroundColor3=Color3.fromRGB(0,0,0),BackgroundTransparency=0.35,Parent=root})
    function Window:SetDrawer(open)
        self.DrawerOpen=self.Mobile and open==true
        sidebar.Visible=not self.Mobile or self.DrawerOpen
        scrim.Visible=self.DrawerOpen
        if self.DrawerOpen then Library:ClosePopups()end
    end
    Creator.AddSignal(scrim.Activated,function()Window:SetDrawer(false)end)

    local function toolButton(name,icon,text)
        local frame=New("TextButton",{Name=name,Text="",Size=UDim2.fromOffset(100,36),BackgroundTransparency=0.88,Parent=root,
            ThemeTag={BackgroundColor3="Tab"}},{New("UICorner",{CornerRadius=UDim.new(0,9)})})
        local image=New("ImageLabel",{Image=Library:GetIcon(icon) or "",Size=UDim2.fromOffset(16,16),Position=UDim2.new(0,10,0.5,-8),Parent=frame,ThemeTag={ImageColor3="SubText"}})
        local label=New("TextLabel",{Text=text,TextSize=12,Size=UDim2.new(1,-36,1,0),Position=UDim2.fromOffset(32,0),TextXAlignment=Enum.TextXAlignment.Left,
            FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Medium),Parent=frame,ThemeTag={TextColor3="SubText"}})
        return {Frame=frame,Icon=image,Label=label}
    end
    Window.SearchButton=toolButton("OpenSearch","search","Search")
    Window.ProfileButton=toolButton("OpenProfiles","folder","Profiles")
    Window.SearchButton.Frame.Visible=config.Search
    Window.ProfileButton.Frame.Visible=config.Profiles
    Window.SearchPanel=config.Search and require(script.Parent.SearchPanel)(Window,Library) or nil
    Window.ProfilePanel=config.Profiles and require(script.Parent.ProfilePanel)(Window,Library) or nil
    local tabs=require(script.Parent.Tab):Init(Window)
    function Window:CloseTools()
        self.ToolActive=nil
        if self.SearchPanel then self.SearchPanel:Close()end
        if self.ProfilePanel then self.ProfilePanel:Close()end
        self.ContainerHolder.Visible=true
        local selected=tabs.Tabs[tabs.SelectedTab]
        self.TabDisplay.Text=selected and selected.Name or ""
    end
    function Window:ShowSearch(query)
        if not self.SearchPanel or Library.DialogOpen then return false end
        self:CloseTools();self:SetDrawer(false);Library:ClosePopups()
        self.ToolActive="Search";self.TabDisplay.Text="Search";self.ContainerHolder.Visible=false
        self.SearchPanel:Open(query)
        return true
    end
    function Window:ShowProfiles()
        if not self.ProfilePanel or Library.DialogOpen then return false end
        self:CloseTools();self:SetDrawer(false);Library:ClosePopups()
        self.ToolActive="Profiles";self.TabDisplay.Text="Profiles";self.ContainerHolder.Visible=false
        self.ProfilePanel:Open()
        return true
    end
    Creator.AddSignal(Window.SearchButton.Frame.Activated,function()if Window.ToolActive=="Search"then Window:CloseTools()else Window:ShowSearch()end end)
    Creator.AddSignal(Window.ProfileButton.Frame.Activated,function()if Window.ToolActive=="Profiles"then Window:CloseTools()else Window:ShowProfiles()end end)
    function Window:Reveal(entry)
        local card,tab=entry.Card,entry.Tab
        if not card or card.Destroyed or not tab or not tabs.Tabs[tab.Index]then return false end
        self:SelectTab(tab.Index,true)
        task.defer(function()
            if self.Destroyed or card.Destroyed or tabs.SelectedTab~=tab.Index then return end
            local scroll=tab.Container
            local scale=Creator.GetScale(scroll)
            local position=scroll.CanvasPosition or Vector2.new(0,0)
            local target=position.Y+(card.Frame.AbsolutePosition.Y-scroll.AbsolutePosition.Y)/scale-12
            local maximum=math.max(0,scroll.CanvasSize.Y.Offset-scroll.AbsoluteSize.Y/scale)
            scroll.CanvasPosition=Vector2.new(0,math.clamp(target,0,maximum))
            card.SearchGeneration=(card.SearchGeneration or 0)+1
            local generation=card.SearchGeneration
            Creator.OverrideTag(card.Border,{Color="Accent"});card.Border.Transparency=0.05
            task.delay(1.4,function()
                if not card.Destroyed and card.SearchGeneration==generation then Creator.OverrideTag(card.Border,{Color="ElementBorder"});card.Border.Transparency=0.52 end
            end)
        end)
        return true
    end
    function Window:AddTab(options)return tabs:New(options.Title,options.Icon,self.TabHolder)end
    function Window:CreateTab(options)return self:AddTab(options)end
    function Window:Tab(options)return self:AddTab(options)end
    function Window:SelectTab(index,instant)return tabs:SelectTab(index,instant)end

    local grip=New("TextButton",{Name="ResizeGrip",Text="",Size=UDim2.fromOffset(26,26),Position=UDim2.new(1,-26,1,-26),BackgroundTransparency=1,Parent=root})
    for index=1,3 do New("Frame",{Size=UDim2.fromOffset(2,2),Position=UDim2.fromOffset(9+index*3,20-index*3),BackgroundTransparency=0.2,Parent=grip,
        ThemeTag={BackgroundColor3="SubText"}},{New("UICorner",{CornerRadius=UDim.new(1,0)})})end
    Window.RestoreButton=New("TextButton",{Name="BloomwareRestore",Text="B",TextSize=22,Visible=false,Size=UDim2.fromOffset(52,52),
        Position=UDim2.fromOffset(viewport.X-68,math.max(8,viewport.Y/2-26)),ZIndex=100,Parent=config.Parent,
        FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json",Enum.FontWeight.Bold),ThemeTag={BackgroundColor3="Sidebar",TextColor3="Accent"}},
        {New("UICorner",{CornerRadius=UDim.new(0,16)}),New("UIStroke",{Thickness=1,Transparency=0.2,ThemeTag={Color="Accent"}})})
    local function updateRestoreIcon()
        local mobile=config.Mobile
        if type(mobile)~="table" or type(mobile.GetIcon)~="function" then return end
        local ok,icon=pcall(mobile.GetIcon,Window.Minimized)
        if not ok or not icon then return end
        if not Window.RestoreIcon then
            Window.RestoreIcon=New("ImageLabel",{Size=UDim2.new(1,-16,1,-16),Position=UDim2.fromOffset(8,8),
                Parent=Window.RestoreButton,ThemeTag={ImageColor3="Accent"}})
        end
        if Library.Utilities.Icons:SetIcon(Window.RestoreIcon,icon)then Window.RestoreButton.Text=""end
        if mobile.Size then Window.RestoreButton.Size=UDim2.fromOffset(math.clamp(mobile.Size.X.Offset,44,60),math.clamp(mobile.Size.Y.Offset,44,60))end
    end
    updateRestoreIcon()
    local floatingInput,floatingOrigin,floatingPosition,floatingMoved,lastFloatingDrag
    local dragInput,dragOrigin,dragPosition,resizeInput,resizeOrigin,resizeSize
    Creator.AddSignal(Window.RestoreButton.InputBegan,function(input)
        if input.UserInputType==Enum.UserInputType.Touch or input.UserInputType==Enum.UserInputType.MouseButton1 then
            floatingInput,floatingOrigin,floatingPosition,floatingMoved=input,input.Position,Window.RestoreButton.Position,false
        end
    end,root)
    Creator.AddSignal(Window.RestoreButton.Activated,function()
        if not lastFloatingDrag or os.clock()-lastFloatingDrag>0.18 then Window:SetMinimized(false)end
    end,root)
    local function keyboardHeight()
        if not Window.Mobile or not UserInputService.OnScreenKeyboardVisible then return 0 end
        local size=UserInputService.OnScreenKeyboardSize
        return size and math.clamp(size.Y,0,math.max(0,viewport.Y-140)) or 0
    end
    local lastMobile,desktopSize,desktopPosition=nil,Window.Size,nil
    local lastViewport,wasKeyboardOpen,beforeKeyboardPosition=nil,false,nil
    local cameraConnection
    local function fit(center)
        if Window.Destroyed then return end
        camera=Workspace.CurrentCamera;viewport=camera and camera.ViewportSize or viewport
        local viewportChanged=lastViewport and (lastViewport.X~=viewport.X or lastViewport.Y~=viewport.Y)
        local mobile=Compatibility.MobileMode(config.MobileMode,viewport,UserInputService)
        local modeChanged=lastMobile~=mobile
        if modeChanged or viewportChanged then dragInput=nil;resizeInput=nil end
        if mobile and lastMobile==false then desktopSize,desktopPosition=Window.Size,Window.Position end
        if not mobile and lastMobile==true then Window.Size=desktopSize;Window.Position=desktopPosition or Window.Position;Window.Maximized=false;center=true end
        Window.Mobile=mobile;Library.Mobile=mobile
        local scale,x,y=1,Window.Position.X.Offset,Window.Position.Y.Offset
        local availableHeight=viewport.Y-keyboardHeight()
        local keyboardOpen=mobile and availableHeight<viewport.Y
        if mobile then
            Window.Maximized=false
            local portrait=viewport.Y>viewport.X
            local margin=math.min(16,math.floor(math.min(viewport.X,availableHeight)*0.05))
            local normalWidth=math.floor(math.min(width,720,viewport.X*(portrait and 0.90 or 0.82),viewport.X-2*margin))
            local normalHeight=math.floor(math.min(height,560,viewport.Y*(portrait and 0.74 or 0.82)))
            -- Floating panel in physical UI pixels: keep text/touch targets readable.
            -- The viewport constrains the panel; it must not become the panel's size.
            Window.Size=UDim2.fromOffset(
                math.max(1,normalWidth),math.max(1,math.floor(math.min(normalHeight,availableHeight-2*margin))))
            if modeChanged or viewportChanged then beforeKeyboardPosition=nil end
            if keyboardOpen and (modeChanged or viewportChanged) then
                beforeKeyboardPosition=UDim2.fromOffset((viewport.X-normalWidth)/2,(viewport.Y-normalHeight)/2)
            elseif keyboardOpen and not wasKeyboardOpen then beforeKeyboardPosition=Window.Position end
            if not keyboardOpen and wasKeyboardOpen and beforeKeyboardPosition then
                x,y=beforeKeyboardPosition.X.Offset,beforeKeyboardPosition.Y.Offset
                beforeKeyboardPosition=nil
            end
            if center or modeChanged or viewportChanged then
                x,y=(viewport.X-Window.Size.X.Offset)/2,(availableHeight-Window.Size.Y.Offset)/2
            end
            x=math.clamp(x,margin,math.max(margin,viewport.X-Window.Size.X.Offset-margin))
            y=math.clamp(y,margin,math.max(margin,availableHeight-Window.Size.Y.Offset-margin))
        else
            if Window.Maximized then Window.Size=UDim2.fromOffset(viewport.X,viewport.Y)end
            if not Window.Maximized and config.AutoScale then scale=math.max(0.05,math.min(1,(viewport.X-24)/Window.Size.X.Offset,(viewport.Y-24)/Window.Size.Y.Offset))end
            if center then x,y=(viewport.X-Window.Size.X.Offset*scale)/2,(viewport.Y-Window.Size.Y.Offset*scale)/2 end
            if Window.Maximized then x,y=0,0 else
                x=math.clamp(x,0,math.max(0,viewport.X-Window.Size.X.Offset*scale));y=math.clamp(y,0,math.max(0,viewport.Y-Window.Size.Y.Offset*scale))
            end
        end
        Window.Scale.Scale=scale;root.Size=Window.Size
        Window.Position=UDim2.fromOffset(x,y);root.Position=Window.Position
        local compactKeyboard=mobile and keyboardOpen and availableHeight<300
        local headerHeight=mobile and 56 or 64
        local padding=mobile and 12 or 16
        local previousContentTop=Window.ContentTop
        Window.TabWidth=mobile and math.min(260,Window.Size.X.Offset-24) or math.clamp(config.TabWidth,128,math.min(220,Window.Size.X.Offset*0.28))
        Window.ContentLeft=mobile and padding or Window.TabWidth+30
        Window.ContentTop=mobile and (compactKeyboard and 64 or 108) or 120
        if previousContentTop~=Window.ContentTop then Window.ContainerPosMotor:setGoal(Flipper.Instant.new(Window.ContentTop))end
        sidebar.Position=UDim2.fromOffset(10,headerHeight+(mobile and 8 or 10))
        sidebar.Size=UDim2.new(0,Window.TabWidth,1,-headerHeight-(mobile and 20 or 22));sidebar.ZIndex=mobile and 30 or 1
        sidebar.BackgroundTransparency=mobile and 0 or 0.12
        scrim.Position=UDim2.fromOffset(0,headerHeight);scrim.Size=UDim2.new(1,0,1,-headerHeight)
        if modeChanged then Window:SetDrawer(false)end
        Window.TitleBar:Layout(mobile)
        Window.TitleBar.MaxButton.Frame.Icon.Image=Window.Maximized and Assets.Restore or Assets.Max
        Window.TabDisplay.Visible=not compactKeyboard
        Window.TabDisplay.Position=UDim2.fromOffset(Window.ContentLeft,mobile and 66 or 78);Window.TabDisplay.TextSize=mobile and 20 or 26
        Window.SearchButton.Frame.Visible=config.Search and not compactKeyboard
        Window.ProfileButton.Frame.Visible=config.Profiles and not compactKeyboard
        local toolWidth=mobile and 44 or 100
        local toolCount=(config.Search and 1 or 0)+(config.Profiles and 1 or 0)
        local reserved=toolCount>0 and toolCount*(toolWidth+8) or 0
        Window.TabDisplay.Size=UDim2.new(1,-Window.ContentLeft-padding-reserved,0,32)
        local right=padding
        for _,button in ipairs({Window.ProfileButton,Window.SearchButton})do
            if button.Frame.Visible then
                button.Frame.Size=UDim2.fromOffset(toolWidth,mobile and 44 or 36)
                button.Frame.Position=UDim2.new(1,-right-toolWidth,0,mobile and 60 or 76)
                button.Label.Visible=not mobile;button.Icon.Position=UDim2.new(0,mobile and 14 or 10,0.5,-8)
                right=right+toolWidth+8
            end
        end
        for _,frame in ipairs({Window.ContainerHolder,Window.SearchPanel and Window.SearchPanel.Frame or false,Window.ProfilePanel and Window.ProfilePanel.Frame or false})do
            if frame then frame.Position=UDim2.fromOffset(Window.ContentLeft,Window.ContentTop);frame.Size=UDim2.new(1,-Window.ContentLeft-padding,1,-Window.ContentTop-padding)end
        end
        if Window.SearchPanel then Window.SearchPanel:Layout()end
        if Window.ProfilePanel then Window.ProfilePanel:Layout(mobile)end
        grip.Visible=not mobile and not Window.Maximized
        local fp=Window.RestoreButton.Position
        Window.RestoreButton.Position=UDim2.fromOffset(math.clamp(fp.X.Offset,8,math.max(8,viewport.X-60)),math.clamp(fp.Y.Offset,8,math.max(8,viewport.Y-60)))
        if modeChanged then Library._LayoutEvent:Fire(mobile)end
        lastMobile=mobile;lastViewport=viewport;wasKeyboardOpen=keyboardOpen
        Library:ClosePopups()
    end
    Window.RefreshLayout=function()fit(false)end
    local function keepFocusVisible()
        if not Window.Mobile then return end
        local focused=UserInputService:GetFocusedTextBox()
        if not focused or focused.MultiLine then return end
        local ancestor=focused.Parent
        while ancestor and ancestor~=root do
            if ancestor:IsA("ScrollingFrame")then
                local scale=Creator.GetScale(ancestor)
                local pos=ancestor.CanvasPosition or Vector2.new(0,0)
                local delta=focused.AbsolutePosition.Y+focused.AbsoluteSize.Y-(ancestor.AbsolutePosition.Y+ancestor.AbsoluteSize.Y-10)
                if focused.AbsolutePosition.Y<ancestor.AbsolutePosition.Y+10 then delta=focused.AbsolutePosition.Y-ancestor.AbsolutePosition.Y-10 end
                if delta>0 or focused.AbsolutePosition.Y<ancestor.AbsolutePosition.Y+10 then
                    ancestor.CanvasPosition=Vector2.new(pos.X,math.clamp(pos.Y+delta/scale,0,math.max(0,ancestor.CanvasSize.Y.Offset-ancestor.AbsoluteSize.Y/scale)))
                end
            end
            ancestor=ancestor.Parent
        end
    end
    local function bindCamera()
        if cameraConnection then cameraConnection:Disconnect()end
        camera=Workspace.CurrentCamera
        if camera then cameraConnection=Creator.AddSignal(camera:GetPropertyChangedSignal("ViewportSize"),function()fit(false)end,root)end
        fit(false)
    end
    Creator.AddSignal(Workspace:GetPropertyChangedSignal("CurrentCamera"),bindCamera,root)
    for _,property in ipairs({"OnScreenKeyboardVisible","OnScreenKeyboardSize"})do
        Creator.AddSignal(UserInputService:GetPropertyChangedSignal(property),function()fit(false);task.defer(keepFocusVisible)end,root)
    end
    for _,property in ipairs({"TouchEnabled","PreferredInput","KeyboardEnabled"})do
        Creator.AddSignal(UserInputService:GetPropertyChangedSignal(property),function()fit(false)end,root)
    end
    fit(true);bindCamera()
    local restoredSize,restoredPosition
    Window.Maximize=function(enabled,keepPosition)
        if Window.Mobile then return false end
        enabled=enabled==true;if enabled==Window.Maximized then return end
        Window.OnMaximized:Fire(os.clock())
        if enabled then restoredSize,restoredPosition=Window.Size,Window.Position;Window.Size=UDim2.fromOffset(viewport.X,viewport.Y)
        else Window.Size=restoredSize or UDim2.fromOffset(width,height);if not keepPosition then Window.Position=restoredPosition or Window.Position end end
        Window.Maximized=enabled;Window.TitleBar.MaxButton.Frame.Icon.Image=enabled and Assets.Restore or Assets.Max;fit(false)
        Window.PostMaximized:Fire(os.clock())
        return true
    end
    Creator.AddSignal(Window.TitleBar.DragArea.InputBegan,function(input)
        if Window.Minimized or Window.Destroyed or Library.DialogOpen or dragInput then return end
        if input.UserInputType~=Enum.UserInputType.MouseButton1 and input.UserInputType~=Enum.UserInputType.Touch then return end
        if Window.Maximized then Window.Maximize(false)end
        dragInput,dragOrigin,dragPosition=input,input.Position,Window.Position;Library:ClosePopups()
    end,root)
    Creator.AddSignal(grip.InputBegan,function(input)
        if Window.Maximized or Window.Mobile then return end
        if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
            resizeInput,resizeOrigin,resizeSize=input,input.Position,Window.Size;Library:ClosePopups()
        end
    end,root)
    Creator.AddSignal(UserInputService.InputChanged,function(input)
        local mouse=input.UserInputType==Enum.UserInputType.MouseMovement
        if floatingInput and (mouse and floatingInput.UserInputType==Enum.UserInputType.MouseButton1 or input==floatingInput)then
            local delta=input.Position-floatingOrigin
            if delta.Magnitude>6 then floatingMoved=true end
            Window.RestoreButton.Position=UDim2.fromOffset(math.clamp(floatingPosition.X.Offset+delta.X,8,math.max(8,viewport.X-60)),math.clamp(floatingPosition.Y.Offset+delta.Y,8,math.max(8,viewport.Y-60)))
        end
        if dragInput and (mouse and dragInput.UserInputType==Enum.UserInputType.MouseButton1 or input==dragInput)then
            local delta=input.Position-dragOrigin;Window.Position=UDim2.fromOffset(dragPosition.X.Offset+delta.X,dragPosition.Y.Offset+delta.Y);fit(false)
        end
        if resizeInput and not Window.Mobile and (mouse and resizeInput.UserInputType==Enum.UserInputType.MouseButton1 or input==resizeInput)then
            local delta=(input.Position-resizeOrigin)/Window.Scale.Scale
            Window.Size=UDim2.fromOffset(math.clamp(resizeSize.X.Offset+delta.X,minWidth,2048),math.clamp(resizeSize.Y.Offset+delta.Y,minHeight,2048));fit(false)
        end
    end,root)
    local controlPending,controlUsed
    Creator.AddSignal(UserInputService.InputEnded,function(input)
        if controlPending and input.KeyCode.Name==controlPending then
            if not controlUsed and not UserInputService:GetFocusedTextBox() then Window:Minimize() end
            controlPending,controlUsed=nil,false
        end
        if input==dragInput or input.UserInputType==Enum.UserInputType.MouseButton1 then dragInput=nil end
        if input==resizeInput or input.UserInputType==Enum.UserInputType.MouseButton1 then resizeInput=nil end
        if input==floatingInput or input.UserInputType==Enum.UserInputType.MouseButton1 then
            if floatingInput and floatingMoved then lastFloatingDrag=os.clock()end
            floatingInput=nil
        end
    end,root)
    Creator.AddSignal(Window.TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"),function()
        Window.TabHolder.CanvasSize=UDim2.fromOffset(0,Window.TabHolder.UIListLayout.AbsoluteContentSize.Y/Creator.GetScale(Window.TabHolder))
    end,root)
    Creator.AddSignal(UserInputService.InputBegan,function(input)
        if controlPending and input.KeyCode.Name~=controlPending then controlUsed=true end
        if input.KeyCode==Enum.KeyCode.Escape then
            if Window.ToolActive then Window:CloseTools()elseif Window.DrawerOpen then Window:SetDrawer(false)end
            return
        end
        local ctrl=UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
        if ctrl and input.KeyCode==Enum.KeyCode.K and not Window.Minimized then Window:ShowSearch();return end
        if UserInputService:GetFocusedTextBox()then return end
        local keybind=Library.MinimizeKeybind
        if type(keybind)=="table"and keybind.Picking then return end
        local expected=Compatibility.InputName(type(keybind)=="table"and keybind.Type=="Keybind"and keybind.Value or Library.MinimizeKey)
        local actual=input.UserInputType==Enum.UserInputType.Keyboard and input.KeyCode.Name or Compatibility.InputName(input.UserInputType)
        if actual==expected then
            if input.KeyCode==Enum.KeyCode.LeftControl or input.KeyCode==Enum.KeyCode.RightControl then controlPending,controlUsed=expected,false
            elseif not ctrl then Window:Minimize()end
        end
    end,root)
    function Window:SetMinimized(minimized)
        if self.Destroyed then return end
        self.OnMinimized:Fire(os.clock(),root.Visible)
        self.Minimized=minimized==true;self:SetDrawer(false);self:CloseTools();Library:ClosePopups()
        root.Visible=not self.Minimized;self.RestoreButton.Visible=self.Minimized
        updateRestoreIcon()
        if Library.UseAcrylic then self.AcrylicPaint.SetVisibility(not self.Minimized)end
        self.PostMinimized:Fire(os.clock(),root.Visible)
    end
    function Window:Minimize()self:SetMinimized(not self.Minimized)end
    local dialogs=require(script.Parent.Dialog):Init(Window)
    function Window:Dialog(options)
        if Library.DialogOpen then return nil end
        Library:ClosePopups();self:SetDrawer(false)
        local dialog=dialogs:Create();dialog.Title.Text=options.Title or "Dialog"
        local available=math.max(200,math.min(520,Window.Size.X.Offset-32))
        local content=New("TextLabel",{Text=options.Content or "",TextSize=14,TextWrapped=true,
            FontFace=Font.new("rbxasset://fonts/families/GothamSSm.json"),TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,
            AutomaticSize=Enum.AutomaticSize.Y,Size=UDim2.new(1,-40,0,0),Position=UDim2.fromOffset(20,60),Parent=dialog.Root,ThemeTag={TextColor3="Text"}})
        dialog.Root.Size=UDim2.fromOffset(available,190)
        Creator.AddSignal(content:GetPropertyChangedSignal("AbsoluteSize"),function()
            dialog.Root.Size=UDim2.fromOffset(available,math.max(190,content.AbsoluteSize.Y/Window.Scale.Scale+150))
        end,dialog.Root)
        for _,button in ipairs(options.Buttons or{})do dialog:Button(button.Title,button.Callback)end
        dialog:Open()
        if options.Yield then dialog.Closed:Wait()end
        return dialog
    end
    function Window:Destroy()
        if self.Destroyed then return end
        self:CloseTools();self.Destroyed=true;Library:ClosePopups();tabs.Generation=tabs.Generation+1
        Library.Search.Changed=nil;Library.Profiles.Changed=nil
        for _,motor in ipairs({self.ContainerBackMotor,self.ContainerPosMotor,self.SelectorPosMotor,self.SelectorSizeMotor})do motor:destroy()end
        if self.AcrylicPaint.Model then self.AcrylicPaint.Model:Destroy()end
        if cameraConnection then cameraConnection:Disconnect()end
        self.RestoreButton:Destroy();root:Destroy()
        for _,event in ipairs({self.OnMinimized,self.PostMinimized,self.OnMaximized,self.PostMaximized})do event:Destroy()end
    end
    return Window
end
