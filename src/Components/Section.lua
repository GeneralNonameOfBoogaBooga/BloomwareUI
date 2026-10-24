-- Bloomware UI, based on Fluent by dawid (MIT).
local Creator = require(script.Parent.Parent.Creator)
local New = Creator.New
return function(title, parent)
    local section = {}
    local layout = New("UIListLayout", { Padding = UDim.new(0, 9), SortOrder = Enum.SortOrder.LayoutOrder })
    section.Container = New("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), Position = UDim2.fromOffset(0, 32),
    }, { layout })
    section.Root = New("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 32), LayoutOrder = 7, Parent = parent,
    }, {
        New("Frame", {
            Size = UDim2.fromOffset(3, 12), Position = UDim2.fromOffset(1, 7),
            ThemeTag = { BackgroundColor3 = "Accent" },
        }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) }),
        New("TextLabel", {
            Text = title, TextSize = 13, TextTruncate = Enum.TextTruncate.AtEnd,
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
            TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, -18, 0, 26),
            Position = UDim2.fromOffset(12, 0), ThemeTag = { TextColor3 = "SubText" },
        }), section.Container,
    })
    Creator.AddSignal(layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
        local height = layout.AbsoluteContentSize.Y / Creator.GetScale(section.Root)
        section.Container.Size = UDim2.new(1, 0, 0, height)
        section.Root.Size = UDim2.new(1, 0, 0, height + 32)
    end, section.Root)
    return section
end
