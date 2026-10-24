-- Both AddParagraph{...} and CreateParagraph("id", {...}) are supported.
local Creator = require(script.Parent.Parent.Creator)
local Paragraph = { __type="Paragraph" }
function Paragraph:New(config)
    assert(config.Title, "Paragraph - Missing Title")
    local Library = self.Library
    local card = require(script.Parent.Parent.Components.Element)(config.Title, config.Content or "", self.Container, false)
    local option = { Type="Paragraph", Value=config.Content or "", Callback=config.Callback, _Element=card }
    -- Preserve original Fluent's returned card fields and Renewed's value API.
    setmetatable(option, {
        __index=card,
        __newindex=function(target,key,value)
            if key=="Title" then card:SetTitle(value)
            elseif key=="Description" or key=="Desc" then target:SetValue(value)
            else rawset(target,key,value) end
        end,
    })
    function option:SetValue(value)
        self.Value = tostring(value or "")
        card:SetDesc(self.Value)
        Library:SafeCallback(self.Callback, self.Value)
        Library:SafeCallback(self.Changed, self.Value)
    end
    option.SetContent = option.SetValue
    function option:SetDesc(value) self:SetValue(value) end
    function option:OnChanged(callback) self.Changed=callback; Library:SafeCallback(callback, self.Value) end
    card.Frame.BackgroundTransparency = Creator.GetThemeProperty("ElementTransparency")
    card.Border.Transparency = 0.6
    return option
end
return Paragraph
