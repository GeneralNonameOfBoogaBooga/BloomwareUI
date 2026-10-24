-- Bloomware UI: background settings shared by Settings and JSON profiles.
local ContentProvider = game:GetService("ContentProvider")
local Creator = require(script.Parent.Creator)
local Assets = require(script.Parent.Components.Assets)
local Appearance = {}
Appearance.__index = Appearance
local scaleLabels = { Crop = "Fill", Fit = "Fit", Stretch = "Stretch" }
local scaleValues = { Fill = "Crop", Fit = "Fit", Stretch = "Stretch" }
local function finite(value) return type(value) == "number" and value == value and math.abs(value) < math.huge end
local function fraction(value, fallback) return finite(value) and math.clamp(value, 0, 1) or fallback end

function Appearance.ValidateState(state)
    if type(state) ~= "table" or type(state.Source) ~= "string" then return false end
    local source = Assets.NormalizeImageSource(state.Source)
    return source ~= nil and finite(state.Transparency) and state.Transparency >= 0 and state.Transparency <= 1
        and finite(state.Darkness) and state.Darkness >= 0 and state.Darkness <= 1 and scaleLabels[state.ScaleType] ~= nil
end

function Appearance.new(library, config)
    local self = setmetatable({
        Library = library, Paint = library.Window.AcrylicPaint, Generation = 0,
        State = { Source = "", Transparency = fraction(config.BackgroundTransparency, 0.25),
            Darkness = fraction(config.BackgroundDarkness, 0.35), ScaleType = scaleLabels[config.BackgroundScaleType] and config.BackgroundScaleType or "Crop" },
        Status = "No background selected. Enter a direct PNG/JPG URL or a Roblox asset ID.",
    }, Appearance)
    self:_Render()
    Creator.AddSignal(library.Window.Root.Destroying, function() self:Destroy() end)
    if config.BackgroundImage and config.BackgroundImage ~= "" then
        self:Apply(config.BackgroundImage, true)
    end
    return self
end

function Appearance:Snapshot()
    return { Source = self.State.Source, Transparency = self.State.Transparency,
        Darkness = self.State.Darkness, ScaleType = self.State.ScaleType }
end

function Appearance:_Status(message, failed)
    if self.Destroyed then return end
    self.Status = message
    if self.StatusCard then self.StatusCard:SetDesc(message) end
    if failed then self.Library:Notify({Title = "Appearance", Content = message, Duration = 6}) end
end

function Appearance:_Dirty()
    if self.Library.Profiles then self.Library.Profiles:MarkDirty() end
end

function Appearance:_Render()
    if self.Destroyed then return end
    local state = self.State
    self.Paint.BackgroundImage.ImageTransparency = state.Transparency
    self.Paint.BackgroundImage.ScaleType = Enum.ScaleType[state.ScaleType]
    self.Paint.BackgroundImage.Visible = state.Source ~= ""
    self.Paint.BackgroundOverlay.BackgroundTransparency = 1 - state.Darkness
    self.Paint.BackgroundOverlay.Visible = state.Source ~= ""
end

function Appearance:_Sync(includeSource)
    if not self.Controls or self.Destroyed then return end
    self.Syncing = true
    if includeSource then self.Controls.Source:SetValue(self.State.Source) end
    self.Controls.Transparency:SetValue(self.State.Transparency * 100)
    self.Controls.Darkness:SetValue(self.State.Darkness * 100)
    self.Controls.ScaleType:SetValue(scaleLabels[self.State.ScaleType])
    self.Syncing = false
end

function Appearance:SetTransparency(value, quiet)
    if self.Destroyed or not finite(value) then return false end
    value = math.clamp(value, 0, 1)
    local changed = self.State.Transparency ~= value
    self.State.Transparency = value
    self:_Render()
    if changed and not quiet then self:_Dirty() end
    return true
end

function Appearance:SetDarkness(value, quiet)
    if self.Destroyed or not finite(value) then return false end
    value = math.clamp(value, 0, 1)
    local changed = self.State.Darkness ~= value
    self.State.Darkness = value
    self:_Render()
    if changed and not quiet then self:_Dirty() end
    return true
end

function Appearance:SetScaleType(value, quiet)
    if self.Destroyed or not scaleLabels[value] then return false end
    local changed = self.State.ScaleType ~= value
    self.State.ScaleType = value
    self:_Render()
    if changed and not quiet then self:_Dirty() end
    return true
end

function Appearance:_Cancel()
    self.Generation = self.Generation + 1
    self.Loading = false
    self.PendingSource = nil
    if self.Timeout then pcall(task.cancel, self.Timeout); self.Timeout = nil end
    if self.Probe then self.Probe:Destroy(); self.Probe = nil end
end

function Appearance:Clear(quiet)
    if self.Destroyed then return false end
    self:_Cancel()
    local changed = self.State.Source ~= ""
    self.State.Source = ""
    self.Paint.BackgroundImage.Image = ""
    self:_Render()
    self:_Sync(true)
    self:_Status("Background removed. You can choose another image.")
    if changed and not quiet then self:_Dirty() end
    return true
end

function Appearance:Apply(source, quiet)
    if self.Destroyed then return false, "The interface is closed." end
    self:_Cancel()
    local normalized, message = Assets.NormalizeImageSource(source)
    if not normalized then self:_Status(message, true); return false, message end
    if normalized == "" then return self:Clear(quiet) end
    local generation = self.Generation
    self.Loading = true
    self.PendingSource = normalized
    self:_Status("Loading image… The current background will stay until loading finishes.")
    if self.Controls then self.Controls.Source:SetValue(normalized) end
    local function current() return not self.Destroyed and self.Generation == generation end
    local function fail(reason)
        if not current() then return end
        self:_Cancel()
        self:_Status(reason, true)
    end
    local function commit(uri)
        if not current() then return end
        -- Assign only after URL/file validation, preserving the previous image on error.
        local assigned = pcall(function() self.Paint.BackgroundImage.Image = uri end)
        if not assigned then
            fail("Could not set the background image. Try another PNG/JPG or a Roblox asset ID.")
            return
        end
        self:_Cancel()
        local changed = self.State.Source ~= normalized
        self.State.Source = normalized
        self:_Render()
        self:_Status("Background applied. Appearance settings are included when saving profiles.")
        if changed and not quiet then self:_Dirty() end
    end
    self.Timeout = task.delay(20, function()
        self.Timeout = nil
        fail(normalized:match("^rbxassetid://")
            and "Roblox image loading timed out. Check the asset ID and try again."
            or "Image loading took too long. Check the URL and try again.")
    end)
    task.spawn(function()
        local ok, uri, reason = pcall(Assets.ResolveImage, normalized)
        if not current() then return end
        if not ok or not uri then fail(ok and reason or "Could not load the image."); return end
        -- URL images already passed PNG/JPG validation and the local-asset bridge.
        -- Native PreloadAsync/hidden IsLoaded are not authoritative for these URIs.
        -- Use the same direct Image assignment as the existing logo loader.
        if not normalized:match("^rbxassetid://") then commit(uri); return end
        local probe = Creator.New("ImageLabel", {
            Name = "BackgroundPreload", BackgroundTransparency = 1, Visible = false,
            Image = uri, Size = UDim2.fromOffset(1, 1), Parent = self.Library.GUI,
        })
        self.Probe = probe
        Creator.AddSignal(probe:GetPropertyChangedSignal("IsLoaded"), function()
            if current() and probe.IsLoaded then commit(uri) end
        end, probe)
        local fetchStatus
        local loaded = pcall(function()
            ContentProvider:PreloadAsync({probe}, function(_, status) fetchStatus = status end)
        end)
        if not current() then return end
        if probe.IsLoaded or fetchStatus == Enum.AssetFetchStatus.Success then
            commit(uri)
        elseif not loaded then
            fail("Could not verify the Roblox asset ID. Try a direct PNG/JPG URL.")
        elseif fetchStatus == Enum.AssetFetchStatus.Failure then
            fail("Roblox could not load this image. Check that the asset ID is accessible.")
        elseif fetchStatus == Enum.AssetFetchStatus.TimedOut then
            fail("Roblox image loading timed out. Check the asset ID and try again.")
        else
            -- A false IsLoaded flag alone is inconclusive. Observe changes until timeout.
            self:_Status("Waiting for Roblox to load the image…")
        end
    end)
    return true, "Background is loading."
end

function Appearance:Restore(state)
    if self.Destroyed or not Appearance.ValidateState(state) then return false end
    self:SetTransparency(state.Transparency, true)
    self:SetDarkness(state.Darkness, true)
    self:SetScaleType(state.ScaleType, true)
    self:_Sync(false)
    return self:Apply(state.Source, true)
end

function Appearance:Attach(tab)
    if self.Destroyed or self.Attached then return end
    self.Attached = tab
    local section = tab:AddSection("Appearance")
    local source = section:AddInput("Bloomware_BackgroundURL", {
        Title = "Background Image", Description = "Direct PNG/JPG URL or rbxassetid://ID",
        Default = self.PendingSource or self.State.Source, Placeholder = "https://…/background.png", Finished = true, MaxLength = 4096, IgnoreProfile = true,
    })
    section:AddButton({Title = "Apply Background", Description = "Load the image from the URL above",
        Callback = function() self:Apply(source.Value) end})
    section:AddButton({Title = "Remove Background", Description = "Restore the default interface background",
        Callback = function() self:Clear() end})
    local transparency = section:AddSlider("Bloomware_BackgroundTransparency", {
        Title = "Image Transparency", Description = "0 = opaque, 100 = invisible",
        Default = self.State.Transparency * 100, Min = 0, Max = 100, Rounding = 0, IgnoreProfile = true,
        Callback = function(value) if not self.Syncing then self:SetTransparency(value / 100) end end,
    })
    local darkness = section:AddSlider("Bloomware_BackgroundDarkness", {
        Title = "Background Dimming", Description = "Darken the image to keep text readable",
        Default = self.State.Darkness * 100, Min = 0, Max = 100, Rounding = 0, IgnoreProfile = true,
        Callback = function(value) if not self.Syncing then self:SetDarkness(value / 100) end end,
    })
    local scaleType = section:AddDropdown("Bloomware_BackgroundScaleType", {
        Title = "Image Scaling", Values = {"Fill", "Fit", "Stretch"},
        Default = scaleLabels[self.State.ScaleType], Multi = false, IgnoreProfile = true,
        Callback = function(value) if not self.Syncing then self:SetScaleType(scaleValues[value]) end end,
    })
    self.Controls = {Source = source, Transparency = transparency, Darkness = darkness, ScaleType = scaleType}
    self.StatusCard = section:AddParagraph({Title = "Interface Background", Content = self.Status})
end

-- Reuse Settings from the host script, or add it after the first user tab.
-- Deferring creation preserves the first tab's index and normal startup page.
function Appearance:BindWindow(window)
    local manager, addTab = self, window.AddTab
    function window:AddTab(options)
        local title = manager.Library.Search.Fold(options.Title)
        local isSettings = title == "settings" or title == "настройки"
        if isSettings and self.AppearanceTab then return self.AppearanceTab end
        local tab = addTab(self, options)
        if isSettings then
            self.AppearanceTab = tab
            manager:Attach(tab)
        elseif not self.AppearanceTab and not self._AppearanceScheduled then
            self._AppearanceScheduled = true
            task.defer(function()
                self._AppearanceScheduled = false
                if not self.Destroyed and not manager.Destroyed and not self.AppearanceTab then
                    self:AddTab({Title = "Settings", Icon = "settings"})
                end
            end)
        end
        return tab
    end
end

function Appearance:Destroy()
    if self.Destroyed then return end
    self:_Cancel()
    self.Destroyed = true
    self.Controls, self.StatusCard, self.Attached = nil, nil, nil
end

return Appearance
