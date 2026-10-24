local themes = { Names = {"Dark", "Darker", "Light", "Aqua", "Amethyst", "Rose"} }
for _, child in ipairs(script:GetChildren()) do
    local theme = require(child)
    themes[theme.Name] = theme
end

local renewed = require(script.Parent.RenewedThemes)
for _, name in ipairs(renewed.Names) do
    if not themes[name] then
        local theme = renewed[name]
        theme.Name = name
        themes[name] = theme
        table.insert(themes.Names, name)
    end
end
return themes
