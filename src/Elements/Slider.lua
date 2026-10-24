-- Bloomware UI, based on Fluent by dawid (MIT).
local UserInputService = game:GetService("UserInputService")
local Creator = require(script.Parent.Parent.Creator)
local New = Creator.New
local Slider = { __type = "Slider" }
function Slider:New(id, config)
    assert(config.Title, "Slider - Missing Title")
    assert(type(config.Default) == "number", "Slider - Missing default value")
    assert(type(config.Min) == "number" and type(config.Max) == "number", "Slider - Min and Max must be numbers")
    local Library = self.Library
    local card = require(script.Parent.Parent.Components.Element)(config.Title, config.Description, self.Container, false)
    local option = {
        Value = config.Default, Min = math.min(config.Min,config.Max), Max = math.max(config.Min,config.Max), Rounding = config.Rounding or 0,
        Callback = config.Callback or function() end, Changed=config.Changed, Type = "Slider",
    }
    option.SetTitle, option.SetDesc = card.SetTitle, card.SetDesc
    option._Element = card
    option.Instance = card
    local holder = New("Frame", { BackgroundTransparency = 1 })
    card:SetControl(holder, { Width = 204, Height = 32 })
    local label = New("TextLabel", {
        TextSize = 12, Size = UDim2.fromOffset(48, 32), TextXAlignment = Enum.TextXAlignment.Right, Parent = holder,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
        ThemeTag = { TextColor3 = "Accent" },
    })
    local hit = New("TextButton", {
        Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, -60, 1, 0), Position = UDim2.fromOffset(60, 0), Parent = holder,
    })
    local rail = New("Frame", {
        Size = UDim2.new(1, -14, 0, 4), Position = UDim2.new(0, 7, 0.5, -2), Parent = hit,
        BackgroundTransparency = 0.45, ThemeTag = { BackgroundColor3 = "SliderRail" },
    }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    local fill = New("Frame", {
        Size = UDim2.fromScale(0, 1), Parent = rail, ThemeTag = { BackgroundColor3 = "Accent" },
    }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    local knob = New("Frame", {
        Size = UDim2.fromOffset(14, 14), AnchorPoint = Vector2.new(0.5, 0.5), Parent = rail,
        ThemeTag = { BackgroundColor3 = "Accent" },
    }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    function option:SetValue(value)
        value = tonumber(value)
        if not value or value~=value or math.abs(value)==math.huge then return end
        local oldValue = self.Value
        self.Value = math.clamp(Library:Round(math.clamp(value, self.Min, self.Max), self.Rounding), self.Min, self.Max)
        local ratio = self.Max==self.Min and 0 or (self.Value - self.Min) / (self.Max - self.Min)
        fill.Size, knob.Position, label.Text = UDim2.fromScale(ratio, 1), UDim2.fromScale(ratio, 0.5), tostring(self.Value)
        Library:SafeCallback(self.Callback, self.Value,oldValue)
        Library:SafeCallback(self.Changed, self.Value,oldValue)
    end
    function option:OnChanged(callback) self.Changed = callback; Library:SafeCallback(callback,self.Value,self.Value) end
    local dragging
    local function point(input)
        if rail.AbsoluteSize.X <= 0 then return end
        option:SetValue(option.Min + (option.Max - option.Min) * math.clamp((input.Position.X - rail.AbsolutePosition.X) / rail.AbsoluteSize.X, 0, 1))
    end
    Creator.AddSignal(hit.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = input; point(input) end
    end)
    Creator.AddSignal(UserInputService.InputChanged, function(input)
        if dragging and (input == dragging or dragging.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement) then point(input) end
    end, card.Frame)
    Creator.AddSignal(UserInputService.InputEnded, function(input)
        if input == dragging or input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = nil end
    end, card.Frame)
    function option:Destroy() card:Destroy(); if Library.Options[id] == self then Library.Options[id] = nil end end
    Library.Options[id] = option
    option:SetValue(config.Default)
    return option
end
return Slider
