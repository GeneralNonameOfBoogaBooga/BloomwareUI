-- Bloomware UI, based on Fluent by dawid (MIT).
local TweenService = game:GetService("TweenService")
local Creator = require(script.Parent.Parent.Creator)
local New = Creator.New
local Toggle = { __type = "Toggle" }
function Toggle:New(id, config)
    assert(config.Title, "Toggle - Missing Title")
    local Library = self.Library
    local card = require(script.Parent.Parent.Components.Element)(config.Title, config.Description, self.Container, true)
    local option = { Value = config.Default == true, Callback = config.Callback or function() end, Changed=config.Changed, Type = "Toggle" }
    option.SetTitle, option.SetDesc = card.SetTitle, card.SetDesc
    option._Element = card
    option.Instance = card
    local stroke = New("UIStroke", { Transparency = 0.55, ThemeTag = { Color = "ToggleSlider" } })
    local knob = New("Frame", {
        Size = UDim2.fromOffset(16, 16), Position = UDim2.fromOffset(3, 3),
        ThemeTag = { BackgroundColor3 = "ToggleSlider" },
    }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    local track = New("Frame", {
        BackgroundTransparency = 0.88, ThemeTag = { BackgroundColor3 = "ToggleSlider" },
    }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }), stroke, knob })
    card:SetControl(track, { Width = 42, Height = 22, StackWidth = 240 })
    local animation
    function option:OnChanged(callback) self.Changed = callback; Library:SafeCallback(callback,self.Value) end
    function option:SetValue(value)
        self.Value = not not value
        Creator.OverrideTag(track, { BackgroundColor3 = self.Value and "Accent" or "ToggleSlider" })
        Creator.OverrideTag(knob, { BackgroundColor3 = self.Value and "ToggleToggled" or "ToggleSlider" })
        Creator.OverrideTag(stroke, { Color = self.Value and "Accent" or "ToggleSlider" })
        track.BackgroundTransparency = self.Value and 0 or 0.88
        if animation then animation:Cancel() end
        animation = TweenService:Create(knob, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.fromOffset(self.Value and 23 or 3, 3),
        })
        animation:Play()
        Library:SafeCallback(self.Callback, self.Value)
        Library:SafeCallback(self.Changed, self.Value)
    end
    function option:Destroy()
        if animation then animation:Cancel() end
        card:Destroy()
        if Library.Options[id] == self then Library.Options[id] = nil end
    end
    local context = self
    local attached
    local function addKeybind(_, keyId, keyConfig)
        if attached then return attached end
        local holder = New("Frame", {BackgroundTransparency=1})
        card:SetControl(holder, {Width=172, Height=32, StackWidth=360})
        track.Parent=holder;track.Size=UDim2.fromOffset(42,22);track.Position=UDim2.new(1,0,0.5,-11);track.AnchorPoint=Vector2.new(1,0)
        attached = Library.Elements.AddKeybind({Container=context.Container,Type=context.Type,ScrollFrame=context.ScrollFrame,
            Tab=context.Tab,SectionName=context.SectionName,InlineCard=card,InlineParent=holder,_LinkedToggle=option}, keyId, keyConfig)
        attached.Button.Size=UDim2.new(1,-54,1,0)
        option.Keybind=attached
        return attached
    end
    option.Keybind,option.AddKeybind,option.CreateKeybind=addKeybind,addKeybind,addKeybind
    Creator.AddSignal(card.Frame.Activated, function() if not attached or not attached.Picking then option:SetValue(not option.Value) end end)
    Library.Options[id] = option
    option:SetValue(option.Value)
    return option
end
return Toggle
