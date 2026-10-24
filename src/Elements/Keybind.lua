-- Bloomware UI, based on Fluent by dawid (MIT).
local UserInputService = game:GetService("UserInputService")
local Creator = require(script.Parent.Parent.Creator)
local New = Creator.New
local Compatibility = require(script.Parent.Parent.Compatibility)
local Keybind = { __type = "Keybind" }
function Keybind:New(id, config)
    assert(config.Title and config.Default, "Keybind - Missing Title or Default")
    local Library = self.Library
    local inline, linkedToggle = self.InlineCard ~= nil, self._LinkedToggle
    local card = self.InlineCard or require(script.Parent.Parent.Components.Element)(config.Title, config.Description, self.Container, true)
    local option = {
        Value = Compatibility.KeyName(config.Default) or "None", Mode = config.Mode or "Toggle", Toggled = false, Type = "Keybind",
        Callback = config.Callback or function() end, ChangedCallback = config.ChangedCallback or function() end,
    }
    option.SetTitle, option.SetDesc = card.SetTitle, card.SetDesc
    option._Element = card
    option.Instance = card
    local button = New("TextButton", {
        Text = option.Value, TextSize = 12, BackgroundTransparency = 0.78,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
        ThemeTag = { TextColor3 = "Text", BackgroundColor3 = "Keybind" },
    }, { New("UICorner", { CornerRadius = UDim.new(0, 7) }), New("UIStroke", { Transparency = 0.55, ThemeTag = { Color = "InElementBorder" } }) })
    if inline then button.Parent=self.InlineParent; option._Owner=button
    else card:SetControl(button, { Width = 118, Height = 32, StackWidth = 320 }) end
    option.Button = button
    local picking, ready = false, false
    local function inputName(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then return input.KeyCode.Name end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then return "MouseLeft" end
        if input.UserInputType == Enum.UserInputType.MouseButton2 then return "MouseRight" end
        if input.UserInputType == Enum.UserInputType.MouseButton3 then return "MouseMiddle" end
        return nil
    end
    function option:GetState()
        if self.Mode == "Always" then return true end
        if UserInputService:GetFocusedTextBox() then return false end
        if self.Mode == "Toggle" then return self.Toggled end
        local name = Compatibility.InputName(self.Value)
        if name == "None" then return false end
        if name == "MouseLeft" or name == "MouseRight" or name == "MouseMiddle" then
            return UserInputService:IsMouseButtonPressed(Enum.UserInputType[name == "MouseLeft" and "MouseButton1" or name == "MouseRight" and "MouseButton2" or "MouseButton3"])
        end
        local ok, pressed = pcall(function() return UserInputService:IsKeyDown(Enum.KeyCode[self.Value]) end)
        return ok and pressed or false
    end
    function option:SetValue(value, mode)
        self.Value = Compatibility.KeyName(value) or self.Value
        if mode == "Toggle" or mode == "Hold" or mode == "Always" then self.Mode = mode end
        button.Text = self.Value
        Library:SafeCallback(self.ChangedCallback, value or self.Value)
        Library:SafeCallback(self.Changed, self.Value)
    end
    function option:DoClick()
        if linkedToggle then linkedToggle:SetValue(not linkedToggle.Value) end
        Library:SafeCallback(self.Callback, self.Toggled)
        Library:SafeCallback(self.Clicked, self.Toggled)
    end
    function option:OnClick(callback) self.Clicked = callback end
    function option:OnChanged(callback) self.Changed = callback; Library:SafeCallback(callback,self.Value) end
    Creator.AddSignal(button.Activated, function()
        picking, ready, option.Picking = true, false, true
        button.Text = "Press a key..."
        task.delay(0.15, function() if not card.Destroyed then ready = true end end)
    end)
    Creator.AddSignal(UserInputService.InputBegan, function(input)
        if picking then
            if not ready then return end
            if input.KeyCode == Enum.KeyCode.Escape then picking,option.Picking = false,false; button.Text = option.Value; return end
            local value = inputName(input)
            if value then
                if value == "Backspace" then value = "None" end
                picking,option.Picking = false,false
                option:SetValue(value)
            end
            return
        end
        if not UserInputService:GetFocusedTextBox() and inputName(input) == Compatibility.InputName(option.Value) and option.Mode == "Toggle" then
            option.Toggled = not option.Toggled
            option:DoClick()
        end
    end, inline and button or card.Frame)
    function option:Destroy() picking = false; if inline then button:Destroy() else card:Destroy() end; if Library.Options[id] == self then Library.Options[id] = nil end end
    Library.Options[id] = option
    return option
end
return Keybind
