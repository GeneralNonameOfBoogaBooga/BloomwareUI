-- Bloomware UI, based on Fluent by dawid (MIT).
local Creator = require(script.Parent.Parent.Creator)
local New = Creator.New
return function()
    local paint = {}
    local background = New("Frame", {
        Name = "Background", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0.06,
        ThemeTag = { BackgroundColor3 = "AcrylicMain" },
    }, { New("UICorner", { CornerRadius = UDim.new(0, 14) }) })
    paint.BackgroundImage = New("ImageLabel", {
        Name = "CustomBackground", Size = UDim2.fromScale(1, 1), Visible = false,
        BackgroundTransparency = 1, Image = "", ImageTransparency = 0.25,
        ScaleType = Enum.ScaleType.Crop, Active = false,
    }, { New("UICorner", { CornerRadius = UDim.new(0, 14) }) })
    paint.BackgroundOverlay = New("Frame", {
        Name = "BackgroundDim", Size = UDim2.fromScale(1, 1), Visible = false,
        BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.65, Active = false,
    }, { New("UICorner", { CornerRadius = UDim.new(0, 14) }) })
    paint.Frame = New("Frame", {
        Name = "WindowSurface", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
    }, {
        New("ImageLabel", {
            Image = "rbxassetid://8992230677", ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(Vector2.new(99, 99), Vector2.new(99, 99)),
            Size = UDim2.new(1, 70, 1, 70), Position = UDim2.fromOffset(-35, -28),
            ImageColor3 = Color3.fromRGB(0, 0, 0), ImageTransparency = 0.48,
        }), background, paint.BackgroundImage, paint.BackgroundOverlay,
        New("Frame", {
            Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.94,
        }, {
            New("UICorner", { CornerRadius = UDim.new(0, 14) }),
            New("UIGradient", { Rotation = 115, ThemeTag = { Color = "AcrylicGradient" } }),
        }),
        New("ImageLabel", {
            Image = "rbxassetid://9968344227", ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(128, 128),
            Size = UDim2.fromScale(1, 1), ThemeTag = { ImageTransparency = "AcrylicNoise" },
        }, { New("UICorner", { CornerRadius = UDim.new(0, 14) }) }),
        New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 }, {
            New("UICorner", { CornerRadius = UDim.new(0, 14) }),
            New("UIStroke", { Transparency = 0.3, Thickness = 1, ThemeTag = { Color = "AcrylicBorder" } }),
        }),
    })
    paint.SetVisibility = function() end
    paint.AddParent = function() end
    if require(script.Parent.Parent).UseAcrylic then
        local blur = require(script.Parent.AcrylicBlur)()
        blur.Frame.Parent = paint.Frame
        paint.Model, paint.AddParent, paint.SetVisibility = blur.Model, blur.AddParent, blur.SetVisibility
    end
    return paint
end
