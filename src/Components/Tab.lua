-- Bloomware UI, based on Fluent by dawid (MIT).
local Creator = require(script.Parent.Parent.Creator)
local Flipper = require(script.Parent.Parent.Packages.Flipper)
local New = Creator.New
local Tabs = { Window = nil, Tabs = {}, Containers = {}, SelectedTab = 0, TabCount = 0, Generation = 0 }
local defaultIcons = {
    farm = "sprout", combat = "swords", progress = "trending-up", shop = "shopping-bag",
    teleport = "map-pin", esp = "eye", stats = "bar-chart", misc = "layout-grid", webhooks = "link", settings = "settings",
}
function Tabs:Init(window)
    self.Window, self.Tabs, self.Containers, self.SelectedTab, self.TabCount = window, {}, {}, 0, 0
    self.Generation = self.Generation + 1
    return self
end
function Tabs:GetCurrentTabPos()
    local tab = self.Tabs[self.SelectedTab]
    return tab and tab.Frame.AbsolutePosition.Y - self.Window.TabHolder.AbsolutePosition.Y or 0
end
function Tabs:New(title, iconName, parent)
    assert(type(title) == "string", "Tab - Missing Title")
    local Library = require(script.Parent.Parent)
    self.TabCount = self.TabCount + 1
    local index = self.TabCount
    if iconName == nil then iconName = defaultIcons[title:lower()] end
    local icon = Library:GetIconData(iconName) or iconName
    if icon == "" then icon = nil end
    local tab = { Selected = false, Name = title, Type = "Tab", Index=index }
    tab.Tab = tab
    tab.Frame = New("TextButton", {
        Text = "", Size = UDim2.new(1, -2, 0, self.Window.Mobile and 44 or 40), BackgroundTransparency = 1, LayoutOrder = index,
        Parent = parent, ThemeTag = { BackgroundColor3 = "Tab" },
    }, { New("UICorner", { CornerRadius = UDim.new(0, 9) }) })
    tab.Marker = New("Frame", {
        Size = UDim2.fromOffset(3, 16), Position = UDim2.new(0, 0, 0.5, -8),
        Visible = false, Parent = tab.Frame, ThemeTag = { BackgroundColor3 = "Accent" },
    }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    tab.Label = New("TextLabel", {
        Text = title, TextSize = 12, TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1, icon and -46 or -24, 1, 0),
        Position = UDim2.fromOffset(icon and 38 or 14, 0), Parent = tab.Frame,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
        ThemeTag = { TextColor3 = "SubText" },
    })
    if icon then
        tab.Icon = New("ImageLabel", {
            Image = type(icon) == "table" and icon.Image or icon, Size = UDim2.fromOffset(16, 16), Position = UDim2.new(0, 14, 0.5, -8),
            Parent = tab.Frame, ThemeTag = { ImageColor3 = "SubText" },
        })
        Library.Utilities.Icons:SetIcon(tab.Icon, icon)
    end
    local layout = New("UIListLayout", { Padding = UDim.new(0, 9), SortOrder = Enum.SortOrder.LayoutOrder })
    tab.ContainerFrame = New("ScrollingFrame", {
        BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.fromOffset(0, 0),
        Visible = false, ScrollBarThickness = 3, ScrollBarImageTransparency = 0.6,
        ScrollingDirection = Enum.ScrollingDirection.Y, Parent = self.Window.ContainerHolder,
        ThemeTag = { ScrollBarImageColor3 = "SubText" },
    }, { layout, New("UIPadding", {
        PaddingLeft = UDim.new(0, 1), PaddingRight = UDim.new(0, 7), PaddingTop = UDim.new(0, 1), PaddingBottom = UDim.new(0, 5),
    }) })
    Creator.AddSignal(layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
        tab.ContainerFrame.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y / Creator.GetScale(tab.ContainerFrame) + 6)
    end, tab.ContainerFrame)
    Creator.AddSignal(Library.LayoutChanged, function(mobile)
        tab.Frame.Size = UDim2.new(1, -2, 0, mobile and 44 or 40)
    end, tab.Frame)
    tab.Motor, tab.SetTransparency = Creator.SpringMotor(1, tab.Frame, "BackgroundTransparency")
    Creator.AddSignal(tab.Frame.MouseEnter, function() tab.SetTransparency(tab.Selected and 0.84 or 0.94) end)
    Creator.AddSignal(tab.Frame.MouseLeave, function() tab.SetTransparency(tab.Selected and 0.89 or 1) end)
    Creator.AddSignal(tab.Frame.Activated, function() self:SelectTab(index) end)
    tab.Container, tab.ScrollFrame = tab.ContainerFrame, tab.ContainerFrame
    function tab:AddSection(name)
        if type(name) == "table" then name = name.Title or name.Name end
        assert(type(name) == "string", "Section - Missing Title")
        local section = require(script.Parent.Section)(name, tab.Container)
        return setmetatable({ Type = "Section", Container = section.Container, ScrollFrame = tab.Container, Tab=tab, SectionName=name }, Library.Elements)
    end
    tab.CreateSection, tab.Section = tab.AddSection, tab.AddSection
    setmetatable(tab, Library.Elements)
    self.Tabs[index], self.Containers[index] = tab, tab.ContainerFrame
    if index == 1 then self:SelectTab(1, true) end
    return tab
end
function Tabs:SelectTab(index, instant)
    if type(index) ~= "number" or not self.Tabs[index] then return false end
    local window = self.Window
    if window.Destroyed then return false end
    require(script.Parent.Parent):ClosePopups()
    if window.CloseTools then window:CloseTools() end
    if window.SetDrawer then window:SetDrawer(false) end
    self.SelectedTab = index
    self.Generation = self.Generation + 1
    local generation = self.Generation
    for number, tab in ipairs(self.Tabs) do
        tab.Selected = number == index
        tab.Marker.Visible = tab.Selected
        tab.SetTransparency(tab.Selected and 0.89 or 1)
        Creator.OverrideTag(tab.Label, { TextColor3 = tab.Selected and "Accent" or "SubText" })
        if tab.Icon then Creator.OverrideTag(tab.Icon, { ImageColor3 = tab.Selected and "Accent" or "SubText" }) end
    end
    window.TabDisplay.Text = self.Tabs[index].Name
    local function show()
        if generation ~= self.Generation or window.Destroyed then return end
        for number, container in ipairs(self.Containers) do container.Visible = number == index end
        window.ContainerPosMotor:setGoal(Flipper[instant and "Instant" or "Spring"].new(window.ContentTop or 120, { frequency = 7 }))
        window.ContainerBackMotor:setGoal(Flipper[instant and "Instant" or "Spring"].new(0, { frequency = 9 }))
    end
    if instant then show() else
        window.ContainerBackMotor:setGoal(Flipper.Spring.new(1, { frequency = 13 }))
        window.ContainerPosMotor:setGoal(Flipper.Spring.new((window.ContentTop or 120) + 8, { frequency = 12 }))
        task.delay(0.08, show)
    end
    return true
end
return Tabs
