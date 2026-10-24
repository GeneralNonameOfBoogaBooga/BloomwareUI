-- Bloomware UI, based on Fluent by dawid (MIT).
local Creator = require(script.Parent.Parent.Creator)
local Library = require(script.Parent.Parent)
local New = Creator.New
return function(title, description, parent, interactive)
    Creator.ElementSequence = (Creator.ElementSequence or 0) + 1
    local element = { Destroyed = false, CreatedAt = Creator.ElementSequence }
    element.TitleLabel = New("TextLabel", {
        Text = title or "", TextSize = 13, TextWrapped = true, AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 16), TextXAlignment = Enum.TextXAlignment.Left,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
        ThemeTag = { TextColor3 = "Text" },
    })
    element.DescLabel = New("TextLabel", {
        Text = description or "", TextSize = 11, TextWrapped = true, AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 14), TextXAlignment = Enum.TextXAlignment.Left,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
        Visible = description ~= nil and description ~= "", LayoutOrder = 1,
        ThemeTag = { TextColor3 = "SubText" },
    })
    local layout = New("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder })
    element.LabelHolder = New("Frame", {
        BackgroundTransparency = 1, Position = UDim2.fromOffset(14, 14), Size = UDim2.new(1, -28, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    }, { layout, element.TitleLabel, element.DescLabel })
    element.Border = New("UIStroke", {
        Thickness = 1, Transparency = 0.52, ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        ThemeTag = { Color = "ElementBorder" },
    })
    element.Frame = New("TextButton", {
        Name = "SettingCard", Text = "", BackgroundTransparency = 0.12, Size = UDim2.new(1, 0, 0, 56),
        LayoutOrder = 7, Parent = parent,
        ThemeTag = { BackgroundColor3 = "Element", BackgroundTransparency = "ElementTransparency" },
    }, { New("UICorner", { CornerRadius = UDim.new(0, 10) }), element.Border, element.LabelHolder })
    local control, options
    local function update()
        if element.Destroyed then return end
        local mobile = Library.Mobile == true
        element.TitleLabel.TextSize = mobile and 14 or 13
        element.DescLabel.TextSize = mobile and 12 or 11
        local scale = Creator.GetScale(element.Frame)
        local width = element.Frame.AbsoluteSize.X / scale
        local stacked = control and width < (options.StackWidth or 430)
        local controlHeight = control and (mobile and (options.Height or 32) >= 28 and 44 or (options.Height or 32)) or 0
        local controlWidth = control and math.min(options.Width or 176, math.max(40, width - 28)) or 0
        if mobile and stacked and (options.Height or 32)>=28 then controlWidth=math.max(40,width-28)end
        element.LabelHolder.Size = UDim2.new(1, control and not stacked and -(controlWidth + 42) or -28, 0, 0)
        local textHeight = layout.AbsoluteContentSize.Y / scale
        local height = math.max(mobile and 64 or 56, textHeight + 28 + (stacked and (controlHeight + 12) or 0))
        if element.Frame.Size.Y.Offset ~= height then element.Frame.Size = UDim2.new(1, 0, 0, height) end
        if control then
            control.Size = UDim2.fromOffset(controlWidth, controlHeight)
            control.AnchorPoint = Vector2.new(1, stacked and 1 or 0.5)
            control.Position = stacked and UDim2.new(1, -14, 1, -14) or UDim2.new(1, -14, 0.5, 0)
        end
    end
    function element:SetControl(object, config)
        control, options = object, config or {}
        object.Parent = self.Frame
        update()
    end
    function element:SetTitle(text) element.TitleLabel.Text = text or "" end
    function element:SetDesc(text)
        element.DescLabel.Text = text or ""
        element.DescLabel.Visible = text ~= nil and text ~= ""
        update()
    end
    function element:Destroy()
        if self.Destroyed then return end
        self.Destroyed = true
        self.Frame:Destroy()
    end
    Creator.AddSignal(element.Frame.Destroying, function() element.Destroyed = true end)
    Creator.AddSignal(element.Frame:GetPropertyChangedSignal("AbsoluteSize"), update, element.Frame)
    Creator.AddSignal(layout:GetPropertyChangedSignal("AbsoluteContentSize"), update, element.Frame)
    if interactive then
        local _, transparency = Creator.SpringMotor(Creator.GetThemeProperty("ElementTransparency"), element.Frame, "BackgroundTransparency", false, true)
        Creator.AddSignal(element.Frame.MouseEnter, function()
            transparency(math.clamp(Creator.GetThemeProperty("ElementTransparency") - Creator.GetThemeProperty("HoverChange"), 0, 1))
        end)
        Creator.AddSignal(element.Frame.MouseLeave, function() transparency(Creator.GetThemeProperty("ElementTransparency")) end)
    end
    Creator.AddSignal(Library.LayoutChanged, update, element.Frame)
    task.defer(update)
    return setmetatable(element, {
        __index = function(_, key)
            if key == "Title" then return element.TitleLabel.Text end
            if key == "Description" or key == "Desc" then return element.DescLabel.Text end
        end,
        __newindex = function(target, key, value)
            if key == "Title" then element:SetTitle(value)
            elseif key == "Description" or key == "Desc" then element:SetDesc(value)
            else rawset(target, key, value) end
        end,
    })
end
