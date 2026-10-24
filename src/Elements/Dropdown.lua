-- Bloomware UI, based on Fluent by dawid (MIT).
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Creator = require(script.Parent.Parent.Creator)
local New = Creator.New
local Dropdown = { __type = "Dropdown" }
local function valuesArray(values)
    local result = {}
    for _, value in ipairs(values or {}) do table.insert(result,value) end
    for key, value in pairs(values or {}) do
        if type(key)~="number" or key<1 or key%1~=0 or key>#(values or {}) then table.insert(result,value) end
    end
    return result
end
function Dropdown:New(id, config)
    assert(config.Title, "Dropdown - Missing Title")
    local Library = self.Library
    local scrollFrame = self.ScrollFrame
    local card = require(script.Parent.Parent.Components.Element)(config.Title, config.Description, self.Container, false)
    local option = {
        Values = valuesArray(config.Values), Value = config.Multi and {} or nil, Multi = config.Multi == true,
        AutoDeselect=config.AutoDeselect==true, Displayer=config.Displayer or tostring,
        Buttons = {}, Opened = false, Type = "Dropdown", Callback = config.Callback or function() end, Changed=config.Changed,
    }
    option.SetTitle, option.SetDesc = card.SetTitle, card.SetDesc
    option._Element = card
    option.Instance = card
    local button = New("TextButton", {
        Text = "", BackgroundTransparency = 0.12,
        ThemeTag = { BackgroundColor3 = "DropdownFrame" },
    }, {
        New("UICorner", { CornerRadius = UDim.new(0, 7) }),
        New("UIStroke", { Transparency = 0.55, ThemeTag = { Color = "InElementBorder" } }),
    })
    card:SetControl(button, { Width = 176, Height = 32 })
    local label = New("TextLabel", {
        Text = "Select...", TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
        TextTruncate = Enum.TextTruncate.AtEnd, Size = UDim2.new(1, -36, 1, 0), Position = UDim2.fromOffset(10, 0),
        Parent = button, ThemeTag = { TextColor3 = "Text" },
    })
    New("ImageLabel", {
        Image = "rbxassetid://10709790948", Size = UDim2.fromOffset(14, 14), Position = UDim2.new(1, -24, 0.5, -7),
        Parent = button, ThemeTag = { ImageColor3 = "SubText" },
    })
    local popupScale = New("UIScale", { Scale = 1 })
    local popup = New("Frame", {
        Name = "DropdownPopup", Visible = false, Size = UDim2.fromOffset(200, 200), ZIndex = 50,
        Parent = Library.GUI, ThemeTag = { BackgroundColor3 = "DropdownHolder" },
    }, {
        popupScale, New("UICorner", { CornerRadius = UDim.new(0, 10) }),
        New("UIStroke", { Transparency = 0.12, ThemeTag = { Color = "DropdownBorder" } }),
    })
    local list = New("ScrollingFrame", {
        Size = UDim2.new(1, -12, 1, -12), Position = UDim2.fromOffset(6, 6),
        BackgroundTransparency = 1, ScrollBarThickness = 3, ScrollBarImageTransparency = 0.55,
        ScrollingDirection = Enum.ScrollingDirection.Y, CanvasSize = UDim2.fromOffset(0, 0),
        ZIndex = 51, Parent = popup, ThemeTag = { ScrollBarImageColor3 = "SubText" },
    }, { New("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder }) })
    table.insert(Library.OpenFrames, popup)
    local destroyed, previousScroll = false, true
    local function displayValue(value)
        local ok, text = pcall(option.Displayer,value)
        return ok and tostring(text) or tostring(value)
    end
    local function normalize(value)
        if not option.Multi then
            if type(value) == "number" and not table.find(option.Values,value) then value = option.Values[value] end
            if table.find(option.Values,value)then return value end
            return nil
        end
        local result = {}
        if type(value) == "table" then
            for key, item in pairs(value) do
                local selected
                if type(key) == "number" and type(item) ~= "boolean" then selected=item
                elseif item then selected=key end
                if selected ~= nil and table.find(option.Values, selected) then result[selected] = true end
            end
        elseif value ~= nil then
            local selected = type(value) == "number" and option.Values[value] or value
            if table.find(option.Values, selected) then result[selected] = true end
        end
        return result
    end
    option.Value = normalize(config.Default)
    function option:Display()
        if self.Multi then
            local selected = {}
            for _, value in ipairs(self.Values) do if self.Value[value] then table.insert(selected, displayValue(value)) end end
            label.Text = #selected > 0 and table.concat(selected, ", ") or "Select..."
        else label.Text = self.Value ~= nil and displayValue(self.Value) or "Select..." end
    end
    function option:GetActiveValues()
        if not self.Multi then return self.Value ~= nil and 1 or 0 end
        local result = {}
        for _, value in ipairs(self.Values) do if self.Value[value] then table.insert(result, value) end end
        return result
    end
    local function place()
        if destroyed or not option.Opened then return end
        local camera = Workspace.CurrentCamera
        local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)
        local scale = Creator.GetScale(card.Frame)
        popupScale.Scale = scale
        local popupWidth = math.min(260, math.max(176, button.AbsoluteSize.X / scale))
        popupWidth = math.min(popupWidth, math.max(40, (viewport.X - 16) / scale))
        local desiredHeight = math.min(312, math.max(46, #option.Values * 37 + 9))
        local position, size = button.AbsolutePosition, button.AbsoluteSize
        local below, above = viewport.Y - position.Y - size.Y - 14, position.Y - 14
        local openBelow = below >= desiredHeight * scale or below >= above
        local available = math.max(28, openBelow and below or above)
        local height = math.min(desiredHeight, available / scale)
        popup.Size = UDim2.fromOffset(popupWidth, height)
        popup.Position = UDim2.fromOffset(
            math.clamp(position.X + size.X - popupWidth * scale, 8, math.max(8, viewport.X - popupWidth * scale - 8)),
            openBelow and (position.Y + size.Y + 6) or math.max(8, position.Y - height * scale - 6)
        )
    end
    function option:Close()
        if not self.Opened then return end
        self.Opened = false
        popup.Visible = false
        if scrollFrame and scrollFrame.Parent then scrollFrame.ScrollingEnabled = previousScroll end
    end
    function option:Open()
        if destroyed or Library.DialogOpen then return end
        Library:ClosePopups()
        if scrollFrame then previousScroll = scrollFrame.ScrollingEnabled; scrollFrame.ScrollingEnabled = false end
        self.Opened = true
        place()
        popup.Visible = true
    end
    function option:BuildDropdownList()
        for _, child in ipairs(list:GetChildren()) do if not child:IsA("UIListLayout") then child:Destroy() end end
        table.clear(self.Buttons)
        for index, value in ipairs(self.Values) do
            local selected = self.Multi and self.Value[value] == true or not self.Multi and self.Value == value
            local row = New("TextButton", {
                Text = "", Size = UDim2.new(1, -4, 0, 34), LayoutOrder = index, ZIndex = 52,
                BackgroundTransparency = selected and 0.87 or 1, Parent = list,
                ThemeTag = { BackgroundColor3 = "DropdownOption" },
            }, { New("UICorner", { CornerRadius = UDim.new(0, 6) }) })
            New("TextLabel", {
                Text = displayValue(value), TextSize = 12, TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, -40, 1, 0), Position = UDim2.fromOffset(10, 0),
                FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"), ZIndex = 53, Parent = row,
                ThemeTag = { TextColor3 = selected and "Accent" or "Text" },
            })
            if selected then New("TextLabel", {
                Text = "✓", TextSize = 14, Size = UDim2.fromOffset(24, 34), Position = UDim2.new(1, -28, 0, 0),
                ZIndex = 53, Parent = row, ThemeTag = { TextColor3 = "Accent" },
            }) end
            Creator.AddSignal(row.MouseEnter, function() row.BackgroundTransparency = selected and 0.82 or 0.94 end, row)
            Creator.AddSignal(row.MouseLeave, function() row.BackgroundTransparency = selected and 0.87 or 1 end, row)
            Creator.AddSignal(row.Activated, function()
                if self.Multi then
                    local active = self:GetActiveValues()
                    if self.Value[value] and #active == 1 and not config.AllowNull then return end
                    self.Value[value] = not self.Value[value] and true or nil
                    if self.AutoDeselect then self:Close() end
                else
                    if self.Value == value then
                        if config.AllowNull then self.Value = nil end
                    else self.Value = value end
                    self:Close()
                end
                self:Display()
                self:BuildDropdownList()
                Library:SafeCallback(self.Callback, self.Value)
                Library:SafeCallback(self.Changed, self.Value)
            end, row)
            self.Buttons[index] = row
        end
        if #self.Values == 0 then New("TextLabel", {
            Text = "No options", TextSize = 12, Size = UDim2.new(1, 0, 0, 34), Parent = list,
            ZIndex = 52, ThemeTag = { TextColor3 = "SubText" },
        }) end
        list.CanvasSize = UDim2.fromOffset(0, #self.Values * 37)
        place()
    end
    function option:SetValue(value)
        self.Value = normalize(value)
        self:Display()
        self:BuildDropdownList()
        Library:SafeCallback(self.Callback, self.Value)
        Library:SafeCallback(self.Changed, self.Value)
    end
    function option:SetValues(values)
        if values then self.Values = valuesArray(values) end
        self.Value = normalize(self.Value)
        self:Display()
        self:BuildDropdownList()
    end
    function option:OnChanged(callback) self.Changed = callback; Library:SafeCallback(callback,self.Value) end
    local function inside(point, frame)
        local p, s = frame.AbsolutePosition, frame.AbsoluteSize
        return point.X >= p.X and point.X <= p.X + s.X and point.Y >= p.Y and point.Y <= p.Y + s.Y
    end
    Creator.AddSignal(button.Activated, function() if option.Opened then option:Close() else option:Open() end end)
    Creator.AddSignal(button:GetPropertyChangedSignal("AbsolutePosition"), place, card.Frame)
    Creator.AddSignal(UserInputService.InputBegan, function(input)
        if not option.Opened then return end
        if input.KeyCode == Enum.KeyCode.Escape then option:Close(); return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if not inside(input.Position, popup) and not inside(input.Position, button) then option:Close() end
        end
    end, card.Frame)
    local function cleanup()
        if destroyed then return end
        option:Close()
        destroyed = true
        local index = table.find(Library.OpenFrames, popup)
        if index then table.remove(Library.OpenFrames, index) end
        popup:Destroy()
        if Library.Options[id] == option then Library.Options[id] = nil end
    end
    Creator.AddSignal(card.Frame.Destroying, cleanup)
    function option:Destroy() cleanup(); card:Destroy() end
    option:Display()
    option:BuildDropdownList()
    Library.Options[id] = option
    return option
end
return Dropdown
