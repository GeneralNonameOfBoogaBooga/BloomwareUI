-- Bloomware UI, based on Fluent by dawid (MIT).
local Creator = require(script.Parent.Parent.Creator)
local Assets = require(script.Parent.Assets)
local New = Creator.New
return function(config)
    local Library = require(script.Parent.Parent)
    local bar = {}
    bar.Frame = New("Frame", {
        Name = "TitleBar", Size = UDim2.new(1, 0, 0, 64), BackgroundTransparency = 1, Parent = config.Parent,
    })
    bar.DragArea = New("TextButton", {
        Name = "DragArea", Size = UDim2.new(1, -124, 1, 0), BackgroundTransparency = 1, Text = "", Parent = bar.Frame,
    })
    New("Frame", {
        Size = UDim2.new(1, -32, 0, 1), Position = UDim2.new(0, 16, 1, -1),
        BackgroundTransparency = 0.25, Parent = bar.Frame, ThemeTag = { BackgroundColor3 = "TitleBarLine" },
    })
    local badge = New("Frame", {
        Name = "LogoBadge", Size = UDim2.fromOffset(38, 38), Position = UDim2.fromOffset(18, 13),
        BackgroundTransparency = 0.86, Visible = config.Logo ~= false, Parent = bar.DragArea,
        ThemeTag = { BackgroundColor3 = "Accent" },
    }, { New("UICorner", { CornerRadius = UDim.new(0, 11) }) })
    local fallback = New("TextLabel", {
        Text = "B", TextSize = 20, Size = UDim2.fromScale(1, 1), Parent = badge,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
        ThemeTag = { TextColor3 = "Accent" },
    })
    local logo = New("ImageLabel", {
        Name = "BloomLogo", Image = "", Size = UDim2.fromOffset(34, 34), Position = UDim2.fromOffset(2, 2),
        ScaleType = Enum.ScaleType.Fit, Visible = false, Parent = badge,
    })
    local left = config.Logo == false and 20 or 68
    bar.Title = New("TextLabel", {
        Text = config.Title, TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd, Size = UDim2.new(1, -left - 12, 0, 22),
        Position = UDim2.fromOffset(left, config.SubTitle == "" and 21 or 13), Parent = bar.DragArea,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
        ThemeTag = { TextColor3 = "Text" },
    })
    bar.SubTitle = New("TextLabel", {
        Text = config.SubTitle, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd, Size = UDim2.new(1, -left - 12, 0, 16),
        Position = UDim2.fromOffset(left, 35), Parent = bar.DragArea,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
        ThemeTag = { TextColor3 = "SubText" },
    })
    local alive = true
    Creator.AddSignal(bar.Frame.Destroying, function() alive = false end)
    if config.Logo ~= false then
        task.spawn(function()
            local uri = Assets.ResolveLogo(config.Logo)
            if not alive or not uri then return end
            logo.Image = uri
            logo.Visible = true
            fallback.Visible = false
        end)
    end
    local function button(icon, right, callback)
        local result = {}
        result.Frame = New("TextButton", {
            Text = "", Size = UDim2.fromOffset(28, 28), Position = UDim2.new(1, -right, 0, 18),
            BackgroundTransparency = 1, Parent = bar.Frame, ThemeTag = { BackgroundColor3 = "Tab" },
        }, {
            New("UICorner", { CornerRadius = UDim.new(0, 8) }),
            New("ImageLabel", {
                Name = "Icon", Image = icon, Size = UDim2.fromOffset(14, 14), Position = UDim2.fromOffset(7, 7),
                ThemeTag = { ImageColor3 = "SubText" },
            }),
        })
        local _, transparency = Creator.SpringMotor(1, result.Frame, "BackgroundTransparency")
        Creator.AddSignal(result.Frame.MouseEnter, function() transparency(0.86) end)
        Creator.AddSignal(result.Frame.MouseLeave, function() transparency(1, true) end)
        result.Callback = callback
        function result.SetCallback(nextCallback) result.Callback = nextCallback end
        Creator.AddSignal(result.Frame.Activated, function() if result.Callback then result.Callback() end end)
        return result
    end
    bar.MenuButton = button(Library:GetIcon("menu") or "", 0, function() config.Window:SetDrawer(not config.Window.DrawerOpen) end)
    bar.MenuButton.Frame.Name = "OpenNavigation"
    bar.MenuButton.Frame.Visible = false
    bar.MinButton = button(Assets.Min, 110, function() config.Window:Minimize() end)
    bar.MaxButton = button(Assets.Max, 76, function() config.Window.Maximize(not config.Window.Maximized) end)
    bar.CloseButton = button(Assets.Close, 42, function()
        config.Window:Dialog({ Title = "Close interface", Content = "Close this interface?", Buttons = {
            { Title = "Cancel" }, { Title = "Unload", Callback = function() Library:Destroy() end },
        } })
    end)
    function bar:Layout(mobile)
        self.Frame.Size = UDim2.new(1,0,0,mobile and 56 or 64)
        self.MenuButton.Frame.Visible = mobile
        self.MenuButton.Frame.Position = UDim2.fromOffset(6,6)
        self.MenuButton.Frame.Size = UDim2.fromOffset(44,44)
        self.MenuButton.Frame.Icon.Position = UDim2.fromOffset(14,14)
        self.MenuButton.Frame.Icon.Size = UDim2.fromOffset(16,16)
        self.MaxButton.Frame.Visible = not mobile
        self.DragArea.Position = UDim2.fromOffset(mobile and 52 or 0,0)
        self.DragArea.Size = UDim2.new(1,mobile and -152 or -124,1,0)
        badge.Size = UDim2.fromOffset(mobile and 32 or 38,mobile and 32 or 38)
        badge.Position = UDim2.fromOffset(mobile and 0 or 18,mobile and 12 or 13)
        logo.Size = UDim2.fromOffset(mobile and 30 or 34,mobile and 30 or 34)
        logo.Position = UDim2.fromOffset(mobile and 1 or 2,mobile and 1 or 2)
        local textLeft = config.Logo == false and (mobile and 0 or 20) or (mobile and 42 or 68)
        self.Title.Position = UDim2.fromOffset(textLeft,mobile and (config.SubTitle == "" and 17 or 9) or (config.SubTitle == "" and 21 or 13))
        self.Title.Size = UDim2.new(1,-textLeft-8,0,22)
        self.Title.TextSize = mobile and 14 or 16
        self.SubTitle.Position = UDim2.fromOffset(textLeft,mobile and 31 or 35)
        self.SubTitle.Size = UDim2.new(1,-textLeft-8,0,16)
        for _,item in ipairs({{self.MinButton,mobile and 94 or 110},{self.CloseButton,mobile and 48 or 42}}) do
            local frame=item[1].Frame
            frame.Size = UDim2.fromOffset(mobile and 44 or 28,mobile and 44 or 28)
            frame.Position = UDim2.new(1,-item[2],0,mobile and 6 or 18)
            frame.Icon.Position = UDim2.fromOffset(mobile and 15 or 7,mobile and 15 or 7)
        end
    end
    return bar
end
