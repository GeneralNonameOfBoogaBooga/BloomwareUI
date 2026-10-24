-- Fluent / Fluent Renewed argument and utility compatibility.
local Compatibility = {}
local mouseKeys = {
    MB1="MouseLeft", MouseButton1="MouseLeft", LeftMousebutton="MouseLeft", LeftMouseButton="MouseLeft",
    MB2="MouseRight", MouseButton2="MouseRight", RightMousebutton="MouseRight", RightMouseButton="MouseRight",
    MB3="MouseMiddle", MouseButton3="MouseMiddle", MiddleMousebutton="MouseMiddle", MiddleMouseButton="MouseMiddle",
}
function Compatibility.MobileMode(forced, viewport, input)
    if forced ~= nil then return forced == true end
    local touch = input.TouchEnabled == true
    local prefersTouch = touch and (input.PreferredInput == Enum.PreferredInput.Touch or input.KeyboardEnabled ~= true)
    local shortSide = math.min(viewport.X,viewport.Y)
    return viewport.X <= 720 or touch and (shortSide < 600 or prefersTouch and shortSide <= 900)
end

function Compatibility.KeyName(value)
    if value == nil then return nil end
    if type(value) ~= "string" then
        local ok, name = pcall(function() return value.Name end)
        if not ok or type(name) ~= "string" then return nil end
        value = name
    end
    value = value:gsub("^Enum%.KeyCode%.", ""):gsub("^Enum%.UserInputType%.", "")
    if value == "Unknown" then return "None" end
    return value
end

function Compatibility.InputName(value)
    local name = Compatibility.KeyName(value)
    return mouseKeys[name] or name
end

function Compatibility.Alignment(value)
    if type(value) == "string" then
        if value == "Middle" then value = "Center" end
        if value == "Left" or value == "Center" or value == "Right" then return Enum.TextXAlignment[value] end
        return nil
    end
    return value
end

function Compatibility.Arguments(library, kind, first, second)
    local id, config
    if type(first) == "table" then
        config = table.clone(first)
        id = config.Id or config.ID or config.Idx or config.Flag
    else
        id, config = first, type(second) == "table" and table.clone(second) or {}
    end
    if config.Default == nil then config.Default = config.Value end
    if kind == "Paragraph" then
        if config.Content == nil then config.Content = config.Value or "" end
    elseif kind == "Keybind" then
        config.Title = config.Title or "Keybind"
        config.Default = Compatibility.KeyName(config.Default) or "None"
    elseif kind == "Slider" then
        config.Title = config.Title or "Slider"
        config.Min = config.Min == nil and 0 or config.Min
        config.Default = config.Default == nil and config.Min or config.Default
    end
    if id == nil and kind ~= "Button" and kind ~= "Paragraph" then
        library._AutomaticOptionId = (library._AutomaticOptionId or 0) + 1
        id = "__Bloomware_" .. kind .. "_" .. library._AutomaticOptionId
    end
    return id, config
end

function Compatibility.Attach(library, option, card, config, id, kind)
    option.Instance = card
    option.Type = option.Type or kind
    option.Id = id
    if config.Changed and option.Changed == nil then option.Changed = config.Changed end
    local titleAlignment = Compatibility.Alignment(config.TitleAlignment)
    local descriptionAlignment = Compatibility.Alignment(config.DescriptionAlignment or config.ContentAlignment)
    if titleAlignment then card.TitleLabel.TextXAlignment = titleAlignment end
    if descriptionAlignment then card.DescLabel.TextXAlignment = descriptionAlignment end
    if id ~= nil then library.Options[id] = option end
end

function Compatibility.Signal()
    -- Schedule callbacks independently of the signal's lifetime. In particular,
    -- destroying the UI must not cancel queued OnUnload/PostUnload handlers.
    local signal = { _Connections={}, _Destroyed=false }
    function signal:Connect(callback)
        assert(not self._Destroyed, "Cannot connect to a destroyed signal")
        assert(type(callback)=="function", "Signal callback must be a function")
        local connection = {Connected=true,Callback=callback}
        local owner=self
        function connection:Disconnect()
            if not self.Connected then return end
            self.Connected=false
            local index=table.find(owner._Connections,self)
            if index then table.remove(owner._Connections,index) end
        end
        connection.Destroy=connection.Disconnect
        table.insert(self._Connections, connection)
        return connection
    end
    function signal:Once(callback)
        local connection=self:Connect(callback)
        connection.Once=true
        return connection
    end
    function signal:Wait()
        local thread=coroutine.running()
        self:Once(function(...) task.spawn(thread,...) end)
        return coroutine.yield()
    end
    function signal:Fire(...)
        if self._Destroyed then return end
        for _,connection in ipairs(table.clone(self._Connections))do
            if connection.Connected then
                if connection.Once then connection:Disconnect()end
                task.spawn(connection.Callback,...)
            end
        end
    end
    function signal:DisconnectAll()
        for _, connection in ipairs(table.clone(self._Connections)) do connection:Disconnect() end
        table.clear(self._Connections)
    end
    function signal:Destroy() self:DisconnectAll(); self._Destroyed=true end
    signal.connect, signal.once, signal.wait, signal.fire = signal.Connect, signal.Once, signal.Wait, signal.Fire
    return signal
end

function Compatibility.Utilities(library, creator, themes, icons)
    local utilities = { Creator=creator, Themes=themes, Icons=icons, Shared=shared or _G }
    function utilities:GetIcon(name) return icons:GetIcon(name) end
    function utilities:Resize(x, y)
        local camera = game:GetService("Workspace").CurrentCamera
        local viewport = camera and camera.ViewportSize or Vector2.new(1920, 1080)
        return viewport.X * x / 1920, viewport.Y * y / 1080
    end
    function utilities:Truncate(number, decimals, round)
        local factor = 10 ^ math.max(0, decimals or 0)
        return (round and math.floor(number * factor + 0.5) or math.floor(number * factor)) / factor
    end
    function utilities:Round(number, decimals) return self:Truncate(number, decimals, true) end
    function utilities:Prettify(value)
        if type(value) == "number" then return self:Round(value, 2) end
        local name = Compatibility.KeyName(value) or tostring(value)
        return (name:gsub("(%l)(%u)", "%1 %2"))
    end
    function utilities:Clone(value)
        if type(value) ~= "table" then return value, false end
        local copies = {}
        local function copy(item)
            if type(item) ~= "table" then return item end
            if copies[item] then return copies[item] end
            local result = {}; copies[item] = result
            for key, entry in pairs(item) do result[copy(key)] = copy(entry) end
            local meta = getmetatable(item)
            if type(meta) == "table" then setmetatable(result, meta) end
            return result
        end
        return copy(value), true
    end
    function utilities:GetOS()
        local ok, gui = pcall(game.GetService, game, "GuiService")
        if ok and gui then
            local success, console = pcall(gui.IsTenFootInterface, gui)
            if success and console then return "Console" end
            local windows, isWindows = pcall(function() return gui.IsWindows end)
            if windows and isWindows then return "Windows" end
        end
        local input = game:GetService("UserInputService")
        if library.Mobile or input.TouchEnabled and not input.KeyboardEnabled then return "Mobile" end
        return "Unknown"
    end
    return utilities
end

return Compatibility
