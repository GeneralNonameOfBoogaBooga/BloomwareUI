-- In Studio, put a ModuleScript named BloomwareUI next to this LocalScript.
-- With a file-based loader, keep BloomwareUI.lua in the working directory.
-- If you host the library yourself, set LIBRARY_URL to its direct source URL.
local LIBRARY_URL = "https://raw.githubusercontent.com/GeneralNonameOfBoogaBooga/BloomwareUI/refs/heads/main/BloomwareUI.lua"

local Library
local module = script and script.Parent and script.Parent:FindFirstChild("BloomwareUI")
if module and module:IsA("ModuleScript") then
    Library = require(module)
elseif type(loadstring) == "function" and type(readfile) == "function" and type(isfile) == "function" and isfile("BloomwareUI.lua") then
    Library = assert(loadstring(readfile("BloomwareUI.lua")), "Could not compile BloomwareUI.lua")()
elseif LIBRARY_URL ~= "" then
    assert(type(loadstring) == "function", "Use a ModuleScript in Studio; the URL loader requires loadstring.")
    Library = assert(loadstring(game:HttpGet(LIBRARY_URL)), "Could not compile the library")()
else
    error("Add the BloomwareUI ModuleScript, place BloomwareUI.lua in the working directory, or set LIBRARY_URL.")
end

local Window = Library:CreateWindow({
    Title = "Bloomware UI",
    SubTitle = "Example",
    AppId = "bloomware-ui-example",
    Size = UDim2.fromOffset(840, 560),
    Theme = "Dark",
    Acrylic = false,
    MinimizeKey = Enum.KeyCode.RightControl,
    -- Logo = "rbxassetid://YOUR_IMAGE_ID",
})

local Tabs = {
    Overview = Window:AddTab({ Title = "Overview", Icon = "layout-dashboard" }),
    Controls = Window:CreateTab({ Title = "Controls", Icon = "sliders-horizontal" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

Tabs.Overview:AddParagraph({
    Title = "Start here",
    Content = "Try the controls, search for a setting, or save a profile. The menu works with a mouse, keyboard, or touch.",
})

Tabs.Overview:AddParagraph({
    Title = "Using an existing menu",
    Content = "Original Fluent and Fluent Renewed names are both supported. AddToggle and CreateToggle create the same control.",
})

local preview = Tabs.Overview:CreateParagraph("Preview", {
    Title = "Your selection",
    Content = "",
})

local state = {
    Enabled = true,
    Name = "My project",
    Amount = 50,
    Mode = "Balanced",
}

local function updatePreview()
    preview:SetValue(string.format(
        "%s\nEnabled: %s\nAmount: %d\nMode: %s",
        state.Name,
        tostring(state.Enabled),
        state.Amount,
        state.Mode
    ))
end

local General = Tabs.Controls:AddSection("General")
local enabled = General:AddToggle("Enabled", {
    Title = "Enable preview",
    Description = "A simple toggle with a saved value.",
    Default = true,
})
enabled:OnChanged(function(value)
    state.Enabled = value
    updatePreview()
end)

local name = General:CreateInput("ProjectName", {
    Title = "Project name",
    Default = "My project",
    Placeholder = "Enter a name",
    Finished = true,
    MaxLength = 60,
})
name:OnChanged(function(value)
    state.Name = value
    updatePreview()
end)

local amount = General:AddSlider("Amount", {
    Title = "Amount",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
})
amount:OnChanged(function(value)
    state.Amount = value
    updatePreview()
end)

local Choices = Tabs.Controls:Section("Choices")
local mode = Choices:CreateDropdown("Mode", {
    Title = "Layout preference",
    Values = { "Balanced", "Compact", "Detailed" },
    Default = "Balanced",
})
mode:OnChanged(function(value)
    state.Mode = value or "None"
    updatePreview()
end)

Choices:AddDropdown("Categories", {
    Title = "Categories",
    Description = "This one allows more than one selection.",
    Values = { "General", "Display", "Audio", "Input" },
    Multi = true,
    AllowNull = true,
    Default = { "General", "Display" },
})

local color = Choices:CreateColorpicker("PreviewColor", {
    Title = "Preview color",
    Default = Color3.fromRGB(96, 205, 255),
})
color:OnChanged(function(value)
    preview.TitleLabel.TextColor3 = value
end)

local Actions = Tabs.Controls:CreateSection("Actions")
Actions:AddKeybind("NotifyKey", {
    Title = "Show a notification",
    Description = "Press F8, or click the key to choose another one.",
    Default = "F8",
    Mode = "Toggle",
    Callback = function()
        Library:Notify({ Title = "Example", Content = "The keybind works.", Duration = 3 })
    end,
})

Actions:CreateButton({
    Title = "Open a dialog",
    Callback = function()
        Window:Dialog({
            Title = "Try a dialog",
            Content = "Buttons can run a callback before the dialog closes.",
            Buttons = {
                { Title = "Cancel" },
                { Title = "Confirm", Callback = function()
                    Library:Notify({ Title = "Example", Content = "Confirmed.", Duration = 3 })
                end },
            },
        })
    end,
})

Actions:AddButton({
    Title = "Reset the example",
    Callback = function()
        enabled:SetValue(true)
        name:SetValue("My project")
        amount:SetValue(50)
        mode:SetValue("Balanced")
        color:SetValueRGB(Color3.fromRGB(96, 205, 255))
    end,
})

local Interface = Tabs.Settings:AddSection("Interface")
Interface:AddDropdown("Theme", {
    Title = "Theme",
    Values = Library.Themes,
    Default = Library.Theme,
    Callback = function(value) Library:SetTheme(value) end,
})

Library.MinimizeKeybind = Interface:AddKeybind("MenuKey", {
    Title = "Minimize key",
    Default = Enum.KeyCode.RightControl,
})

Tabs.Settings:AddParagraph({
    Title = "Profiles and backgrounds",
    Content = "Use Profiles to save this menu's values. Appearance controls the background image. In Studio, use a Roblox image asset ID.",
})

Window:SelectTab(1)
updatePreview()

return Library, Window
