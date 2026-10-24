-- Bloomware UI 1.5: Fluent and Fluent Renewed compatible API.
local LocalPlayer = game:GetService("Players").LocalPlayer
local Creator = require(script.Creator)
local Elements = require(script.Elements)
local Acrylic = require(script.Acrylic)
local Notification = require(script.Components.Notification)
local Compatibility = require(script.Compatibility)
local Themes = require(script.Themes)
local IconProvider = require(script.IconProvider)
local ScreenGui = Creator.New("ScreenGui", { Name = "BloomwareUI" })
assert(LocalPlayer, "Bloomware UI must be loaded on the client.")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
Notification:Init(ScreenGui)

local Fluent = {
    Version = "1.5.0", OpenFrames = {}, Options = {},
    Themes = Themes.Names, Loaded = true, CreatedWindow = nil,
    Window = nil, WindowFrame = nil, Unloaded = false, Theme = "Dark",
    DialogOpen = false, UseAcrylic = false, Acrylic = false, Transparency = true,
    MinimizeKeybind = nil, MinimizeKey = Enum.KeyCode.LeftControl, GUI = ScreenGui,
}
Fluent.Flags = Fluent.Options
Fluent.Connections = Creator.Signals
Fluent.UIContainer = ScreenGui.Parent
Fluent.Utilities = Compatibility.Utilities(Fluent, Creator, Themes, IconProvider)
Fluent.OnUnload, Fluent.PostUnload, Fluent.ThemeChanged = Compatibility.Signal(), Compatibility.Signal(), Compatibility.Signal()

local layoutEvent = Instance.new("BindableEvent")
layoutEvent.Name = "LayoutChanged"
layoutEvent.Parent = ScreenGui
Fluent.LayoutChanged = layoutEvent.Event
Fluent._LayoutEvent = layoutEvent
Fluent.Search = require(script.SearchIndex).new()

function Fluent:SafeCallback(callback, ...)
    if not callback or self.Unloaded then return true end
    if self._CallbackQueue then
        table.insert(self._CallbackQueue, { Callback=callback, Args=table.pack(...) })
        return true
    end
    local success, result = pcall(callback, ...)
    if not success then
        result = tostring(result)
        self:Notify({ Title = "Interface", Content = "Callback error", SubContent = result:gsub("^.-:%d+: ", ""), Duration = 5 })
    end
    return success, result
end

function Fluent:Round(value, decimals)
    local factor = 10 ^ (decimals or 0)
    return math.floor(tonumber(value) * factor + 0.5) / factor
end

function Fluent:GetIcon(name)
    local icon = IconProvider:GetIcon(name)
    return icon and icon.Image or nil
end
function Fluent:GetIconData(name) return IconProvider:GetIcon(name) end

local elementMethods = {}
elementMethods.__index = elementMethods
for _, element in ipairs(Elements) do
    local kind = element.__type
    local function add(container, first, second)
        -- Per-call context prevents callbacks from being redirected to a later tab.
        local context = setmetatable({
            Container = container.Container, Type = container.Type,
            ScrollFrame = container.ScrollFrame, Library = Fluent,
            Tab = container.Tab, SectionName = container.SectionName,
            InlineCard = container.InlineCard, InlineParent = container.InlineParent, _LinkedToggle = container._LinkedToggle,
        }, { __index = element })
        local id, config = Compatibility.Arguments(Fluent, kind, first, second)
        local option
        if kind == "Button" or kind == "Paragraph" then option = element.New(context, config)
        else option = element.New(context, id, config) end
        local card = option._Element or (option.Frame and option)
        if card then
            Compatibility.Attach(Fluent, option, card, config, id, kind)
            if config.Searchable ~= false and not container.InlineCard then
                Fluent.Search:Add(card, { Tab=container.Tab, Section=container.SectionName, Id=id })
                local function refreshSearch() if Fluent.Search.Changed then Fluent.Search.Changed() end end
                Creator.AddSignal(card.TitleLabel:GetPropertyChangedSignal("Text"), refreshSearch, card.Frame)
                Creator.AddSignal(card.DescLabel:GetPropertyChangedSignal("Text"), refreshSearch, card.Frame)
            end
            if Fluent.Profiles then Fluent.Profiles:Register(id, option, config) end
            Creator.AddSignal((option._Owner or card.Frame).Destroying, function()
                if not container.InlineCard then Fluent.Search:Remove(card) end
                if Fluent.Profiles then Fluent.Profiles:Unregister(id, option) end
                if id ~= nil and Fluent.Options[id] == option then Fluent.Options[id] = nil end
            end)
        end
        return option
    end
    elementMethods["Add" .. kind], elementMethods["Create" .. kind], elementMethods[kind] = add, add, add
end
for alias, kind in pairs({ColorPicker="Colorpicker", Textbox="Input", TextBox="Input"}) do
    for _, prefix in ipairs({"Add", "Create", ""}) do elementMethods[prefix .. alias] = elementMethods["Add" .. kind] end
end
Fluent.Elements = elementMethods

function Fluent:CreateWindow(config)
    assert(type(config) == "table", "Window - Expected a configuration table")
    config = table.clone(config)
    config.Title = config.Title or "Bloomware UI"
    if self.Unloaded then error("This interface has been destroyed; load a new instance.") end
    if self.CreatedWindow then return self.CreatedWindow end
    self.MinimizeKey = config.MinimizeKey or self.MinimizeKey
    self.UseAcrylic = config.Acrylic == true
    self.Acrylic = self.UseAcrylic
    if self.UseAcrylic then Acrylic.init() end
    self.Profiles = require(script.Profiles).new(self, config)
    local window = require(script.Components.Window)({
        Parent = ScreenGui, Size = config.Size or UDim2.fromOffset(840, 560),
        Title = config.Title, SubTitle = config.SubTitle or "", TabWidth = config.TabWidth or 174,
        Logo = config.Logo, AutoScale = config.AutoScale ~= false, MobileMode=config.MobileMode, Search=config.Search ~= false, Profiles=config.Profiles ~= false,
        MinSize = config.MinSize, Resize = config.Resize, Mobile = config.Mobile,
    })
    self.Window, self.CreatedWindow = window, window
    setmetatable(window, { __call = function(_, library, options) return library:CreateWindow(options) end })
    self.WindowFrame = window.Root
    self:SetTheme(config.Theme or "Dark")
    self:ToggleTransparency(config.Transparency ~= false)
    self.Appearance = require(script.Appearance).new(self, config)
    if config.Appearance ~= false then self.Appearance:BindWindow(window) end
    return window
end
function Fluent:AddWindow(config) return self:CreateWindow(config) end

function Fluent:SetBackgroundImage(source)
    if not self.Appearance then return false, "Create an interface window first." end
    return self.Appearance:Apply(source)
end

function Fluent:ClearBackgroundImage()
    if not self.Appearance then return false end
    return self.Appearance:Clear()
end

function Fluent:SetBackgroundTransparency(value)
    if not self.Appearance then return false end
    local ok = self.Appearance:SetTransparency(value)
    self.Appearance:_Sync(false)
    return ok
end

function Fluent:SetBackgroundDarkness(value)
    if not self.Appearance then return false end
    local ok = self.Appearance:SetDarkness(value)
    self.Appearance:_Sync(false)
    return ok
end

function Fluent:SetBackgroundScaleType(value)
    if not self.Appearance then return false end
    local ok = self.Appearance:SetScaleType(value)
    self.Appearance:_Sync(false)
    return ok
end

function Fluent:SetTheme(name)
    if table.find(self.Themes, name) then
        local changed = self.Theme ~= name
        self.Theme = name; Creator.UpdateTheme()
        if changed and self.Profiles then self.Profiles:MarkDirty() end
        if changed then self.ThemeChanged:Fire(name) end
    end
end

function Fluent:ClosePopups()
    for _, option in pairs(self.Options) do
        if option.Type == "Dropdown" and option.Opened then option:Close() end
    end
end

function Fluent:Destroy()
    if self.Unloaded then return end
    self:ClosePopups()
    self.Unloaded = true
    self.Loaded = false
    self.OnUnload:Fire(os.clock())
    if self.Appearance then self.Appearance:Destroy() end
    if self.CreatedWindow then self.CreatedWindow:Destroy() end
    Acrylic.Destroy()
    Creator.Disconnect()
    ScreenGui:Destroy()
    table.clear(self.Options)
    table.clear(self.OpenFrames)
    self.Search:Destroy()
    if self.Profiles then self.Profiles:Destroy() end
    self.Window = nil
    self.CreatedWindow = nil
    self.WindowFrame = nil
    self.Appearance = nil
    self.PostUnload:Fire(os.clock())
    self.OnUnload:Destroy(); self.PostUnload:Destroy(); self.ThemeChanged:Destroy()
end

function Fluent:ToggleAcrylic(enabled)
    if not self.CreatedWindow or not self.UseAcrylic then return end
    self.Acrylic = enabled == true
    if self.Acrylic then Acrylic.Enable() else Acrylic.Disable() end
    self.Window.AcrylicPaint.SetVisibility(not self.Window.Minimized)
end

function Fluent:ToggleTransparency(enabled)
    local changed = self.Transparency ~= (enabled == true)
    self.Transparency = enabled == true
    if changed and self.Profiles then self.Profiles:MarkDirty() end
    if self.CreatedWindow then self.Window.AcrylicPaint.Frame.Background.BackgroundTransparency = self.Transparency and 0.06 or 0 end
end

function Fluent:Notify(config)
    if self.Unloaded then return nil end
    return Notification:New(config)
end

-- Renewed's :Window alias coexists with original Fluent's .Window instance.
Fluent.Window = Fluent.CreateWindow
return Fluent
