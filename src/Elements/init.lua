local elements = {}
for _, child in ipairs(script:GetChildren()) do
    table.insert(elements, require(child))
end
return elements
