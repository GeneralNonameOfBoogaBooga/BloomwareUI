# Bloomware UI

A client-side UI library for Roblox, built on Fluent. It adds a revised layout, search, profiles, image backgrounds, and a mobile layout that keeps the window usable on smaller screens.

The library accepts both original Fluent and Fluent Renewed method names. You can keep an existing menu's `AddToggle` calls, use `CreateToggle`, or mix the two.

## Getting started

`BloomwareUI.lua` is the ready-to-use library. `Example.lua` builds a small menu with every standard control.

### Roblox Studio

1. Create a **ModuleScript** named `BloomwareUI` in `StarterPlayerScripts` and paste in `BloomwareUI.lua`.
2. Create a **LocalScript** beside it and paste in `Example.lua`.
3. Start a play test.

The library runs on the client and parents its `ScreenGui` to `PlayerGui`. No changes to your game's server scripts are needed.

For a smaller starting point:

```lua
local Library = require(script.Parent.BloomwareUI)

local Window = Library:CreateWindow({
    Title = "My project",
    AppId = "my-project",
    Size = UDim2.fromOffset(840, 560),
    Theme = "Dark",
    Acrylic = false,
    MinimizeKey = Enum.KeyCode.RightControl,
})

local Main = Window:AddTab({ Title = "Main", Icon = "home" })

Main:AddToggle("Enabled", {
    Title = "Enabled",
    Default = true,
    Callback = function(value)
        print("Enabled:", value)
    end,
})

Window:SelectTab(1)
```

### Loading a hosted file

If your environment provides `loadstring` and an HTTP loader, upload `BloomwareUI.lua` and use its direct source URL. Set `LIBRARY_URL` at the top of `Example.lua` to that URL. The example also supports a local `BloomwareUI.lua` file when `readfile` and `isfile` are available.

Use a raw source link, rather than a repository page. There is no required repository, account, or hosted loader built into the library.

## Controls

Both of these create the same toggle:

```lua
local first = Main:AddToggle("First", { Title = "First toggle", Default = false })
local second = Main:CreateToggle("Second", { Title = "Second toggle", Value = true })

first:OnChanged(function(value)
    print(value)
end)

second:SetValue(false)
```

Use a stable, unique ID for each saved control. `Default` is the usual starting value; Renewed's `Value` field is also accepted. A table-only call can provide `Id` inside its configuration.

| Control | Original name | Renewed name |
| --- | --- | --- |
| Button | `AddButton` | `CreateButton` |
| Paragraph | `AddParagraph` | `CreateParagraph` |
| Toggle | `AddToggle` | `CreateToggle` |
| Slider | `AddSlider` | `CreateSlider` |
| Dropdown | `AddDropdown` | `CreateDropdown` |
| Input | `AddInput` | `CreateInput` |
| Keybind | `AddKeybind` | `CreateKeybind` |
| Color picker | `AddColorpicker` | `CreateColorpicker` |

Short Renewed names such as `Main:Toggle(...)` work too. Windows accept `CreateWindow`, `AddWindow`, and `Window`; tabs accept `AddTab`, `CreateTab`, and `Tab`. Sections accept `AddSection`, `CreateSection`, and `Section`.

Paragraphs support either form:

```lua
Main:AddParagraph({ Title = "About", Content = "A short description." })

local Status = Main:CreateParagraph("Status", {
    Title = "Status",
    Content = "Waiting",
})

Status:SetValue("Ready")
```

Keybinds accept key names and `Enum.KeyCode` values. Mouse aliases include `MB1`, `MB2`, `MouseLeft`, and `MouseRight`. Toggle, hold, and always-on modes are supported.

The existing Fluent and Renewed `InterfaceManager` and `SaveManager` addons can use the library's `Options` table. Renewed's `Instance.CreatedAt` metadata is included. The addons remain separate downloads and still need any filesystem functions they use.

## Search and profiles

Search finds controls by title, description, section, and ID. Use the search button or **Ctrl+K** to open it. Selecting a result opens its tab and scrolls to the control.

Profiles save control values, the theme, and background settings. They are available from the **Profiles** button without an addon.

Choose a different `AppId` for each project. This keeps two menus in the same game from sharing a profile file. If `AppId` is omitted, the window title is used. `ProfileFile` can override the filename when file storage is available.

| Environment | Profile storage |
| --- | --- |
| Standard Roblox client / Studio | Current session |
| `readfile`, `writefile`, and `isfile` available | Local JSON file |
| `ProfileStorage` supplied | Your read/write adapter |

The profile panel supports JSON export and import. For storage supplied by your own game, pass an adapter:

```lua
local savedProfileJSON

local Window = Library:CreateWindow({
    Title = "My project",
    AppId = "my-project",
    ProfileStorage = {
        Read = function()
            return savedProfileJSON -- Return nil when there is no saved data.
        end,
        Write = function(json)
            savedProfileJSON = json
        end,
    },
})
```

This adapter keeps data in memory. Connect its two functions to your own storage if you want values to survive a new session.

Use `IgnoreProfile = true` on a control to leave it out of built-in profiles. JSON profiles support primitive values and colors; arbitrary Roblox objects in a dropdown are not portable profile values.

## Appearance

The library includes 58 themes. Change one with `Library:SetTheme("Amethyst Dark")`; `Library.Themes` contains the available names.

The Appearance section attaches to your **Settings** tab. If your menu does not create one, the library adds it after your first tabs. Set `Appearance = false` in `CreateWindow` to leave that section out.

For a background, use the Appearance controls or set one in code:

```lua
Library:SetBackgroundImage("rbxassetid://YOUR_IMAGE_ID")
Library:SetBackgroundTransparency(0.35)
Library:SetBackgroundDarkness(0.45)
Library:SetBackgroundScaleType("Crop")
```

`Crop`, `Fit`, and `Stretch` are available. Roblox asset IDs work in the normal client, subject to the asset's permissions. Direct PNG/JPG URLs need an environment with HTTP, local file writing, and a custom-asset function such as `getcustomasset`. The download limit is 12 MB.

The default title icon is a small **B** badge. To use your own image, pass `Logo = "rbxassetid://YOUR_IMAGE_ID"`. Set `Logo = false` to hide it. The library does not fetch a default logo from someone else's repository.

Lucide and Phosphor icon names can be used for tabs:

```lua
Window:AddTab({ Title = "People", Icon = "phosphor-users-bold" })
```

## Mobile

The window switches to a compact layout based on the viewport and input device. The tab list moves into a drawer, controls keep touch-sized targets, and the content area adjusts when the keyboard opens. The restore button can be dragged when the menu is minimized.

Automatic detection is usually enough. `MobileMode = true` forces the mobile layout; `MobileMode = false` forces the desktop layout.

## Working on the source

| Path | Contents |
| --- | --- |
| `BloomwareUI.lua` | Generated single-file library |
| `Example.lua` | Runnable example menu |
| `src/` | Editable source modules |
| `tools/build.py` | Standalone bundle builder |
| `tests/` | UI and compatibility tests |
| `THIRD_PARTY_NOTICES.md` | Upstream credits and license texts |

Edit the modules in `src/`, then rebuild from the project directory:

```sh
python3 tools/build.py
```

The builder only uses Python's standard library. To run the tests, install the [Luau CLI](https://github.com/luau-lang/luau) and run:

```sh
python3 tests/run.py --luau /path/to/luau
```

The tests use a Roblox API substitute. They cover control behavior, both Fluent APIs, addon configuration round trips, image loading, profiles, and mobile layout. They do not replace a visual check in Roblox.

## License and credits

Bloomware UI is released under the MIT license. It builds on [Fluent](https://github.com/dawid-scripts/Fluent) by dawid and uses API compatibility, themes, and icon data from [Fluent Renewed](https://github.com/ActualMasterOogway/Fluent-Renewed).

Animations use [Flipper](https://github.com/Reselim/Flipper). Icons come from [Lucide](https://lucide.dev/) and [Phosphor](https://phosphoricons.com/). Fluent's acrylic implementation also credits 7kayoh/Acrylic and richie0866/remote-spy.

Keep `LICENSE` and `THIRD_PARTY_NOTICES.md` with redistributed copies. The generated single-file build includes the notices as well.
