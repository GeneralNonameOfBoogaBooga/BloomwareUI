-- Legacy individual images and Renewed's cropped Lucide/Phosphor atlases.
local legacy = require(script.Parent.Icons).assets
local renewed = require(script.Parent.RenewedIcons)
local Provider = {}
function Provider:GetIcon(name)
    if type(name) == "table" and type(name.Image) == "string" then return name end
    if type(name) == "number" then name = "rbxassetid://" .. name end
    if type(name) ~= "string" or name == "" then return nil end
    local short = name:gsub("^lucide%-", "")
    local image = legacy["lucide-" .. short]
    if image then return {Image=image, ImageRectOffset=Vector2.new(0,0), ImageRectSize=Vector2.new(0,0)} end
    local atlas = renewed[name] or renewed[short]
    if atlas then return atlas end
    if name:match("^rbxasset") or name:match("^https?://") then
        return {Image=name, ImageRectOffset=Vector2.new(0,0), ImageRectSize=Vector2.new(0,0)}
    end
    return nil
end
function Provider:SetIcon(object, name)
    local data = self:GetIcon(name)
    if not data then return false end
    object.Image = data.Image
    object.ImageRectSize = data.ImageRectSize or Vector2.new(0,0)
    object.ImageRectOffset = data.ImageRectOffset or Vector2.new(0,0)
    return true
end
return setmetatable(Provider, { __index=function(self, name) return self:GetIcon(name) end })
