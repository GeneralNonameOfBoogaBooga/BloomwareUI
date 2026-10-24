-- Bloomware UI, based on Fluent by dawid (MIT).
local Themes = require(script.Parent.Themes)
local Flipper = require(script.Parent.Packages.Flipper)
local Creator = {
    Registry = {}, Signals = {}, TransparencyMotors = {},
    DefaultProperties = {
        ScreenGui = { ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling },
        Frame = { BorderSizePixel = 0 },
        ScrollingFrame = { BorderSizePixel = 0 },
        TextLabel = { BackgroundTransparency = 1, BorderSizePixel = 0, Text = "", TextSize = 14 },
        TextButton = { BorderSizePixel = 0, AutoButtonColor = false, Text = "", TextSize = 14 },
        TextBox = { BorderSizePixel = 0, ClearTextOnFocus = false, Text = "", TextSize = 14 },
        ImageLabel = { BackgroundTransparency = 1, BorderSizePixel = 0 },
        ImageButton = { BackgroundTransparency = 1, BorderSizePixel = 0, AutoButtonColor = false },
        CanvasGroup = { BorderSizePixel = 0 },
    },
}

function Creator.AddSignal(signal, callback, owner)
    local connection = signal:Connect(callback)
    table.insert(Creator.Signals, connection)
    if owner then
        local destroyConnection
        destroyConnection = owner.Destroying:Connect(function()
            connection:Disconnect()
            local index = table.find(Creator.Signals, connection)
            if index then table.remove(Creator.Signals, index) end
            local destroyIndex = table.find(Creator.Signals, destroyConnection)
            if destroyIndex then table.remove(Creator.Signals, destroyIndex) end
            destroyConnection:Disconnect()
        end)
        table.insert(Creator.Signals, destroyConnection)
    end
    return connection
end

function Creator.Disconnect()
    for _, connection in ipairs(Creator.Signals) do connection:Disconnect() end
    table.clear(Creator.Signals)
    for motor in pairs(Creator.TransparencyMotors) do motor:destroy() end
    table.clear(Creator.TransparencyMotors)
    table.clear(Creator.Registry)
end

function Creator.GetThemeProperty(key)
    local theme = Themes[require(script.Parent).Theme] or Themes.Dark
    local value = theme[key]
    if value ~= nil then return value end
    if key == "Sidebar" then return theme.DialogHolder or theme.AcrylicMain end
    return Themes.Dark[key]
end

local function applyTheme(object, tags)
    for property, tag in pairs(tags) do
        local value = Creator.GetThemeProperty(tag)
        if value ~= nil then object[property] = value end
    end
end

function Creator.UpdateTheme()
    for object, entry in pairs(Creator.Registry) do applyTheme(object, entry.Properties) end
    for motor in pairs(Creator.TransparencyMotors) do
        motor:setGoal(Flipper.Instant.new(Creator.GetThemeProperty("ElementTransparency")))
    end
end

function Creator.AddThemeObject(object, tags)
    if not Creator.Registry[object] then
        object.Destroying:Connect(function() Creator.Registry[object] = nil end)
    end
    Creator.Registry[object] = { Object = object, Properties = tags }
    applyTheme(object, tags)
    return object
end

function Creator.OverrideTag(object, tags)
    if Creator.Registry[object] then
        Creator.Registry[object].Properties = tags
        applyTheme(object, tags)
    else
        Creator.AddThemeObject(object, tags)
    end
end

function Creator.New(className, properties, children)
    local object = Instance.new(className)
    for key, value in pairs(Creator.DefaultProperties[className] or {}) do object[key] = value end
    for key, value in pairs(properties or {}) do
        if key ~= "ThemeTag" then object[key] = value end
    end
    for _, child in ipairs(children or {}) do child.Parent = object end
    if properties and properties.ThemeTag then Creator.AddThemeObject(object, properties.ThemeTag) end
    return object
end

function Creator.GetScale(object)
    local current, factor = object, 1
    while current do
        local scale = current:FindFirstChildOfClass("UIScale")
        if scale then factor = factor * math.max(scale.Scale, 0.01) end
        current = current.Parent
    end
    return factor
end

function Creator.SpringMotor(value, object, property, ignoreDialog, themed)
    local motor = Flipper.SingleMotor.new(value)
    motor:onStep(function(nextValue) object[property] = nextValue end)
    if themed then Creator.TransparencyMotors[motor] = true end
    object.Destroying:Connect(function()
        motor:destroy()
        Creator.TransparencyMotors[motor] = nil
    end)
    return motor, function(goal, force)
        if not ignoreDialog and not force and property == "BackgroundTransparency" and require(script.Parent).DialogOpen then return end
        motor:setGoal(Flipper.Spring.new(goal, { frequency = 8 }))
    end
end

return Creator
