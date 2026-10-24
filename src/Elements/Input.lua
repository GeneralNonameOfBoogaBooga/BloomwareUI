-- Bloomware UI, based on Fluent by dawid (MIT).
local Creator = require(script.Parent.Parent.Creator)
local Input = { __type = "Input" }
function Input:New(id, config)
    assert(config.Title, "Input - Missing Title")
    local Library = self.Library
    local card = require(script.Parent.Parent.Components.Element)(config.Title, config.Description, self.Container, false)
    local field = require(script.Parent.Parent.Components.Textbox)(card.Frame, true)
    card:SetControl(field.Frame, { Width = 176, Height = 32 })
    local option = {
        Value = tostring(config.Default or ""), Numeric = config.Numeric == true,
        Finished = config.Finished == true, Callback = config.Callback or function() end, Changed=config.Changed, Type = "Input",
        ClearOnFocusLost = config.ClearOnFocusLost == true,
    }
    option.SetTitle, option.SetDesc = card.SetTitle, card.SetDesc
    option._Element = card
    option.Instance = card
    field.Input.Text = option.Value
    field.Input.PlaceholderText = config.Placeholder or "Enter a value"
    local changing = false
    function option:SetValue(value)
        value = tostring(value or "")
        if config.MaxLength then
            local length = utf8.len(value)
            if length and length > config.MaxLength then
                local offset = utf8.offset(value, config.MaxLength + 1)
                value = value:sub(1, offset - 1)
            end
        end
        if self.Numeric and value ~= "" and not tonumber(value) then value = self.Value end
        local changed = value ~= self.Value
        self.Value = value
        changing = true
        field.Input.Text = value
        changing = false
        if changed then
            Library:SafeCallback(self.Callback, value)
            Library:SafeCallback(self.Changed, value)
        end
    end
    if option.Finished then
        -- Commit on Enter, clicking elsewhere, and dismissing a touch keyboard.
        Creator.AddSignal(field.Input.FocusLost, function()
            option:SetValue(field.Input.Text)
            if option.ClearOnFocusLost and not card.Destroyed then changing=true;field.Input.Text="";changing=false end
        end)
    else
        Creator.AddSignal(field.Input:GetPropertyChangedSignal("Text"), function()
            if not changing then option:SetValue(field.Input.Text) end
        end)
    end
    function option:OnChanged(callback) self.Changed = callback; Library:SafeCallback(callback,self.Value) end
    function option:Destroy()
        card:Destroy()
        if Library.Options[id] == self then Library.Options[id] = nil end
    end
    Library.Options[id] = option
    return option
end
return Input
