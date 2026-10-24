-- Imported from Fluent Renewed (ActualMasterOogway), MIT.
--[[
MIT License 

Copyright (c) 2024-present ActualMasterOogway

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]
local themes = {Names={"Vynixu", "Dark", "Darker", "Light", "Quiet Light", "Aqua", "Tomorrow Night Blue", "Abyss", "Amethyst", "Amethyst Dark", "Rose", "Yaru", "United Ubuntu", "Elementary", "Yaru Dark", "United GNOME", "Arc Dark", "Ambiance", "Adapta Nokto", "Monokai", "Monokai Classic", "Monokai Vibrant", "Monokai Dimmed", "Typewriter", "Dark Typewriter", "Kimbie Dark", "Solarized Dark", "Solarized Light", "DuoTone Dark Sea", "DuoTone Dark Sky", "DuoTone Dark Space", "DuoTone Dark Forest", "DuoTone Dark Earth", "VSC Dark+", "VSC Dark Modern", "VSC Dark High Contrast", "VSC Light+", "VSC Light Modern", "VSC Light High Contrast", "VSC Red", "VS Dark", "VS Light", "GitHub Dark", "GitHub Dark Dimmed", "GitHub Dark Default", "GitHub Dark High Contrast", "GitHub Dark Colorblind", "GitHub Light", "GitHub Light Default", "GitHub Light High Contrast", "GitHub Light Colorblind", "Viow Arabian", "Viow Arabian Mix", "Viow Darker", "Viow Flat", "Viow Light", "Viow Mars", "Viow Neon"}}
themes["Vynixu"] = {
	Accent = Color3.fromRGB(90, 235, 45),

	AcrylicMain = Color3.fromRGB(30, 30, 30),
	AcrylicBorder = Color3.fromRGB(60, 60, 60),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15)),
	AcrylicNoise = 0.94,

	TitleBarLine = Color3.fromRGB(65, 65, 65),
	Tab = Color3.fromRGB(100, 100, 100),

	Element = Color3.fromRGB(70, 70, 70),
	ElementBorder = Color3.fromRGB(25, 25, 25),
	InElementBorder = Color3.fromRGB(55, 55, 55),
	ElementTransparency = 0.82,

	DropdownFrame = Color3.fromRGB(120, 120, 120),
	DropdownHolder = Color3.fromRGB(35, 35, 35),
	DropdownBorder = Color3.fromRGB(25, 25, 25),

	Dialog = Color3.fromRGB(35, 35, 35),
	DialogHolder = Color3.fromRGB(25, 25, 25),
	DialogHolderLine = Color3.fromRGB(20, 20, 20),
	DialogButton = Color3.fromRGB(35, 35, 35),
	DialogButtonBorder = Color3.fromRGB(55, 55, 55),
	DialogBorder = Color3.fromRGB(50, 50, 50),
	DialogInput = Color3.fromRGB(45, 45, 45),
	DialogInputLine = Color3.fromRGB(120, 120, 120)
}
themes["Dark"] = {
	Accent = Color3.fromRGB(96, 205, 255),

	AcrylicMain = Color3.fromRGB(60, 60, 60),
	AcrylicBorder = Color3.fromRGB(90, 90, 90),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(40, 40, 40), Color3.fromRGB(40, 40, 40)),
	AcrylicNoise = 0.9,

	TitleBarLine = Color3.fromRGB(75, 75, 75),
	Tab = Color3.fromRGB(120, 120, 120),

	Element = Color3.fromRGB(120, 120, 120),
	ElementBorder = Color3.fromRGB(35, 35, 35),
	InElementBorder = Color3.fromRGB(90, 90, 90),
	ElementTransparency = 0.87,

	ToggleSlider = Color3.fromRGB(120, 120, 120),
	ToggleToggled = Color3.fromRGB(0, 0, 0),

	SliderRail = Color3.fromRGB(120, 120, 120),

	DropdownFrame = Color3.fromRGB(160, 160, 160),
	DropdownHolder = Color3.fromRGB(45, 45, 45),
	DropdownBorder = Color3.fromRGB(35, 35, 35),
	DropdownOption = Color3.fromRGB(120, 120, 120),

	Keybind = Color3.fromRGB(120, 120, 120),

	Input = Color3.fromRGB(160, 160, 160),
	InputFocused = Color3.fromRGB(10, 10, 10),
	InputIndicator = Color3.fromRGB(150, 150, 150),

	Dialog = Color3.fromRGB(45, 45, 45),
	DialogHolder = Color3.fromRGB(35, 35, 35),
	DialogHolderLine = Color3.fromRGB(30, 30, 30),
	DialogButton = Color3.fromRGB(45, 45, 45),
	DialogButtonBorder = Color3.fromRGB(80, 80, 80),
	DialogBorder = Color3.fromRGB(70, 70, 70),
	DialogInput = Color3.fromRGB(55, 55, 55),
	DialogInputLine = Color3.fromRGB(160, 160, 160),

	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(170, 170, 170),
	Hover = Color3.fromRGB(120, 120, 120),
	HoverChange = 0.07
}
themes["Darker"] = {
	Accent = Color3.fromRGB(72, 138, 182),

	AcrylicMain = Color3.fromRGB(30, 30, 30),
	AcrylicBorder = Color3.fromRGB(60, 60, 60),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromRGB(15, 15, 15)),
	AcrylicNoise = 0.94,

	TitleBarLine = Color3.fromRGB(65, 65, 65),
	Tab = Color3.fromRGB(100, 100, 100),

	Element = Color3.fromRGB(70, 70, 70),
	ElementBorder = Color3.fromRGB(25, 25, 25),
	InElementBorder = Color3.fromRGB(55, 55, 55),
	ElementTransparency = 0.82,

	DropdownFrame = Color3.fromRGB(120, 120, 120),
	DropdownHolder = Color3.fromRGB(35, 35, 35),
	DropdownBorder = Color3.fromRGB(25, 25, 25),

	Dialog = Color3.fromRGB(35, 35, 35),
	DialogHolder = Color3.fromRGB(25, 25, 25),
	DialogHolderLine = Color3.fromRGB(20, 20, 20),
	DialogButton = Color3.fromRGB(35, 35, 35),
	DialogButtonBorder = Color3.fromRGB(55, 55, 55),
	DialogBorder = Color3.fromRGB(50, 50, 50),
	DialogInput = Color3.fromRGB(45, 45, 45),
	DialogInputLine = Color3.fromRGB(120, 120, 120)
}
themes["Light"] = {
	Accent = Color3.fromRGB(0, 103, 192),

	AcrylicMain = Color3.fromRGB(200, 200, 200),
	AcrylicBorder = Color3.fromRGB(120, 120, 120),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)),
	AcrylicNoise = 0.96,

	TitleBarLine = Color3.fromRGB(160, 160, 160),
	Tab = Color3.fromRGB(90, 90, 90),

	Element = Color3.fromRGB(255, 255, 255),
	ElementBorder = Color3.fromRGB(180, 180, 180),
	InElementBorder = Color3.fromRGB(150, 150, 150),
	ElementTransparency = 0.65,

	ToggleSlider = Color3.fromRGB(40, 40, 40),
	ToggleToggled = Color3.fromRGB(255, 255, 255),

	SliderRail = Color3.fromRGB(40, 40, 40),

	DropdownFrame = Color3.fromRGB(200, 200, 200),
	DropdownHolder = Color3.fromRGB(240, 240, 240),
	DropdownBorder = Color3.fromRGB(200, 200, 200),
	DropdownOption = Color3.fromRGB(150, 150, 150),

	Keybind = Color3.fromRGB(120, 120, 120),

	Input = Color3.fromRGB(200, 200, 200),
	InputFocused = Color3.fromRGB(100, 100, 100),
	InputIndicator = Color3.fromRGB(80, 80, 80),

	Dialog = Color3.fromRGB(255, 255, 255),
	DialogHolder = Color3.fromRGB(240, 240, 240),
	DialogHolderLine = Color3.fromRGB(228, 228, 228),
	DialogButton = Color3.fromRGB(255, 255, 255),
	DialogButtonBorder = Color3.fromRGB(190, 190, 190),
	DialogBorder = Color3.fromRGB(140, 140, 140),
	DialogInput = Color3.fromRGB(250, 250, 250),
	DialogInputLine = Color3.fromRGB(160, 160, 160),

	Text = Color3.fromRGB(41, 41, 41),
	SubText = Color3.fromRGB(40, 40, 40),
	Hover = Color3.fromRGB(50, 50, 50),
	HoverChange = 0.16
}
themes["Quiet Light"] = {
    Accent = Color3.fromHex("#9769dc"), -- focusBorder

    AcrylicMain = Color3.fromHex("#F5F5F5"), -- editor.background
    AcrylicBorder = Color3.fromHex("#c4b7d7"), -- titleBar.activeBackground
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#F5F5F5"), Color3.fromHex("#F5F5F5")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#c4b7d7"), -- titleBar.activeBackground
    Tab = Color3.fromHex("#705697"), -- activityBar.foreground

    Element = Color3.fromHex("#F2F2F2"), -- sideBar.background
    ElementBorder = Color3.fromHex("#adafb7"), -- inputOption.activeBorder
    InElementBorder = Color3.fromHex("#9769dc"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#705697"), -- activityBarBadge.background
    ToggleToggled = Color3.fromHex("#F5F5F5"), -- editor.background

    SliderRail = Color3.fromHex("#705697"), -- activityBarBadge.background

    DropdownFrame = Color3.fromHex("#F5F5F5"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#F5F5F5"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#adafb7"), -- inputOption.activeBorder
    DropdownOption = Color3.fromHex("#333333"), -- Default text color

    Keybind = Color3.fromHex("#F5F5F5"), -- editor.background

    Input = Color3.fromHex("#F5F5F5"), -- editor.background
    InputFocused = Color3.fromHex("#F5F5F5"), -- editor.background
    InputIndicator = Color3.fromHex("#AAAAAA"), -- editorWhitespace.foreground

    Dialog = Color3.fromHex("#F2F8FC"), -- peekViewEditor.background
    DialogHolder = Color3.fromHex("#F2F8FC"), -- peekViewResult.background
    DialogHolderLine = Color3.fromHex("#705697"), -- peekView.border
    DialogButton = Color3.fromHex("#F5F5F5"), -- editor.background
    DialogButtonBorder = Color3.fromHex("#adafb7"), -- inputOption.activeBorder
    DialogBorder = Color3.fromHex("#705697"), -- peekView.border
    DialogInput = Color3.fromHex("#F5F5F5"), -- editor.background
    DialogInputLine = Color3.fromHex("#9769dc"), -- focusBorder

    Text = Color3.fromHex("#333333"), -- Default foreground
    SubText = Color3.fromHex("#6D705B"), -- editorLineNumber.foreground
    Hover = Color3.fromHex("#e0e0e0"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["Aqua"] = {
	Accent = Color3.fromRGB(60, 165, 165),

	AcrylicMain = Color3.fromRGB(20, 20, 20),
	AcrylicBorder = Color3.fromRGB(50, 100, 100),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(60, 140, 140), Color3.fromRGB(40, 80, 80)),
	AcrylicNoise = 0.92,

	TitleBarLine = Color3.fromRGB(60, 120, 120),
	Tab = Color3.fromRGB(140, 180, 180),

	Element = Color3.fromRGB(110, 160, 160),
	ElementBorder = Color3.fromRGB(40, 70, 70),
	InElementBorder = Color3.fromRGB(80, 110, 110),
	ElementTransparency = 0.84,

	ToggleSlider = Color3.fromRGB(110, 160, 160),
	ToggleToggled = Color3.fromRGB(0, 0, 0),

	SliderRail = Color3.fromRGB(110, 160, 160),

	DropdownFrame = Color3.fromRGB(160, 200, 200),
	DropdownHolder = Color3.fromRGB(40, 80, 80),
	DropdownBorder = Color3.fromRGB(40, 65, 65),
	DropdownOption = Color3.fromRGB(110, 160, 160),

	Keybind = Color3.fromRGB(110, 160, 160),

	Input = Color3.fromRGB(110, 160, 160),
	InputFocused = Color3.fromRGB(20, 10, 30),
	InputIndicator = Color3.fromRGB(130, 170, 170),

	Dialog = Color3.fromRGB(40, 80, 80),
	DialogHolder = Color3.fromRGB(30, 60, 60),
	DialogHolderLine = Color3.fromRGB(25, 50, 50),
	DialogButton = Color3.fromRGB(40, 80, 80),
	DialogButtonBorder = Color3.fromRGB(80, 110, 110),
	DialogBorder = Color3.fromRGB(50, 100, 100),
	DialogInput = Color3.fromRGB(45, 90, 90),
	DialogInputLine = Color3.fromRGB(130, 170, 170),

	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(170, 170, 170),
	Hover = Color3.fromRGB(110, 160, 160),
	HoverChange = 0.04
}
themes["Tomorrow Night Blue"] = {
    Accent = Color3.fromHex("#bbdaff"), -- focusBorder

    AcrylicMain = Color3.fromHex("#002451"), -- editor.background
    AcrylicBorder = Color3.fromHex("#404f7d"), -- editorGroup.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#002451"), Color3.fromHex("#002451")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#404f7d"), -- editorGroup.border
    Tab = Color3.fromHex("#ffffff"), -- editor.foreground

    Element = Color3.fromHex("#001733"), -- input.background
    ElementBorder = Color3.fromHex("#404f7d"), -- editorGroup.border
    InElementBorder = Color3.fromHex("#bbdaff"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#bbdaff"), -- focusBorder
    ToggleToggled = Color3.fromHex("#001733"), -- input.background

    SliderRail = Color3.fromHex("#bbdaff"), -- focusBorder

    DropdownFrame = Color3.fromHex("#001733"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#001733"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#404f7d"), -- editorGroup.border
    DropdownOption = Color3.fromHex("#ffffff"), -- editor.foreground

    Keybind = Color3.fromHex("#001733"), -- input.background

    Input = Color3.fromHex("#001733"), -- input.background
    InputFocused = Color3.fromHex("#001733"), -- input.background
    InputIndicator = Color3.fromHex("#404f7d"), -- editorWhitespace.foreground

    Dialog = Color3.fromHex("#001c40"), -- editorWidget.background
    DialogHolder = Color3.fromHex("#001c40"), -- editorWidget.background
    DialogHolderLine = Color3.fromHex("#404f7d"), -- editorGroup.border
    DialogButton = Color3.fromHex("#001733"), -- input.background
    DialogButtonBorder = Color3.fromHex("#404f7d"), -- editorGroup.border
    DialogBorder = Color3.fromHex("#ffffff"), -- editorHoverWidget.border
    DialogInput = Color3.fromHex("#001733"), -- input.background
    DialogInputLine = Color3.fromHex("#bbdaff"), -- focusBorder

    Text = Color3.fromHex("#ffffff"), -- editor.foreground
    SubText = Color3.fromHex("#7285B7"), -- Comment color from tokenColors
    Hover = Color3.fromHex("#ffffff"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["Abyss"] = {
    Accent = Color3.fromRGB(102, 136, 204), -- #6688cc

    AcrylicMain = Color3.fromRGB(0, 12, 24), -- #000c18
    AcrylicBorder = Color3.fromRGB(43, 43, 74), -- #2b2b4a
    AcrylicGradient = ColorSequence.new(Color3.fromRGB(0, 12, 24), Color3.fromRGB(0, 12, 24)),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromRGB(43, 43, 74), -- #2b2b4a
    Tab = Color3.fromRGB(128, 162, 194), -- #80a2c2

    Element = Color3.fromRGB(24, 31, 47), -- #181f2f
    ElementBorder = Color3.fromRGB(43, 43, 74), -- #2b2b4a
    InElementBorder = Color3.fromRGB(0, 99, 165), -- #0063a5
    ElementTransparency = 0,

    ToggleSlider = Color3.fromRGB(0, 99, 165), -- #0063a5
    ToggleToggled = Color3.fromRGB(24, 31, 47), -- #181f2f

    SliderRail = Color3.fromRGB(0, 99, 165), -- #0063a5

    DropdownFrame = Color3.fromRGB(24, 31, 47), -- #181f2f
    DropdownHolder = Color3.fromRGB(24, 31, 47), -- #181f2f
    DropdownBorder = Color3.fromRGB(43, 43, 74), -- #2b2b4a
    DropdownOption = Color3.fromRGB(102, 136, 204), -- #6688cc

    Keybind = Color3.fromRGB(24, 31, 47), -- #181f2f

    Input = Color3.fromRGB(24, 31, 47), -- #181f2f
    InputFocused = Color3.fromRGB(24, 31, 47), -- #181f2f
    InputIndicator = Color3.fromRGB(64, 99, 133), -- #406385

    Dialog = Color3.fromRGB(38, 38, 65), -- #262641
    DialogHolder = Color3.fromRGB(6, 6, 33), -- #060621
    DialogHolderLine = Color3.fromRGB(43, 43, 74), -- #2b2b4a
    DialogButton = Color3.fromRGB(24, 31, 47), -- #181f2f
    DialogButtonBorder = Color3.fromRGB(43, 43, 74), -- #2b2b4a
    DialogBorder = Color3.fromRGB(43, 43, 74), -- #2b2b4a
    DialogInput = Color3.fromRGB(24, 31, 47), -- #181f2f
    DialogInputLine = Color3.fromRGB(0, 99, 165), -- #0063a5

    Text = Color3.fromRGB(102, 136, 204), -- #6688cc
    SubText = Color3.fromRGB(64, 99, 133), -- #406385
    Hover = Color3.fromRGB(8, 40, 107), -- #08286b
    HoverChange = 0.1
}
themes["Amethyst"] = {
	Accent = Color3.fromRGB(97, 62, 167),

	AcrylicMain = Color3.fromRGB(20, 20, 20),
	AcrylicBorder = Color3.fromRGB(110, 90, 130),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(85, 57, 139), Color3.fromRGB(40, 25, 65)),
	AcrylicNoise = 0.92,

	TitleBarLine = Color3.fromRGB(95, 75, 110),
	Tab = Color3.fromRGB(160, 140, 180),

	Element = Color3.fromRGB(140, 120, 160),
	ElementBorder = Color3.fromRGB(60, 50, 70),
	InElementBorder = Color3.fromRGB(100, 90, 110),
	ElementTransparency = 0.87,

	ToggleSlider = Color3.fromRGB(140, 120, 160),
	ToggleToggled = Color3.fromRGB(0, 0, 0),

	SliderRail = Color3.fromRGB(140, 120, 160),

	DropdownFrame = Color3.fromRGB(170, 160, 200),
	DropdownHolder = Color3.fromRGB(60, 45, 80),
	DropdownBorder = Color3.fromRGB(50, 40, 65),
	DropdownOption = Color3.fromRGB(140, 120, 160),

	Keybind = Color3.fromRGB(140, 120, 160),

	Input = Color3.fromRGB(140, 120, 160),
	InputFocused = Color3.fromRGB(20, 10, 30),
	InputIndicator = Color3.fromRGB(170, 150, 190),

	Dialog = Color3.fromRGB(60, 45, 80),
	DialogHolder = Color3.fromRGB(45, 30, 65),
	DialogHolderLine = Color3.fromRGB(40, 25, 60),
	DialogButton = Color3.fromRGB(60, 45, 80),
	DialogButtonBorder = Color3.fromRGB(95, 80, 110),
	DialogBorder = Color3.fromRGB(85, 70, 100),
	DialogInput = Color3.fromRGB(70, 55, 85),
	DialogInputLine = Color3.fromRGB(175, 160, 190),

	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(170, 170, 170),
	Hover = Color3.fromRGB(140, 120, 160),
	HoverChange = 0.04
}
themes["Amethyst Dark"] = {
    Accent = Color3.fromHex("#b133ff"),

    AcrylicMain = Color3.fromHex("#120024"),
    AcrylicBorder = Color3.fromHex("#4d057b"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#120024"), Color3.fromHex("#120024")),
    AcrylicNoise = 0.92,

    TitleBarLine = Color3.fromHex("#4d057b"),
    Tab = Color3.fromHex("#e9d9f2"),

    Element = Color3.fromHex("#25013c"),
    ElementBorder = Color3.fromHex("#4d057b"),
    InElementBorder = Color3.fromHex("#b133ff"),
    ElementTransparency = 0.85,

    ToggleSlider = Color3.fromHex("#7d16bf"),
    ToggleToggled = Color3.fromHex("#120024"),

    SliderRail = Color3.fromHex("#7d16bf"),

    DropdownFrame = Color3.fromHex("#25013c"),
    DropdownHolder = Color3.fromHex("#25013c"),
    DropdownBorder = Color3.fromHex("#4d057b"),
    DropdownOption = Color3.fromHex("#e9d9f2"),

    Keybind = Color3.fromHex("#25013c"),

    Input = Color3.fromHex("#180030"),
    InputFocused = Color3.fromHex("#180030"),
    InputIndicator = Color3.fromHex("#9e85ad"),

    Dialog = Color3.fromHex("#25013c"),
    DialogHolder = Color3.fromHex("#120024"),
    DialogHolderLine = Color3.fromHex("#4d057b"),
    DialogButton = Color3.fromHex("#25013c"),
    DialogButtonBorder = Color3.fromHex("#4d057b"),
    DialogBorder = Color3.fromHex("#4d057b"),
    DialogInput = Color3.fromHex("#180030"),
    DialogInputLine = Color3.fromHex("#b133ff"),

    Text = Color3.fromHex("#e9d9f2"),
    SubText = Color3.fromHex("#9e85ad"),
    Hover = Color3.fromHex("#4d057b"),
    HoverChange = 0.1
}
themes["Rose"] = {
	Accent = Color3.fromRGB(180, 55, 90),

	AcrylicMain = Color3.fromRGB(40, 40, 40),
	AcrylicBorder = Color3.fromRGB(130, 90, 110),
	AcrylicGradient = ColorSequence.new(Color3.fromRGB(190, 60, 135), Color3.fromRGB(165, 50, 70)),
	AcrylicNoise = 0.92,

	TitleBarLine = Color3.fromRGB(140, 85, 105),
	Tab = Color3.fromRGB(180, 140, 160),

	Element = Color3.fromRGB(200, 120, 170),
	ElementBorder = Color3.fromRGB(110, 70, 85),
	InElementBorder = Color3.fromRGB(120, 90, 90),
	ElementTransparency = 0.86,

	ToggleSlider = Color3.fromRGB(200, 120, 170),
	ToggleToggled = Color3.fromRGB(0, 0, 0),

	SliderRail = Color3.fromRGB(200, 120, 170),

	DropdownFrame = Color3.fromRGB(200, 160, 180),
	DropdownHolder = Color3.fromRGB(120, 50, 75),
	DropdownBorder = Color3.fromRGB(90, 40, 55),
	DropdownOption = Color3.fromRGB(200, 120, 170),

	Keybind = Color3.fromRGB(200, 120, 170),

	Input = Color3.fromRGB(200, 120, 170),
	InputFocused = Color3.fromRGB(20, 10, 30),
	InputIndicator = Color3.fromRGB(170, 150, 190),

	Dialog = Color3.fromRGB(120, 50, 75),
	DialogHolder = Color3.fromRGB(95, 40, 60),
	DialogHolderLine = Color3.fromRGB(90, 35, 55),
	DialogButton = Color3.fromRGB(120, 50, 75),
	DialogButtonBorder = Color3.fromRGB(155, 90, 115),
	DialogBorder = Color3.fromRGB(100, 70, 90),
	DialogInput = Color3.fromRGB(135, 55, 80),
	DialogInputLine = Color3.fromRGB(190, 160, 180),

	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(170, 170, 170),
	Hover = Color3.fromRGB(200, 120, 170),
	HoverChange = 0.04
}
themes["Yaru"] = {
    Accent = Color3.fromHex("#e95420"),

    AcrylicMain = Color3.fromHex("#edeef0"),
    AcrylicBorder = Color3.fromHex("#D4D4D4"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#edeef0"), Color3.fromHex("#edeef0")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#D4D4D4"),
    Tab = Color3.fromHex("#111111"),

    Element = Color3.fromHex("#FFFFFF"),
    ElementBorder = Color3.fromHex("#CECECE"),
    InElementBorder = Color3.fromHex("#e95420"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#e95420"),
    ToggleToggled = Color3.fromHex("#FFFFFF"),

    SliderRail = Color3.fromHex("#e95420"),

    DropdownFrame = Color3.fromHex("#FFFFFF"),
    DropdownHolder = Color3.fromHex("#FFFFFF"),
    DropdownBorder = Color3.fromHex("#CECECE"),
    DropdownOption = Color3.fromHex("#111111"),

    Keybind = Color3.fromHex("#FFFFFF"),

    Input = Color3.fromHex("#FFFFFF"),
    InputFocused = Color3.fromHex("#FFFFFF"),
    InputIndicator = Color3.fromHex("#767676"),

    Dialog = Color3.fromHex("#f6f6f6"),
    DialogHolder = Color3.fromHex("#FFFFFF"),
    DialogHolderLine = Color3.fromHex("#D4D4D4"),
    DialogButton = Color3.fromHex("#f6f6f6"),
    DialogButtonBorder = Color3.fromHex("#CECECE"),
    DialogBorder = Color3.fromHex("#D4D4D4"),
    DialogInput = Color3.fromHex("#FFFFFF"),
    DialogInputLine = Color3.fromHex("#e95420"),

    Text = Color3.fromHex("#111111"),
    SubText = Color3.fromHex("#6F6F6F"),
    Hover = Color3.fromHex("#E8E8E8"),
    HoverChange = 0.1
}
themes["United Ubuntu"] = {
    Accent = Color3.fromHex("#48b258"),

    AcrylicMain = Color3.fromHex("#1e1e1e"),
    AcrylicBorder = Color3.fromHex("#444444"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#1e1e1e"), Color3.fromHex("#1e1e1e")),
    AcrylicNoise = 0.92,

    TitleBarLine = Color3.fromHex("#444444"),
    Tab = Color3.fromHex("#dddddd"),

    Element = Color3.fromHex("#242424"),
    ElementBorder = Color3.fromHex("#404040"),
    InElementBorder = Color3.fromHex("#48b258"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#48b258"),
    ToggleToggled = Color3.fromHex("#1e1e1e"),

    SliderRail = Color3.fromHex("#48b258"),

    DropdownFrame = Color3.fromHex("#242424"),
    DropdownHolder = Color3.fromHex("#242424"),
    DropdownBorder = Color3.fromHex("#404040"),
    DropdownOption = Color3.fromHex("#dddddd"),

    Keybind = Color3.fromHex("#242424"),

    Input = Color3.fromHex("#242424"),
    InputFocused = Color3.fromHex("#242424"),
    InputIndicator = Color3.fromHex("#808080"),

    Dialog = Color3.fromHex("#242424"),
    DialogHolder = Color3.fromHex("#1e1e1e"),
    DialogHolderLine = Color3.fromHex("#404040"),
    DialogButton = Color3.fromHex("#242424"),
    DialogButtonBorder = Color3.fromHex("#404040"),
    DialogBorder = Color3.fromHex("#444444"),
    DialogInput = Color3.fromHex("#242424"),
    DialogInputLine = Color3.fromHex("#48b258"),

    Text = Color3.fromHex("#dddddd"),
    SubText = Color3.fromHex("#808080"),
    Hover = Color3.fromHex("#2A2D2E"),
    HoverChange = 0.05
}
themes["Elementary"] = {
    Accent = Color3.fromHex("#cb5226"),

    AcrylicMain = Color3.fromHex("#eff0f1"),
    AcrylicBorder = Color3.fromHex("#e9d18d"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#eff0f1"), Color3.fromHex("#eff0f1")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#e9d18d"),
    Tab = Color3.fromHex("#5e5e5e"),

    Element = Color3.fromHex("#fdf6e3"),
    ElementBorder = Color3.fromHex("#e9d18d"),
    InElementBorder = Color3.fromHex("#cb5226"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#cb5226"),
    ToggleToggled = Color3.fromHex("#fdf6e3"),

    SliderRail = Color3.fromHex("#cb5226"),

    DropdownFrame = Color3.fromHex("#fbefce"),
    DropdownHolder = Color3.fromHex("#fbefce"),
    DropdownBorder = Color3.fromHex("#e9d18d"),
    DropdownOption = Color3.fromHex("#5e5e5e"),

    Keybind = Color3.fromHex("#fdf6e3"),

    Input = Color3.fromHex("#fdf6e3"),
    InputFocused = Color3.fromHex("#fdf6e3"),
    InputIndicator = Color3.fromHex("#93a1a1"),

    Dialog = Color3.fromHex("#fbefce"),
    DialogHolder = Color3.fromHex("#fbefce"),
    DialogHolderLine = Color3.fromHex("#e9d18d"),
    DialogButton = Color3.fromHex("#fbefce"),
    DialogButtonBorder = Color3.fromHex("#e9d18d"),
    DialogBorder = Color3.fromHex("#e9d18d"),
    DialogInput = Color3.fromHex("#fdf6e3"),
    DialogInputLine = Color3.fromHex("#cb5226"),

    Text = Color3.fromHex("#5e5e5e"),
    SubText = Color3.fromHex("#93a1a1"),
    Hover = Color3.fromHex("#d6d6d6"),
    HoverChange = 0.1
}
themes["Yaru Dark"] = {
    Accent = Color3.fromHex("#e95420"),

    AcrylicMain = Color3.fromHex("#383838"),
    AcrylicBorder = Color3.fromHex("#444444"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#383838"), Color3.fromHex("#383838")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#444444"),
    Tab = Color3.fromHex("#FFFFFF"),

    Element = Color3.fromHex("#484848"),
    ElementBorder = Color3.fromHex("#404040"),
    InElementBorder = Color3.fromHex("#e95420"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#e95420"),
    ToggleToggled = Color3.fromHex("#2f2f2f"),

    SliderRail = Color3.fromHex("#e95420"),

    DropdownFrame = Color3.fromHex("#484848"),
    DropdownHolder = Color3.fromHex("#484848"),
    DropdownBorder = Color3.fromHex("#404040"),
    DropdownOption = Color3.fromHex("#FFFFFF"),

    Keybind = Color3.fromHex("#484848"),

    Input = Color3.fromHex("#484848"),
    InputFocused = Color3.fromHex("#484848"),
    InputIndicator = Color3.fromHex("#636e7b"),

    Dialog = Color3.fromHex("#434343"),
    DialogHolder = Color3.fromHex("#2f2f2f"),
    DialogHolderLine = Color3.fromHex("#404040"),
    DialogButton = Color3.fromHex("#484848"),
    DialogButtonBorder = Color3.fromHex("#404040"),
    DialogBorder = Color3.fromHex("#444444"),
    DialogInput = Color3.fromHex("#484848"),
    DialogInputLine = Color3.fromHex("#e95420"),

    Text = Color3.fromHex("#FFFFFF"),
    SubText = Color3.fromHex("#808080"),
    Hover = Color3.fromHex("#575757"),
    HoverChange = 0.1
}
themes["United GNOME"] = {
    Accent = Color3.fromHex("#48b258"),

    AcrylicMain = Color3.fromHex("#1e1e1e"),
    AcrylicBorder = Color3.fromHex("#444444"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#1e1e1e"), Color3.fromHex("#1e1e1e")),
    AcrylicNoise = 0.92,

    TitleBarLine = Color3.fromHex("#444444"),
    Tab = Color3.fromHex("#dddddd"),

    Element = Color3.fromHex("#242424"),
    ElementBorder = Color3.fromHex("#404040"),
    InElementBorder = Color3.fromHex("#48b258"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#48b258"),
    ToggleToggled = Color3.fromHex("#1e1e1e"),

    SliderRail = Color3.fromHex("#48b258"),

    DropdownFrame = Color3.fromHex("#242424"),
    DropdownHolder = Color3.fromHex("#242424"),
    DropdownBorder = Color3.fromHex("#404040"),
    DropdownOption = Color3.fromHex("#dddddd"),

    Keybind = Color3.fromHex("#242424"),

    Input = Color3.fromHex("#242424"),
    InputFocused = Color3.fromHex("#242424"),
    InputIndicator = Color3.fromHex("#808080"),

    Dialog = Color3.fromHex("#242424"),
    DialogHolder = Color3.fromHex("#1e1e1e"),
    DialogHolderLine = Color3.fromHex("#404040"),
    DialogButton = Color3.fromHex("#242424"),
    DialogButtonBorder = Color3.fromHex("#404040"),
    DialogBorder = Color3.fromHex("#444444"),
    DialogInput = Color3.fromHex("#242424"),
    DialogInputLine = Color3.fromHex("#48b258"),

    Text = Color3.fromHex("#dddddd"),
    SubText = Color3.fromHex("#808080"),
    Hover = Color3.fromHex("#2A2D2E"),
    HoverChange = 0.05
}
themes["Arc Dark"] = {
    Accent = Color3.fromHex("#5294e2"),

    AcrylicMain = Color3.fromHex("#383c4a"),
    AcrylicBorder = Color3.fromHex("#404f7d"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#383c4a"), Color3.fromHex("#383c4a")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#404f7d"),
    Tab = Color3.fromHex("#a2a2a2"),

    Element = Color3.fromHex("#4b5162"),
    ElementBorder = Color3.fromHex("#404f7d"),
    InElementBorder = Color3.fromHex("#5294e2"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#5294e2"),
    ToggleToggled = Color3.fromHex("#383c4a"),

    SliderRail = Color3.fromHex("#5294e2"),

    DropdownFrame = Color3.fromHex("#4b5162"),
    DropdownHolder = Color3.fromHex("#4b5162"),
    DropdownBorder = Color3.fromHex("#404f7d"),
    DropdownOption = Color3.fromHex("#a2a2a2"),

    Keybind = Color3.fromHex("#4b5162"),

    Input = Color3.fromHex("#4b5162"),
    InputFocused = Color3.fromHex("#4b5162"),
    InputIndicator = Color3.fromHex("#7285b7"),

    Dialog = Color3.fromHex("#434858"),
    DialogHolder = Color3.fromHex("#383c4a"),
    DialogHolderLine = Color3.fromHex("#404f7d"),
    DialogButton = Color3.fromHex("#4b5162"),
    DialogButtonBorder = Color3.fromHex("#404f7d"),
    DialogBorder = Color3.fromHex("#404f7d"),
    DialogInput = Color3.fromHex("#4b5162"),
    DialogInputLine = Color3.fromHex("#5294e2"),

    Text = Color3.fromHex("#a2a2a2"),
    SubText = Color3.fromHex("#7285b7"),
    Hover = Color3.fromHex("#4b5162"),
    HoverChange = 0.1
}
themes["Ambiance"] = {
    Accent = Color3.fromHex("#00BCD4"),

    AcrylicMain = Color3.fromHex("#29353b"),
    AcrylicBorder = Color3.fromHex("#222D32"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#29353b"), Color3.fromHex("#29353b")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#222D32"),
    Tab = Color3.fromHex("#EEFFFF"),

    Element = Color3.fromHex("#243035"),
    ElementBorder = Color3.fromHex("#222D32"),
    InElementBorder = Color3.fromHex("#00BCD4"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#00BCD4"),
    ToggleToggled = Color3.fromHex("#29353b"),

    SliderRail = Color3.fromHex("#00BCD4"),

    DropdownFrame = Color3.fromHex("#243035"),
    DropdownHolder = Color3.fromHex("#243035"),
    DropdownBorder = Color3.fromHex("#222D32"),
    DropdownOption = Color3.fromHex("#EEFFFF"),

    Keybind = Color3.fromHex("#243035"),

    Input = Color3.fromHex("#243035"),
    InputFocused = Color3.fromHex("#243035"),
    InputIndicator = Color3.fromHex("#546E7A"),

    Dialog = Color3.fromHex("#222D32"),
    DialogHolder = Color3.fromHex("#29353b"),
    DialogHolderLine = Color3.fromHex("#222D32"),
    DialogButton = Color3.fromHex("#243035"),
    DialogButtonBorder = Color3.fromHex("#222D32"),
    DialogBorder = Color3.fromHex("#222D32"),
    DialogInput = Color3.fromHex("#243035"),
    DialogInputLine = Color3.fromHex("#00BCD4"),

    Text = Color3.fromHex("#EEFFFF"),
    SubText = Color3.fromHex("#546E7A"),
    Hover = Color3.fromHex("#2D3B42"),
    HoverChange = 0.1
}
themes["Adapta Nokto"] = {
    Accent = Color3.fromHex("#ec6a3f"),

    AcrylicMain = Color3.fromHex("#31312e"),
    AcrylicBorder = Color3.fromHex("#403f3a"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#31312e"), Color3.fromHex("#31312e")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#403f3a"),
    Tab = Color3.fromHex("#dddddd"),

    Element = Color3.fromHex("#373633"),
    ElementBorder = Color3.fromHex("#403f3a"),
    InElementBorder = Color3.fromHex("#ec6a3f"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#ec6a3f"),
    ToggleToggled = Color3.fromHex("#31312e"),

    SliderRail = Color3.fromHex("#ec6a3f"),

    DropdownFrame = Color3.fromHex("#373633"),
    DropdownHolder = Color3.fromHex("#373633"),
    DropdownBorder = Color3.fromHex("#403f3a"),
    DropdownOption = Color3.fromHex("#dddddd"),

    Keybind = Color3.fromHex("#373633"),

    Input = Color3.fromHex("#373633"),
    InputFocused = Color3.fromHex("#373633"),
    InputIndicator = Color3.fromHex("#747c84"),

    Dialog = Color3.fromHex("#3c3b37"),
    DialogHolder = Color3.fromHex("#31312e"),
    DialogHolderLine = Color3.fromHex("#403f3a"),
    DialogButton = Color3.fromHex("#373633"),
    DialogButtonBorder = Color3.fromHex("#403f3a"),
    DialogBorder = Color3.fromHex("#403f3a"),
    DialogInput = Color3.fromHex("#373633"),
    DialogInputLine = Color3.fromHex("#ec6a3f"),

    Text = Color3.fromHex("#dddddd"),
    SubText = Color3.fromHex("#747c84"),
    Hover = Color3.fromHex("#403f3a"),
    HoverChange = 0.1
}
themes["Monokai"] = {
    Accent = Color3.fromHex("#F92672"), -- Using the keyword color as accent

    AcrylicMain = Color3.fromHex("#272822"), -- editor.background
    AcrylicBorder = Color3.fromHex("#414339"), -- dropdown.background
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#272822"), Color3.fromHex("#1e1f1c")), -- editor.background to editorGroupHeader.tabsBackground
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#414339"), -- dropdown.background
    Tab = Color3.fromHex("#f8f8f2"), -- editor.foreground

    Element = Color3.fromHex("#414339"), -- dropdown.background
    ElementBorder = Color3.fromHex("#75715E"), -- button.background
    InElementBorder = Color3.fromHex("#F92672"), -- keyword color
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#F92672"), -- keyword color
    ToggleToggled = Color3.fromHex("#414339"), -- dropdown.background

    SliderRail = Color3.fromHex("#75715E"), -- button.background

    DropdownFrame = Color3.fromHex("#414339"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#1e1f1c"), -- dropdown.listBackground
    DropdownBorder = Color3.fromHex("#75715E"), -- button.background
    DropdownOption = Color3.fromHex("#f8f8f2"), -- editor.foreground

    Keybind = Color3.fromHex("#414339"), -- dropdown.background

    Input = Color3.fromHex("#414339"), -- input.background
    InputFocused = Color3.fromHex("#414339"), -- input.background
    InputIndicator = Color3.fromHex("#90908a"), -- editorLineNumber.foreground

    Dialog = Color3.fromHex("#1e1f1c"), -- menu.background
    DialogHolder = Color3.fromHex("#1e1f1c"), -- menu.background
    DialogHolderLine = Color3.fromHex("#414339"), -- dropdown.background
    DialogButton = Color3.fromHex("#414339"), -- dropdown.background
    DialogButtonBorder = Color3.fromHex("#75715E"), -- button.background
    DialogBorder = Color3.fromHex("#75715E"), -- button.background
    DialogInput = Color3.fromHex("#414339"), -- input.background
    DialogInputLine = Color3.fromHex("#F92672"), -- keyword color

    Text = Color3.fromHex("#f8f8f2"), -- editor.foreground
    SubText = Color3.fromHex("#88846f"), -- comment color
    Hover = Color3.fromHex("#3e3d32"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["Monokai Classic"] = {
    Accent = Color3.fromHex("#75715E"), -- focusBorder

    AcrylicMain = Color3.fromHex("#272822"), -- editor.background
    AcrylicBorder = Color3.fromHex("#1e1f1c"), -- titleBar.activeBackground
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#272822"), Color3.fromHex("#272822")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#1e1f1c"), -- titleBar.activeBackground
    Tab = Color3.fromHex("#f8f8f2"), -- editor.foreground

    Element = Color3.fromHex("#414339"), -- dropdown.background
    ElementBorder = Color3.fromHex("#75715E"), -- button.background
    InElementBorder = Color3.fromHex("#75715E"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#75715E"), -- button.background
    ToggleToggled = Color3.fromHex("#272822"), -- editor.background

    SliderRail = Color3.fromHex("#75715E"), -- button.background

    DropdownFrame = Color3.fromHex("#414339"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#1e1f1c"), -- dropdown.listBackground
    DropdownBorder = Color3.fromHex("#75715E"), -- button.background
    DropdownOption = Color3.fromHex("#f8f8f2"), -- list.highlightForeground

    Keybind = Color3.fromHex("#414339"), -- dropdown.background

    Input = Color3.fromHex("#414339"), -- input.background
    InputFocused = Color3.fromHex("#414339"), -- input.background
    InputIndicator = Color3.fromHex("#90908a"), -- editorLineNumber.foreground

    Dialog = Color3.fromHex("#1e1f1c"), -- editorWidget.background
    DialogHolder = Color3.fromHex("#1e1f1c"), -- menu.background
    DialogHolderLine = Color3.fromHex("#414339"), -- panel.border
    DialogButton = Color3.fromHex("#414339"), -- dropdown.background
    DialogButtonBorder = Color3.fromHex("#75715E"), -- button.background
    DialogBorder = Color3.fromHex("#75715E"), -- editorHoverWidget.border
    DialogInput = Color3.fromHex("#414339"), -- input.background
    DialogInputLine = Color3.fromHex("#75715E"), -- focusBorder

    Text = Color3.fromHex("#f8f8f2"), -- editor.foreground
    SubText = Color3.fromHex("#88846f"), -- Comment color
    Hover = Color3.fromHex("#3e3d32"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["Monokai Vibrant"] = {
    Accent = Color3.fromHex("#528bff"), -- activityBarBadge.background

    AcrylicMain = Color3.fromHex("#16171D"), -- editor.background
    AcrylicBorder = Color3.fromHex("#181A1F"), -- editorGroup.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#16171D"), Color3.fromHex("#16171D")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#181A1F"), -- editorGroup.border
    Tab = Color3.fromHex("#f8f8f0"), -- editor.foreground

    Element = Color3.fromHex("#1d1f23"), -- dropdown.background
    ElementBorder = Color3.fromHex("#181A11"), -- dropdown.border
    InElementBorder = Color3.fromHex("#528bff"), -- activityBarBadge.background
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#528bff"), -- activityBarBadge.background
    ToggleToggled = Color3.fromHex("#16171D"), -- editor.background

    SliderRail = Color3.fromHex("#528bff"), -- activityBarBadge.background

    DropdownFrame = Color3.fromHex("#1d1f23"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#21252B"), -- editorGroupHeader.tabsBackground
    DropdownBorder = Color3.fromHex("#181A11"), -- dropdown.border
    DropdownOption = Color3.fromHex("#d7dae0"), -- activityBar.foreground

    Keybind = Color3.fromHex("#1d1f23"), -- input.background

    Input = Color3.fromHex("#1d1f23"), -- input.background
    InputFocused = Color3.fromHex("#1d1f23"), -- input.background
    InputIndicator = Color3.fromHex("#495162"), -- editorLineNumber.foreground

    Dialog = Color3.fromHex("#21252B"), -- editorWidget.background
    DialogHolder = Color3.fromHex("#21252B"), -- notifications.background
    DialogHolderLine = Color3.fromHex("#181A1F"), -- editorGroup.border
    DialogButton = Color3.fromHex("#1d1f23"), -- input.background
    DialogButtonBorder = Color3.fromHex("#181A11"), -- dropdown.border
    DialogBorder = Color3.fromHex("#181A1F"), -- editorHoverWidget.border
    DialogInput = Color3.fromHex("#1d1f23"), -- input.background
    DialogInputLine = Color3.fromHex("#528bff"), -- activityBarBadge.background

    Text = Color3.fromHex("#f8f8f0"), -- editor.foreground
    SubText = Color3.fromHex("#5c6370"), -- Comment color
    Hover = Color3.fromHex("#292d35"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["Monokai Dimmed"] = {
    Accent = Color3.fromHex("#3655b5"), -- focusBorder

    AcrylicMain = Color3.fromHex("#1e1e1e"), -- editor.background
    AcrylicBorder = Color3.fromHex("#303030"), -- tab.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#1e1e1e"), Color3.fromHex("#1e1e1e")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#303030"), -- tab.border
    Tab = Color3.fromHex("#d8d8d8"), -- tab.inactiveForeground

    Element = Color3.fromHex("#525252"), -- dropdown.background
    ElementBorder = Color3.fromHex("#505050"), -- titleBar.activeBackground
    InElementBorder = Color3.fromHex("#3655b5"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#3655b5"), -- focusBorder
    ToggleToggled = Color3.fromHex("#525252"), -- dropdown.background

    SliderRail = Color3.fromHex("#3655b5"), -- focusBorder

    DropdownFrame = Color3.fromHex("#525252"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#525252"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#505050"), -- titleBar.activeBackground
    DropdownOption = Color3.fromHex("#c5c8c6"), -- editor.foreground

    Keybind = Color3.fromHex("#525252"), -- dropdown.background

    Input = Color3.fromHex("#525252"), -- dropdown.background
    InputFocused = Color3.fromHex("#525252"), -- dropdown.background
    InputIndicator = Color3.fromHex("#949494"), -- editorLineNumber.activeForeground

    Dialog = Color3.fromHex("#272727"), -- menu.background
    DialogHolder = Color3.fromHex("#272727"), -- menu.background
    DialogHolderLine = Color3.fromHex("#505050"), -- titleBar.activeBackground
    DialogButton = Color3.fromHex("#565656"), -- button.background
    DialogButtonBorder = Color3.fromHex("#505050"), -- titleBar.activeBackground
    DialogBorder = Color3.fromHex("#505050"), -- titleBar.activeBackground
    DialogInput = Color3.fromHex("#525252"), -- dropdown.background
    DialogInputLine = Color3.fromHex("#3655b5"), -- focusBorder

    Text = Color3.fromHex("#c5c8c6"), -- editor.foreground
    SubText = Color3.fromHex("#9A9B99"), -- comment color from tokenColors
    Hover = Color3.fromHex("#444444"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["Typewriter"] = {
    Accent = Color3.fromRGB(97, 161, 107),

    AcrylicMain = Color3.fromRGB(252, 245, 228),
    AcrylicBorder = Color3.fromRGB(189, 189, 189),
    AcrylicGradient = ColorSequence.new(Color3.fromRGB(252, 245, 228), Color3.fromRGB(228, 220, 200)),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromRGB(189, 189, 189),
    Tab = Color3.fromRGB(109, 180, 120),

    Element = Color3.fromRGB(255, 255, 255),
    ElementBorder = Color3.fromRGB(200, 200, 200),
    InElementBorder = Color3.fromRGB(191, 191, 193),
    ElementTransparency = 1,

    ToggleSlider = Color3.fromRGB(97, 161, 107),
    ToggleToggled = Color3.fromRGB(255, 255, 255),

    SliderRail = Color3.fromRGB(230, 230, 230),

    DropdownFrame = Color3.fromRGB(217, 218, 220),
    DropdownHolder = Color3.fromRGB(226, 220, 205),
    DropdownBorder = Color3.fromRGB(185, 182, 172),
    DropdownOption = Color3.fromRGB(27, 129, 229),

    Keybind = Color3.fromRGB(233, 227, 211),

    Input = Color3.fromRGB(255, 255, 255),
    InputFocused = Color3.fromRGB(20, 10, 30),
    InputIndicator = Color3.fromRGB(170, 150, 190),

    Dialog = Color3.fromRGB(252, 245, 228),
    DialogHolder = Color3.fromRGB(228, 220, 200),
    DialogHolderLine = Color3.fromRGB(189, 189, 189),
    DialogButton = Color3.fromRGB(242, 243, 245),
    DialogButtonBorder = Color3.fromRGB(213, 213, 215),
    DialogBorder = Color3.fromRGB(189, 189, 189),
    DialogInput = Color3.fromRGB(252, 245, 228),
    DialogInputLine = Color3.fromRGB(190, 160, 180),

    Text = Color3.fromRGB(104, 104, 104),
    SubText = Color3.fromRGB(170, 170, 170),
    Hover = Color3.fromRGB(149, 149, 149),
    HoverChange = 0.04
}
themes["Dark Typewriter"] = {
    Accent = Color3.fromRGB(109, 180, 120),

    AcrylicMain = Color3.fromRGB(38, 38, 38),
    AcrylicBorder = Color3.fromRGB(85, 85, 85),
    AcrylicGradient = ColorSequence.new(Color3.fromRGB(38, 38, 38), Color3.fromRGB(38, 38, 38)),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromRGB(189, 189, 189),
    Tab = Color3.fromRGB(109, 180, 120),

    Element = Color3.fromRGB(42, 42, 42),
    ElementBorder = Color3.fromRGB(51, 51, 51),
    InElementBorder = Color3.fromRGB(51, 51, 51),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromRGB(103, 169, 113),
    ToggleToggled = Color3.fromRGB(255, 255, 255),

    SliderRail = Color3.fromRGB(51, 51, 51),

    DropdownFrame = Color3.fromRGB(68, 68, 68),
    DropdownHolder = Color3.fromRGB(68, 68, 68),
    DropdownBorder = Color3.fromRGB(38, 38, 38),
    DropdownOption = Color3.fromRGB(153, 200, 255),

    Keybind = Color3.fromRGB(54, 54, 54),

    Input = Color3.fromRGB(27, 27, 27),
    InputFocused = Color3.fromRGB(51, 51, 51),
    InputIndicator = Color3.fromRGB(197, 184, 161),

    Dialog = Color3.fromRGB(38, 38, 38),
    DialogHolder = Color3.fromRGB(58, 52, 46),
    DialogHolderLine = Color3.fromRGB(40, 40, 40),
    DialogButton = Color3.fromRGB(42, 42, 42),
    DialogButtonBorder = Color3.fromRGB(51, 51, 51),
    DialogBorder = Color3.fromRGB(189, 189, 189),
    DialogInput = Color3.fromRGB(27, 27, 27),
    DialogInputLine = Color3.fromRGB(197, 184, 161),

    Text = Color3.fromRGB(197, 184, 161),
    SubText = Color3.fromRGB(158, 158, 158),
    Hover = Color3.fromRGB(149, 149, 149),
    HoverChange = 0.04
}
themes["Kimbie Dark"] = {
    Accent = Color3.fromHex("#a57a4c"), -- focusBorder

    AcrylicMain = Color3.fromHex("#221a0f"), -- editor.background
    AcrylicBorder = Color3.fromHex("#5e452b"), -- editor.lineHighlightBackground
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#221a0f"), Color3.fromHex("#221a0f")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#51412c"), -- input.background
    Tab = Color3.fromHex("#d3af86"), -- editor.foreground

    Element = Color3.fromHex("#51412c"), -- input.background
    ElementBorder = Color3.fromHex("#5e452b"), -- peekView.border
    InElementBorder = Color3.fromHex("#a57a4c"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#a57a4c"), -- focusBorder
    ToggleToggled = Color3.fromHex("#51412c"), -- input.background

    SliderRail = Color3.fromHex("#a57a4c"), -- focusBorder

    DropdownFrame = Color3.fromHex("#51412c"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#51412c"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#5e452b"), -- peekView.border
    DropdownOption = Color3.fromHex("#d3af86"), -- editor.foreground

    Keybind = Color3.fromHex("#51412c"), -- input.background

    Input = Color3.fromHex("#51412c"), -- input.background
    InputFocused = Color3.fromHex("#51412c"), -- input.background
    InputIndicator = Color3.fromHex("#a57a4c"), -- editorWhitespace.foreground

    Dialog = Color3.fromHex("#362712"), -- menu.background
    DialogHolder = Color3.fromHex("#221a14"), -- peekViewEditor.background
    DialogHolderLine = Color3.fromHex("#5e452b"), -- peekView.border
    DialogButton = Color3.fromHex("#6e583b"), -- button.background
    DialogButtonBorder = Color3.fromHex("#5e452b"), -- peekView.border
    DialogBorder = Color3.fromHex("#5e452b"), -- peekView.border
    DialogInput = Color3.fromHex("#51412c"), -- input.background
    DialogInputLine = Color3.fromHex("#a57a4c"), -- focusBorder

    Text = Color3.fromHex("#d3af86"), -- editor.foreground
    SubText = Color3.fromHex("#a57a4c"), -- comments color
    Hover = Color3.fromHex("#7c5021"), -- list.activeSelectionBackground
    HoverChange = 0.1
}
themes["Solarized Dark"] = {
    Accent = Color3.fromHex("#2AA198"), -- String color as accent

    AcrylicMain = Color3.fromHex("#002B36"), -- editor.background
    AcrylicBorder = Color3.fromHex("#073642"), -- editor.lineHighlightBackground
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#002B36"), Color3.fromHex("#002B36")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#2AA198"), -- focusBorder
    Tab = Color3.fromHex("#839496"), -- editor.foreground

    Element = Color3.fromHex("#003847"), -- input.background
    ElementBorder = Color3.fromHex("#2AA198"), -- focusBorder
    InElementBorder = Color3.fromHex("#2AA198"), -- String color
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#2AA198"), -- String color
    ToggleToggled = Color3.fromHex("#002B36"), -- editor.background

    SliderRail = Color3.fromHex("#2AA198"), -- String color

    DropdownFrame = Color3.fromHex("#00212B"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#00212B"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#2AA198"), -- dropdown.border
    DropdownOption = Color3.fromHex("#839496"), -- foreground

    Keybind = Color3.fromHex("#003847"), -- input.background

    Input = Color3.fromHex("#003847"), -- input.background
    InputFocused = Color3.fromHex("#003847"), -- input.background
    InputIndicator = Color3.fromHex("#93A1A1"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#00212B"), -- editorWidget.background
    DialogHolder = Color3.fromHex("#002B36"), -- editor.background
    DialogHolderLine = Color3.fromHex("#073642"), -- editor.lineHighlightBackground
    DialogButton = Color3.fromHex("#003847"), -- input.background
    DialogButtonBorder = Color3.fromHex("#2AA198"), -- focusBorder
    DialogBorder = Color3.fromHex("#2AA198"), -- focusBorder
    DialogInput = Color3.fromHex("#003847"), -- input.background
    DialogInputLine = Color3.fromHex("#2AA198"), -- String color

    Text = Color3.fromHex("#839496"), -- editor.foreground
    SubText = Color3.fromHex("#586E75"), -- Comment color
    Hover = Color3.fromHex("#004454"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["Solarized Light"] = {
    Accent = Color3.fromHex("#b58900"), -- Using the extension button color as accent

    AcrylicMain = Color3.fromHex("#FDF6E3"), -- editor.background
    AcrylicBorder = Color3.fromHex("#DDD6C1"), -- editorGroup.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#FDF6E3"), Color3.fromHex("#FDF6E3")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#DDD6C1"), -- editorGroup.border
    Tab = Color3.fromHex("#657B83"), -- editor.foreground

    Element = Color3.fromHex("#EEE8D5"), -- dropdown.background
    ElementBorder = Color3.fromHex("#D3AF86"), -- dropdown.border
    InElementBorder = Color3.fromHex("#b49471"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#b58900"), -- extensionButton.prominentBackground
    ToggleToggled = Color3.fromHex("#FDF6E3"), -- editor.background

    SliderRail = Color3.fromHex("#b58900"), -- extensionButton.prominentBackground

    DropdownFrame = Color3.fromHex("#EEE8D5"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#EEE8D5"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#D3AF86"), -- dropdown.border
    DropdownOption = Color3.fromHex("#657B83"), -- editor.foreground

    Keybind = Color3.fromHex("#DDD6C1"), -- input.background

    Input = Color3.fromHex("#DDD6C1"), -- input.background
    InputFocused = Color3.fromHex("#DDD6C1"), -- input.background
    InputIndicator = Color3.fromHex("#586E75"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#EEE8D5"), -- dropdown.background
    DialogHolder = Color3.fromHex("#EEE8D5"), -- sideBar.background
    DialogHolderLine = Color3.fromHex("#DDD6C1"), -- editorGroup.border
    DialogButton = Color3.fromHex("#AC9D57"), -- button.background
    DialogButtonBorder = Color3.fromHex("#D3AF86"), -- dropdown.border
    DialogBorder = Color3.fromHex("#DDD6C1"), -- editorGroup.border
    DialogInput = Color3.fromHex("#DDD6C1"), -- input.background
    DialogInputLine = Color3.fromHex("#b58900"), -- extensionButton.prominentBackground

    Text = Color3.fromHex("#657B83"), -- editor.foreground
    SubText = Color3.fromHex("#93A1A1"), -- Comment color from tokenColors
    Hover = Color3.fromHex("#DFCA88"), -- list.activeSelectionBackground
    HoverChange = 0.1
}
themes["DuoTone Dark Sea"] = {
    Accent = Color3.fromHex("#34FEBB"),

    AcrylicMain = Color3.fromHex("#1D262F"),
    AcrylicBorder = Color3.fromHex("#303F4F"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#1D262F"), Color3.fromHex("#1D262F")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#303F4F"),
    Tab = Color3.fromHex("#88b4e7"),

    Element = Color3.fromHex("#232D38"),
    ElementBorder = Color3.fromHex("#303F4F"),
    InElementBorder = Color3.fromHex("#34FEBB"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#34FEBB"),
    ToggleToggled = Color3.fromHex("#1D262F"),

    SliderRail = Color3.fromHex("#34FEBB"),

    DropdownFrame = Color3.fromHex("#232D38"),
    DropdownHolder = Color3.fromHex("#232D38"),
    DropdownBorder = Color3.fromHex("#303F4F"),
    DropdownOption = Color3.fromHex("#88b4e7"),

    Keybind = Color3.fromHex("#232D38"),

    Input = Color3.fromHex("#232D38"),
    InputFocused = Color3.fromHex("#232D38"),
    InputIndicator = Color3.fromHex("#444c55"),

    Dialog = Color3.fromHex("#232D38"),
    DialogHolder = Color3.fromHex("#1D262F"),
    DialogHolderLine = Color3.fromHex("#303F4F"),
    DialogButton = Color3.fromHex("#232D38"),
    DialogButtonBorder = Color3.fromHex("#303F4F"),
    DialogBorder = Color3.fromHex("#303F4F"),
    DialogInput = Color3.fromHex("#232D38"),
    DialogInputLine = Color3.fromHex("#34FEBB"),

    Text = Color3.fromHex("#88b4e7"),
    SubText = Color3.fromHex("#444c55"),
    Hover = Color3.fromHex("#354454"),
    HoverChange = 0.1
}
themes["DuoTone Dark Sky"] = {
    Accent = Color3.fromHex("#fec38f"),

    AcrylicMain = Color3.fromHex("#2c2734"),
    AcrylicBorder = Color3.fromHex("#443d51"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#2c2734"), Color3.fromHex("#2c2734")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#443d51"),
    Tab = Color3.fromHex("#cab2fa"),

    Element = Color3.fromHex("#342E3D"),
    ElementBorder = Color3.fromHex("#443d51"),
    InElementBorder = Color3.fromHex("#fec38f"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#fec38f"),
    ToggleToggled = Color3.fromHex("#2c2734"),

    SliderRail = Color3.fromHex("#fec38f"),

    DropdownFrame = Color3.fromHex("#342E3D"),
    DropdownHolder = Color3.fromHex("#342E3D"),
    DropdownBorder = Color3.fromHex("#443d51"),
    DropdownOption = Color3.fromHex("#cab2fa"),

    Keybind = Color3.fromHex("#342E3D"),

    Input = Color3.fromHex("#342E3D"),
    InputFocused = Color3.fromHex("#342E3D"),
    InputIndicator = Color3.fromHex("#544d60"),

    Dialog = Color3.fromHex("#342E3D"),
    DialogHolder = Color3.fromHex("#2c2734"),
    DialogHolderLine = Color3.fromHex("#443d51"),
    DialogButton = Color3.fromHex("#342E3D"),
    DialogButtonBorder = Color3.fromHex("#443d51"),
    DialogBorder = Color3.fromHex("#443d51"),
    DialogInput = Color3.fromHex("#342E3D"),
    DialogInputLine = Color3.fromHex("#fec38f"),

    Text = Color3.fromHex("#cab2fa"),
    SubText = Color3.fromHex("#544d60"),
    Hover = Color3.fromHex("#494256"),
    HoverChange = 0.1
}
themes["DuoTone Dark Space"] = {
    Accent = Color3.fromHex("#fe7734"),

    AcrylicMain = Color3.fromHex("#24242e"),
    AcrylicBorder = Color3.fromHex("#3a3a4a"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#24242e"), Color3.fromHex("#24242e")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#3a3a4a"),
    Tab = Color3.fromHex("#8686cb"),

    Element = Color3.fromHex("#2B2B36"),
    ElementBorder = Color3.fromHex("#3a3a4a"),
    InElementBorder = Color3.fromHex("#fe7734"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#fe7734"),
    ToggleToggled = Color3.fromHex("#24242e"),

    SliderRail = Color3.fromHex("#fe7734"),

    DropdownFrame = Color3.fromHex("#2B2B36"),
    DropdownHolder = Color3.fromHex("#2B2B36"),
    DropdownBorder = Color3.fromHex("#3a3a4a"),
    DropdownOption = Color3.fromHex("#8686cb"),

    Keybind = Color3.fromHex("#2B2B36"),

    Input = Color3.fromHex("#2B2B36"),
    InputFocused = Color3.fromHex("#2B2B36"),
    InputIndicator = Color3.fromHex("#49495a"),

    Dialog = Color3.fromHex("#2B2B36"),
    DialogHolder = Color3.fromHex("#24242e"),
    DialogHolderLine = Color3.fromHex("#3a3a4a"),
    DialogButton = Color3.fromHex("#2B2B36"),
    DialogButtonBorder = Color3.fromHex("#3a3a4a"),
    DialogBorder = Color3.fromHex("#3a3a4a"),
    DialogInput = Color3.fromHex("#2B2B36"),
    DialogInputLine = Color3.fromHex("#fe7734"),

    Text = Color3.fromHex("#8686cb"),
    SubText = Color3.fromHex("#49495a"),
    Hover = Color3.fromHex("#3F3F4F"),
    HoverChange = 0.1
}
themes["DuoTone Dark Forest"] = {
    Accent = Color3.fromHex("#e7f98b"),

    AcrylicMain = Color3.fromHex("#2a2d2a"),
    AcrylicBorder = Color3.fromHex("#424842"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#2a2d2a"), Color3.fromHex("#2a2d2a")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#424842"),
    Tab = Color3.fromHex("#a9bca9"),

    Element = Color3.fromHex("#313531"),
    ElementBorder = Color3.fromHex("#424842"),
    InElementBorder = Color3.fromHex("#e7f98b"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#e7f98b"),
    ToggleToggled = Color3.fromHex("#2a2d2a"),

    SliderRail = Color3.fromHex("#e7f98b"),

    DropdownFrame = Color3.fromHex("#313531"),
    DropdownHolder = Color3.fromHex("#313531"),
    DropdownBorder = Color3.fromHex("#424842"),
    DropdownOption = Color3.fromHex("#a9bca9"),

    Keybind = Color3.fromHex("#313531"),

    Input = Color3.fromHex("#313531"),
    InputFocused = Color3.fromHex("#313531"),
    InputIndicator = Color3.fromHex("#585f58"),

    Dialog = Color3.fromHex("#313531"),
    DialogHolder = Color3.fromHex("#2a2d2a"),
    DialogHolderLine = Color3.fromHex("#424842"),
    DialogButton = Color3.fromHex("#313531"),
    DialogButtonBorder = Color3.fromHex("#424842"),
    DialogBorder = Color3.fromHex("#424842"),
    DialogInput = Color3.fromHex("#313531"),
    DialogInputLine = Color3.fromHex("#e7f98b"),

    Text = Color3.fromHex("#a9bca9"),
    SubText = Color3.fromHex("#585f58"),
    Hover = Color3.fromHex("#474D47"),
    HoverChange = 0.1
}
themes["DuoTone Dark Earth"] = {
    Accent = Color3.fromHex("#fecb52"),

    AcrylicMain = Color3.fromHex("#2c2826"),
    AcrylicBorder = Color3.fromHex("#48413d"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#2c2826"), Color3.fromHex("#2c2826")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#48413d"),
    Tab = Color3.fromHex("#bd987f"),

    Element = Color3.fromHex("#35302D"),
    ElementBorder = Color3.fromHex("#48413d"),
    InElementBorder = Color3.fromHex("#fecb52"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#fecb52"),
    ToggleToggled = Color3.fromHex("#2c2826"),

    SliderRail = Color3.fromHex("#fecb52"),

    DropdownFrame = Color3.fromHex("#35302D"),
    DropdownHolder = Color3.fromHex("#35302D"),
    DropdownBorder = Color3.fromHex("#48413d"),
    DropdownOption = Color3.fromHex("#bd987f"),

    Keybind = Color3.fromHex("#35302D"),

    Input = Color3.fromHex("#35302D"),
    InputFocused = Color3.fromHex("#35302D"),
    InputIndicator = Color3.fromHex("#564b43"),

    Dialog = Color3.fromHex("#35302D"),
    DialogHolder = Color3.fromHex("#2c2826"),
    DialogHolderLine = Color3.fromHex("#48413d"),
    DialogButton = Color3.fromHex("#35302D"),
    DialogButtonBorder = Color3.fromHex("#48413d"),
    DialogBorder = Color3.fromHex("#48413d"),
    DialogInput = Color3.fromHex("#35302D"),
    DialogInputLine = Color3.fromHex("#fecb52"),

    Text = Color3.fromHex("#bd987f"),
    SubText = Color3.fromHex("#564b43"),
    Hover = Color3.fromHex("#4D4642"),
    HoverChange = 0.1
}
themes["VSC Dark+"] = {
    Accent = Color3.fromHex("#DCDCAA"), -- Based on function declarations color

    AcrylicMain = Color3.fromHex("#1E1E1E"), -- VS Code's default dark background
    AcrylicBorder = Color3.fromHex("#444444"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#1E1E1E"), Color3.fromHex("#1E1E1E")),
    AcrylicNoise = 0.92,

    TitleBarLine = Color3.fromHex("#444444"),
    Tab = Color3.fromHex("#CCCCCC"),

    Element = Color3.fromHex("#2D2D2D"),
    ElementBorder = Color3.fromHex("#404040"),
    InElementBorder = Color3.fromHex("#DCDCAA"),
    ElementTransparency = 0.85,

    ToggleSlider = Color3.fromHex("#4EC9B0"), -- Using type declaration color
    ToggleToggled = Color3.fromHex("#1E1E1E"),

    SliderRail = Color3.fromHex("#4EC9B0"),

    DropdownFrame = Color3.fromHex("#2D2D2D"),
    DropdownHolder = Color3.fromHex("#252526"),
    DropdownBorder = Color3.fromHex("#404040"),
    DropdownOption = Color3.fromHex("#9CDCFE"), -- Variable color

    Keybind = Color3.fromHex("#2D2D2D"),

    Input = Color3.fromHex("#3C3C3C"),
    InputFocused = Color3.fromHex("#3C3C3C"),
    InputIndicator = Color3.fromHex("#808080"),

    Dialog = Color3.fromHex("#252526"),
    DialogHolder = Color3.fromHex("#1E1E1E"),
    DialogHolderLine = Color3.fromHex("#404040"),
    DialogButton = Color3.fromHex("#2D2D2D"),
    DialogButtonBorder = Color3.fromHex("#404040"),
    DialogBorder = Color3.fromHex("#444444"),
    DialogInput = Color3.fromHex("#3C3C3C"),
    DialogInputLine = Color3.fromHex("#DCDCAA"),

    Text = Color3.fromHex("#D4D4D4"), -- Default text color
    SubText = Color3.fromHex("#808080"),
    Hover = Color3.fromHex("#2A2D2E"),
    HoverChange = 0.05
}
themes["VSC Dark Modern"] = {
    Accent = Color3.fromHex("#0078D4"), -- focusBorder

    AcrylicMain = Color3.fromHex("#181818"), -- activityBar.background
    AcrylicBorder = Color3.fromHex("#2B2B2B"), -- activityBar.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#181818"), Color3.fromHex("#181818")), -- activityBar.background
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#2B2B2B"), -- titleBar.border
    Tab = Color3.fromHex("#FFFFFF"), -- tab.activeForeground

    Element = Color3.fromHex("#313131"), -- button.secondaryBackground
    ElementBorder = Color3.fromHex("#3C3C3C"), -- button.secondaryHoverBackground
    InElementBorder = Color3.fromHex("#0078D4"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#0078D4"), -- focusBorder
    ToggleToggled = Color3.fromHex("#313131"), -- checkbox.background

    SliderRail = Color3.fromHex("#0078D4"), -- focusBorder

    DropdownFrame = Color3.fromHex("#313131"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#313131"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#3C3C3C"), -- dropdown.border
    DropdownOption = Color3.fromHex("#CCCCCC"), -- dropdown.foreground

    Keybind = Color3.fromHex("#313131"), -- input.background

    Input = Color3.fromHex("#313131"), -- input.background
    InputFocused = Color3.fromHex("#313131"), -- input.background
    InputIndicator = Color3.fromHex("#989898"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#202020"), -- editorWidget.background
    DialogHolder = Color3.fromHex("#1F1F1F"), -- editor.background
    DialogHolderLine = Color3.fromHex("#2B2B2B"), -- panel.border
    DialogButton = Color3.fromHex("#313131"), -- button.secondaryBackground
    DialogButtonBorder = Color3.fromHex("#3C3C3C"), -- button.secondaryHoverBackground
    DialogBorder = Color3.fromHex("#2B2B2B"), -- notifications.border
    DialogInput = Color3.fromHex("#313131"), -- input.background
    DialogInputLine = Color3.fromHex("#0078D4"), -- focusBorder

    Text = Color3.fromHex("#CCCCCC"), -- foreground
    SubText = Color3.fromHex("#9D9D9D"), -- descriptionForeground
    Hover = Color3.fromHex("#3C3C3C"), -- button.secondaryHoverBackground
    HoverChange = 0.1
}
themes["VSC Dark High Contrast"] = {
    Accent = Color3.fromHex("#569cd6"), -- Based on keyword color

    AcrylicMain = Color3.fromHex("#000000"), -- editor.background
    AcrylicBorder = Color3.fromHex("#FFFFFF"), -- Based on editor.foreground
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#000000"), Color3.fromHex("#000000")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#FFFFFF"),
    Tab = Color3.fromHex("#FFFFFF"),

    Element = Color3.fromHex("#000000"),
    ElementBorder = Color3.fromHex("#FFFFFF"),
    InElementBorder = Color3.fromHex("#569cd6"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#569cd6"),
    ToggleToggled = Color3.fromHex("#000000"),

    SliderRail = Color3.fromHex("#569cd6"),

    DropdownFrame = Color3.fromHex("#000000"),
    DropdownHolder = Color3.fromHex("#000000"),
    DropdownBorder = Color3.fromHex("#FFFFFF"),
    DropdownOption = Color3.fromHex("#FFFFFF"),

    Keybind = Color3.fromHex("#000000"),

    Input = Color3.fromHex("#000000"),
    InputFocused = Color3.fromHex("#000000"),
    InputIndicator = Color3.fromHex("#7c7c7c"), -- Based on editorWhitespace.foreground

    Dialog = Color3.fromHex("#000000"),
    DialogHolder = Color3.fromHex("#000000"),
    DialogHolderLine = Color3.fromHex("#FFFFFF"),
    DialogButton = Color3.fromHex("#000000"),
    DialogButtonBorder = Color3.fromHex("#FFFFFF"),
    DialogBorder = Color3.fromHex("#FFFFFF"),
    DialogInput = Color3.fromHex("#000000"),
    DialogInputLine = Color3.fromHex("#569cd6"),

    Text = Color3.fromHex("#FFFFFF"), -- editor.foreground
    SubText = Color3.fromHex("#9D9D9D"), -- descriptionForeground
    Hover = Color3.fromHex("#383a49"), -- Based on actionBar.toggledBackground
    HoverChange = 0.1
}
themes["VSC Light+"] = {
    Accent = Color3.fromHex("#795E26"), -- Function declarations color

    AcrylicMain = Color3.fromHex("#FFFFFF"), -- editor.background
    AcrylicBorder = Color3.fromHex("#D4D4D4"), -- menu.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#FFFFFF"), Color3.fromHex("#FFFFFF")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#D4D4D4"), -- menu.border
    Tab = Color3.fromHex("#000000"), -- editor.foreground

    Element = Color3.fromHex("#F3F3F3"), -- editorSuggestWidget.background
    ElementBorder = Color3.fromHex("#CECECE"), -- searchEditor.textInputBorder
    InElementBorder = Color3.fromHex("#795E26"), -- Function color as accent
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#795E26"), -- Function color as accent
    ToggleToggled = Color3.fromHex("#FFFFFF"), -- editor.background

    SliderRail = Color3.fromHex("#795E26"), -- Function color as accent

    DropdownFrame = Color3.fromHex("#FFFFFF"), -- editor.background
    DropdownHolder = Color3.fromHex("#FFFFFF"), -- editor.background
    DropdownBorder = Color3.fromHex("#CECECE"), -- searchEditor.textInputBorder
    DropdownOption = Color3.fromHex("#001080"), -- Variable color

    Keybind = Color3.fromHex("#FFFFFF"), -- editor.background

    Input = Color3.fromHex("#FFFFFF"), -- editor.background
    InputFocused = Color3.fromHex("#FFFFFF"), -- editor.background
    InputIndicator = Color3.fromHex("#767676"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#F3F3F3"), -- editorSuggestWidget.background
    DialogHolder = Color3.fromHex("#FFFFFF"), -- editor.background
    DialogHolderLine = Color3.fromHex("#D4D4D4"), -- menu.border
    DialogButton = Color3.fromHex("#F3F3F3"), -- editorSuggestWidget.background
    DialogButtonBorder = Color3.fromHex("#CECECE"), -- searchEditor.textInputBorder
    DialogBorder = Color3.fromHex("#D4D4D4"), -- menu.border
    DialogInput = Color3.fromHex("#FFFFFF"), -- editor.background
    DialogInputLine = Color3.fromHex("#795E26"), -- Function color as accent

    Text = Color3.fromHex("#000000"), -- editor.foreground
    SubText = Color3.fromHex("#6F6F6F"), -- sideBarTitle.foreground
    Hover = Color3.fromHex("#E8E8E8"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["VSC Light Modern"] = {
    Accent = Color3.fromHex("#005FB8"), -- focusBorder

    AcrylicMain = Color3.fromHex("#F8F8F8"), -- activityBar.background
    AcrylicBorder = Color3.fromHex("#E5E5E5"), -- activityBar.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#F8F8F8"), Color3.fromHex("#F8F8F8")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#E5E5E5"), -- titleBar.border
    Tab = Color3.fromHex("#1F1F1F"), -- activityBar.foreground

    Element = Color3.fromHex("#E5E5E5"), -- button.secondaryBackground
    ElementBorder = Color3.fromHex("#CECECE"), -- button.border
    InElementBorder = Color3.fromHex("#005FB8"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#005FB8"), -- focusBorder
    ToggleToggled = Color3.fromHex("#FFFFFF"), -- editor.background

    SliderRail = Color3.fromHex("#005FB8"), -- focusBorder

    DropdownFrame = Color3.fromHex("#FFFFFF"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#FFFFFF"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#CECECE"), -- dropdown.border
    DropdownOption = Color3.fromHex("#3B3B3B"), -- dropdown.foreground

    Keybind = Color3.fromHex("#FFFFFF"), -- input.background

    Input = Color3.fromHex("#FFFFFF"), -- input.background
    InputFocused = Color3.fromHex("#FFFFFF"), -- input.background
    InputIndicator = Color3.fromHex("#767676"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#F8F8F8"), -- editorWidget.background
    DialogHolder = Color3.fromHex("#FFFFFF"), -- editor.background
    DialogHolderLine = Color3.fromHex("#E5E5E5"), -- panel.border
    DialogButton = Color3.fromHex("#E5E5E5"), -- button.secondaryBackground
    DialogButtonBorder = Color3.fromHex("#CECECE"), -- button.border
    DialogBorder = Color3.fromHex("#E5E5E5"), -- notifications.border
    DialogInput = Color3.fromHex("#FFFFFF"), -- input.background
    DialogInputLine = Color3.fromHex("#005FB8"), -- focusBorder

    Text = Color3.fromHex("#3B3B3B"), -- foreground
    SubText = Color3.fromHex("#616161"), -- activityBar.inactiveForeground
    Hover = Color3.fromHex("#F2F2F2"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["VSC Light High Contrast"] = {
    Accent = Color3.fromHex("#5e2cbc"), -- Based on function color

    AcrylicMain = Color3.fromHex("#ffffff"), -- Light background
    AcrylicBorder = Color3.fromHex("#292929"), -- Based on embedded foreground
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#ffffff"), Color3.fromHex("#ffffff")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#292929"),
    Tab = Color3.fromHex("#000000"), -- Pure black for high contrast

    Element = Color3.fromHex("#ffffff"),
    ElementBorder = Color3.fromHex("#515151"), -- Comment color
    InElementBorder = Color3.fromHex("#5e2cbc"), -- Function color
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#0F4A85"), -- Storage/keyword color
    ToggleToggled = Color3.fromHex("#ffffff"),

    SliderRail = Color3.fromHex("#0F4A85"),

    DropdownFrame = Color3.fromHex("#ffffff"),
    DropdownHolder = Color3.fromHex("#ffffff"),
    DropdownBorder = Color3.fromHex("#515151"),
    DropdownOption = Color3.fromHex("#001080"), -- Variable color

    Keybind = Color3.fromHex("#ffffff"),

    Input = Color3.fromHex("#ffffff"),
    InputFocused = Color3.fromHex("#ffffff"),
    InputIndicator = Color3.fromHex("#515151"), -- Comment color

    Dialog = Color3.fromHex("#ffffff"),
    DialogHolder = Color3.fromHex("#ffffff"),
    DialogHolderLine = Color3.fromHex("#515151"),
    DialogButton = Color3.fromHex("#ffffff"),
    DialogButtonBorder = Color3.fromHex("#515151"),
    DialogBorder = Color3.fromHex("#292929"),
    DialogInput = Color3.fromHex("#ffffff"),
    DialogInputLine = Color3.fromHex("#5e2cbc"),

    Text = Color3.fromHex("#292929"), -- Based on embedded foreground
    SubText = Color3.fromHex("#515151"), -- Comment color
    Hover = Color3.fromHex("#dddddd"), -- Based on actionBar.toggledBackground
    HoverChange = 0.1
}
themes["VSC Red"] = {
    Accent = Color3.fromHex("#cc3333"), -- badge.background

    AcrylicMain = Color3.fromHex("#580000"), -- activityBar.background
    AcrylicBorder = Color3.fromHex("#ff6666"), -- focusBorder
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#580000"), Color3.fromHex("#580000")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#772222"), -- titleBar.inactiveBackground
    Tab = Color3.fromHex("#F8F8F8"), -- editor.foreground

    Element = Color3.fromHex("#580000"), -- dropdown.background
    ElementBorder = Color3.fromHex("#ff6666"), -- editorGroup.border
    InElementBorder = Color3.fromHex("#cc0000"), -- inputOption.activeBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#cc3333"), -- badge.background
    ToggleToggled = Color3.fromHex("#300000"), -- editorWidget.background

    SliderRail = Color3.fromHex("#cc3333"), -- badge.background

    DropdownFrame = Color3.fromHex("#580000"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#580000"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#220000"), -- editorSuggestWidget.border
    DropdownOption = Color3.fromHex("#F8F8F8"), -- editor.foreground

    Keybind = Color3.fromHex("#580000"), -- dropdown.background

    Input = Color3.fromHex("#580000"), -- input.background
    InputFocused = Color3.fromHex("#580000"), -- input.background
    InputIndicator = Color3.fromHex("#c10000"), -- editorWhitespace.foreground

    Dialog = Color3.fromHex("#300000"), -- editorWidget.background
    DialogHolder = Color3.fromHex("#300000"), -- editorWidget.background
    DialogHolderLine = Color3.fromHex("#ff0000"), -- peekView.border
    DialogButton = Color3.fromHex("#833333"), -- button.background
    DialogButtonBorder = Color3.fromHex("#662222"), -- list.dropBackground
    DialogBorder = Color3.fromHex("#220000"), -- editorSuggestWidget.border
    DialogInput = Color3.fromHex("#580000"), -- input.background
    DialogInputLine = Color3.fromHex("#cc3333"), -- badge.background

    Text = Color3.fromHex("#F8F8F8"), -- editor.foreground
    SubText = Color3.fromHex("#e7c0c0"), -- comment color from tokenColors
    Hover = Color3.fromHex("#800000"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["VS Dark"] = {
    Accent = Color3.fromHex("#007ACC"), -- activityBarBadge.background

    AcrylicMain = Color3.fromHex("#1E1E1E"), -- editor.background
    AcrylicBorder = Color3.fromHex("#303031"), -- widget.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#1E1E1E"), Color3.fromHex("#1E1E1E")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#303031"), -- widget.border
    Tab = Color3.fromHex("#ffffff"), -- tab.selectedForeground

    Element = Color3.fromHex("#222222"), -- tab.selectedBackground
    ElementBorder = Color3.fromHex("#6B6B6B"), -- checkbox.border
    InElementBorder = Color3.fromHex("#007ACC"), -- activityBarBadge.background
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#007ACC"), -- activityBarBadge.background
    ToggleToggled = Color3.fromHex("#222222"), -- tab.selectedBackground

    SliderRail = Color3.fromHex("#404040"), -- editorIndentGuide.background1

    DropdownFrame = Color3.fromHex("#252526"), -- menu.background
    DropdownHolder = Color3.fromHex("#252526"), -- menu.background
    DropdownBorder = Color3.fromHex("#454545"), -- menu.border
    DropdownOption = Color3.fromHex("#CCCCCC"), -- menu.foreground

    Keybind = Color3.fromHex("#222222"), -- tab.selectedBackground

    Input = Color3.fromHex("#222222"), -- tab.selectedBackground
    InputFocused = Color3.fromHex("#222222"), -- tab.selectedBackground
    InputIndicator = Color3.fromHex("#A6A6A6"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#252526"), -- menu.background
    DialogHolder = Color3.fromHex("#252526"), -- menu.background
    DialogHolderLine = Color3.fromHex("#454545"), -- menu.separatorBackground
    DialogButton = Color3.fromHex("#222222"), -- tab.selectedBackground
    DialogButtonBorder = Color3.fromHex("#454545"), -- menu.border
    DialogBorder = Color3.fromHex("#454545"), -- menu.border
    DialogInput = Color3.fromHex("#222222"), -- tab.selectedBackground
    DialogInputLine = Color3.fromHex("#007ACC"), -- activityBarBadge.background

    Text = Color3.fromHex("#D4D4D4"), -- editor.foreground
    SubText = Color3.fromHex("#BBBBBB"), -- sideBarTitle.foreground
    Hover = Color3.fromHex("#383B3D"), -- list.dropBackground
    HoverChange = 0.1
}
themes["VS Light"] = {
    Accent = Color3.fromHex("#007ACC"), -- activityBarBadge.background

    AcrylicMain = Color3.fromHex("#FFFFFF"), -- editor.background
    AcrylicBorder = Color3.fromHex("#919191"), -- checkbox.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#FFFFFF"), Color3.fromHex("#FFFFFF")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#D4D4D4"), -- menu.border
    Tab = Color3.fromHex("#333333"), -- tab.selectedForeground

    Element = Color3.fromHex("#F3F3F3"), -- editorSuggestWidget.background
    ElementBorder = Color3.fromHex("#CECECE"), -- searchEditor.textInputBorder
    InElementBorder = Color3.fromHex("#007ACC"), -- activityBarBadge.background
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#007ACC"), -- activityBarBadge.background
    ToggleToggled = Color3.fromHex("#FFFFFF"), -- editor.background

    SliderRail = Color3.fromHex("#007ACC"), -- activityBarBadge.background

    DropdownFrame = Color3.fromHex("#FFFFFF"), -- editor.background
    DropdownHolder = Color3.fromHex("#FFFFFF"), -- editor.background
    DropdownBorder = Color3.fromHex("#CECECE"), -- searchEditor.textInputBorder
    DropdownOption = Color3.fromHex("#000000"), -- editor.foreground

    Keybind = Color3.fromHex("#FFFFFF"), -- editor.background

    Input = Color3.fromHex("#FFFFFF"), -- editor.background
    InputFocused = Color3.fromHex("#FFFFFF"), -- editor.background
    InputIndicator = Color3.fromHex("#767676"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#F3F3F3"), -- editorSuggestWidget.background
    DialogHolder = Color3.fromHex("#FFFFFF"), -- editor.background
    DialogHolderLine = Color3.fromHex("#D4D4D4"), -- menu.border
    DialogButton = Color3.fromHex("#F3F3F3"), -- editorSuggestWidget.background
    DialogButtonBorder = Color3.fromHex("#CECECE"), -- searchEditor.textInputBorder
    DialogBorder = Color3.fromHex("#D4D4D4"), -- menu.border
    DialogInput = Color3.fromHex("#FFFFFF"), -- editor.background
    DialogInputLine = Color3.fromHex("#007ACC"), -- activityBarBadge.background

    Text = Color3.fromHex("#000000"), -- editor.foreground
    SubText = Color3.fromHex("#6F6F6F"), -- sideBarTitle.foreground
    Hover = Color3.fromHex("#E8E8E8"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["GitHub Dark"] = {
    Accent = Color3.fromHex("#005cc5"), -- focusBorder

    AcrylicMain = Color3.fromHex("#1f2428"), -- sideBar.background
    AcrylicBorder = Color3.fromHex("#1b1f23"),  -- titleBar.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#1f2428"), Color3.fromHex("#1f2428")),-- sideBar.background
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#1b1f23"), -- titleBar.border
    Tab = Color3.fromHex("#e1e4e8"), -- titleBar.activeForeground

    Element = Color3.fromHex("#2f363d"),  -- input.background
    ElementBorder = Color3.fromHex("#1b1f23"), -- input.border
    InElementBorder = Color3.fromHex("#005cc5"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#005cc5"), -- focusBorder
    ToggleToggled = Color3.fromHex("#2f363d"), -- input.background

    SliderRail = Color3.fromHex("#005cc5"),  -- focusBorder

    DropdownFrame = Color3.fromHex("#2f363d"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#2f363d"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#1b1f23"),  -- dropdown.border
    DropdownOption = Color3.fromHex("#e1e4e8"),  -- dropdown.foreground

    Keybind = Color3.fromHex("#2f363d"),  -- input.background

    Input = Color3.fromHex("#2f363d"),  -- input.background
    InputFocused = Color3.fromHex("#2f363d"),  -- input.background
    InputIndicator = Color3.fromHex("#959da5"),-- input.placeholderForeground

    Dialog = Color3.fromHex("#2f363d"),  -- notifications.background
    DialogHolder = Color3.fromHex("#2f363d"), -- notifications.background
    DialogHolderLine = Color3.fromHex("#444d56"), --  textBlockQuote.border
    DialogButton = Color3.fromHex("#2f363d"), --  Your preferred button background
    DialogButtonBorder = Color3.fromHex("#1b1f23"),-- Your preferred button border
    DialogBorder = Color3.fromHex("#1b1f23"), -- notifications.border
    DialogInput = Color3.fromHex("#2f363d"), -- notifications.background
    DialogInputLine = Color3.fromHex("#005cc5"), -- focusBorder

    Text = Color3.fromHex("#d1d5da"), -- foreground
    SubText = Color3.fromHex("#959da5"), -- descriptionForeground
    Hover = Color3.fromHex("#282e34"), -- list.hoverBackground
    HoverChange = 0.1
}
themes["GitHub Dark Dimmed"] = {
    Accent = Color3.fromHex("#316dca"), -- focusBorder

    AcrylicMain = Color3.fromHex("#1c2128"), -- sideBar.background
    AcrylicBorder = Color3.fromHex("#444c56"), -- titleBar.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#1c2128"), Color3.fromHex("#1c2128")), -- sideBar.background
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#444c56"), -- titleBar.border
    Tab = Color3.fromHex("#adbac7"),  -- tab.activeForeground

    Element = Color3.fromHex("#2d333b"), -- dropdown.background
    ElementBorder = Color3.fromHex("#444c56"),  -- dropdown.border
    InElementBorder = Color3.fromHex("#316dca"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#316dca"),  -- focusBorder
    ToggleToggled = Color3.fromHex("#22272e"), -- input.background

    SliderRail = Color3.fromHex("#316dca"),  -- focusBorder

    DropdownFrame = Color3.fromHex("#2d333b"),  -- dropdown.background
    DropdownHolder = Color3.fromHex("#2d333b"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#444c56"),  -- dropdown.border
    DropdownOption = Color3.fromHex("#adbac7"),  -- dropdown.foreground

    Keybind = Color3.fromHex("#22272e"), -- input.background

    Input = Color3.fromHex("#22272e"),  -- input.background
    InputFocused = Color3.fromHex("#22272e"),  -- input.background
    InputIndicator = Color3.fromHex("#636e7b"),  -- input.placeholderForeground

    Dialog = Color3.fromHex("#2d333b"), -- notifications.background
    DialogHolder = Color3.fromHex("#2d333b"), -- notifications.background
    DialogHolderLine = Color3.fromHex("#444c56"), -- notifications.border
    DialogButton = Color3.fromHex("#22272e"),  -- input.background (following your previous instruction)
    DialogButtonBorder = Color3.fromHex("#444c56"), -- dropdown.border (following your previous instruction)
    DialogBorder = Color3.fromHex("#444c56"), -- notifications.border
    DialogInput = Color3.fromHex("#22272e"), -- input.background
    DialogInputLine = Color3.fromHex("#316dca"), -- focusBorder

    Text = Color3.fromHex("#adbac7"),  -- foreground
    SubText = Color3.fromHex("#768390"),  -- descriptionForeground
    Hover = Color3.fromHex("#636e7b"),  -- list.hoverBackground (subtle transparent hover) or #333A42
    HoverChange = 0.1 
}
themes["GitHub Dark Default"] = {
    Accent = Color3.fromHex("#1f6feb"),  -- focusBorder

    AcrylicMain = Color3.fromHex("#010409"), -- sideBar.background
    AcrylicBorder = Color3.fromHex("#30363d"), -- titleBar.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#010409"), Color3.fromHex("#010409")), -- sideBar.background
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#30363d"), -- titleBar.border
    Tab = Color3.fromHex("#e6edf3"), -- tab.activeForeground

    Element = Color3.fromHex("#161b22"), -- dropdown.background  (using a darker shade for more contrast)
    ElementBorder = Color3.fromHex("#30363d"), -- dropdown.border
    InElementBorder = Color3.fromHex("#1f6feb"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#1f6feb"), -- focusBorder
    ToggleToggled = Color3.fromHex("#0d1117"), -- input.background

    SliderRail = Color3.fromHex("#1f6feb"), -- focusBorder

    DropdownFrame = Color3.fromHex("#161b22"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#161b22"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#30363d"), -- dropdown.border
    DropdownOption = Color3.fromHex("#e6edf3"),  -- dropdown.foreground

    Keybind = Color3.fromHex("#0d1117"), -- input.background

    Input = Color3.fromHex("#0d1117"),  -- input.background
    InputFocused = Color3.fromHex("#0d1117"),  -- input.background
    InputIndicator = Color3.fromHex("#6e7681"),-- input.placeholderForeground

    Dialog = Color3.fromHex("#161b22"), -- notifications.background
    DialogHolder = Color3.fromHex("#161b22"), -- notifications.background
    DialogHolderLine = Color3.fromHex("#30363d"), -- notifications.border
    DialogButton = Color3.fromHex("#0d1117"), -- input.background (as requested)
    DialogButtonBorder = Color3.fromHex("#30363d"),  -- dropdown.border (as requested)
    DialogBorder = Color3.fromHex("#30363d"),  -- notifications.border
    DialogInput = Color3.fromHex("#0d1117"), -- input.background
    DialogInputLine = Color3.fromHex("#1f6feb"), -- focusBorder

    Text = Color3.fromHex("#e6edf3"), -- foreground
    SubText = Color3.fromHex("#7d8590"),-- descriptionForeground
    Hover = Color3.fromHex("#6e7681"),  -- list.hoverBackground (keeping alpha for subtle hover effect) or #22272D
    HoverChange = 0.1 
}
themes["GitHub Dark High Contrast"] = {
    Accent = Color3.fromHex("#409eff"), -- focusBorder

    AcrylicMain = Color3.fromHex("#010409"), -- sideBar.background
    AcrylicBorder = Color3.fromHex("#7a828e"),  -- titleBar.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#010409"), Color3.fromHex("#010409")), -- sideBar.background
    AcrylicNoise = 1,


    TitleBarLine = Color3.fromHex("#7a828e"),  -- titleBar.border
    Tab = Color3.fromHex("#f0f3f6"), -- tab.activeForeground

    Element = Color3.fromHex("#272b33"), -- dropdown.background
    ElementBorder = Color3.fromHex("#7a828e"), -- dropdown.border
    InElementBorder = Color3.fromHex("#409eff"), -- focusBorder
    ElementTransparency = 0,


    ToggleSlider = Color3.fromHex("#409eff"),  -- focusBorder
    ToggleToggled = Color3.fromHex("#0a0c10"),  -- input.background

    SliderRail = Color3.fromHex("#409eff"), -- focusBorder

    DropdownFrame = Color3.fromHex("#272b33"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#272b33"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#7a828e"),  -- dropdown.border
    DropdownOption = Color3.fromHex("#f0f3f6"),  -- dropdown.foreground

    Keybind = Color3.fromHex("#0a0c10"), -- input.background

    Input = Color3.fromHex("#0a0c10"), -- input.background
    InputFocused = Color3.fromHex("#0a0c10"), -- input.background
    InputIndicator = Color3.fromHex("#9ea7b3"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#272b33"),  -- notifications.background
    DialogHolder = Color3.fromHex("#272b33"),  -- notifications.background
    DialogHolderLine = Color3.fromHex("#7a828e"), -- notifications.border
    DialogButton = Color3.fromHex("#0a0c10"), -- input.background (as previously requested)
    DialogButtonBorder = Color3.fromHex("#7a828e"), -- dropdown.border (as previously requested)
    DialogBorder = Color3.fromHex("#7a828e"), -- notifications.border
    DialogInput = Color3.fromHex("#0a0c10"), -- input.background
    DialogInputLine = Color3.fromHex("#409eff"), -- focusBorder

    Text = Color3.fromHex("#f0f3f6"),  -- foreground
    SubText = Color3.fromHex("#f0f3f6"), -- descriptionForeground (same as main text for high contrast)
    Hover = Color3.fromHex("#9ea7b3"), -- list.hoverBackground (subtle transparent hover) or #333A42 for solid
    HoverChange = 0.1
}
themes["GitHub Dark Colorblind"] = {
    Accent = Color3.fromHex("#1f6feb"), -- focusBorder

    AcrylicMain = Color3.fromHex("#010409"), -- sideBar.background
    AcrylicBorder = Color3.fromHex("#30363d"), -- titleBar.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#010409"), Color3.fromHex("#010409")), -- sideBar.background
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#30363d"), -- titleBar.border
    Tab = Color3.fromHex("#c9d1d9"), -- tab.activeForeground

    Element = Color3.fromHex("#161b22"), -- dropdown.background
    ElementBorder = Color3.fromHex("#30363d"), -- dropdown.border
    InElementBorder = Color3.fromHex("#1f6feb"),  -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#1f6feb"),  -- focusBorder
    ToggleToggled = Color3.fromHex("#0d1117"), -- input.background

    SliderRail = Color3.fromHex("#1f6feb"),  -- focusBorder

    DropdownFrame = Color3.fromHex("#161b22"),  -- dropdown.background
    DropdownHolder = Color3.fromHex("#161b22"),  -- dropdown.background
    DropdownBorder = Color3.fromHex("#30363d"),  -- dropdown.border
    DropdownOption = Color3.fromHex("#c9d1d9"), -- dropdown.foreground

    Keybind = Color3.fromHex("#0d1117"),  -- input.background

    Input = Color3.fromHex("#0d1117"),  -- input.background
    InputFocused = Color3.fromHex("#0d1117"),  -- input.background
    InputIndicator = Color3.fromHex("#6e7681"),  -- input.placeholderForeground

    Dialog = Color3.fromHex("#161b22"), -- notifications.background
    DialogHolder = Color3.fromHex("#161b22"), -- notifications.background
    DialogHolderLine = Color3.fromHex("#30363d"), -- notifications.border
    DialogButton = Color3.fromHex("#0d1117"), -- input.background (following your established pattern)
    DialogButtonBorder = Color3.fromHex("#30363d"), -- dropdown.border (following your established pattern)
    DialogBorder = Color3.fromHex("#30363d"), -- notifications.border
    DialogInput = Color3.fromHex("#0d1117"), -- input.background
    DialogInputLine = Color3.fromHex("#1f6feb"),  -- focusBorder

    Text = Color3.fromHex("#c9d1d9"), -- foreground
    SubText = Color3.fromHex("#8b949e"), -- descriptionForeground
    Hover = Color3.fromHex("#6e7681"),  -- list.hoverBackground (subtle transparent hover) or #22272D for solid
    HoverChange = 0.1
}
themes["GitHub Light"] = {
    Accent = Color3.fromHex("2188ff"), -- focusBorder

    AcrylicMain = Color3.fromHex("f6f8fa"), -- sideBar.background
    AcrylicBorder = Color3.fromHex("e1e4e8"), -- titleBar.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("f6f8fa"), Color3.fromHex("f6f8fa")), -- sideBar.background
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("e1e4e8"), -- titleBar.border
    Tab = Color3.fromHex("2f363d"), -- tab.activeForeground

    Element = Color3.fromHex("fafbfc"), -- input.background
    ElementBorder = Color3.fromHex("e1e4e8"), -- input.border
    InElementBorder = Color3.fromHex("2188ff"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("2188ff"), -- focusBorder
    ToggleToggled = Color3.fromHex("fafbfc"), -- input.background

    SliderRail = Color3.fromHex("2188ff"), -- focusBorder

    DropdownFrame = Color3.fromHex("fafbfc"), -- dropdown.background
    DropdownHolder = Color3.fromHex("fafbfc"), -- dropdown.background
    DropdownBorder = Color3.fromHex("e1e4e8"), -- dropdown.border
    DropdownOption = Color3.fromHex("2f363d"), -- dropdown.foreground

    Keybind = Color3.fromHex("fafbfc"), -- input.background

    Input = Color3.fromHex("fafbfc"), -- input.background
    InputFocused = Color3.fromHex("fafbfc"), -- input.background
    InputIndicator = Color3.fromHex("959da5"),  -- input.placeholderForeground

    Dialog = Color3.fromHex("fafbfc"), --  Using a light background for dialog
    DialogHolder = Color3.fromHex("fafbfc"), -- Using a light background for dialog holder
    DialogHolderLine = Color3.fromHex("e1e4e8"), --  Using a subtle line color
    DialogButton = Color3.fromHex("#fafbfc"),  -- Your preferred button background
    DialogButtonBorder = Color3.fromHex("#20252c"),  -- Your preferred button border
    DialogBorder = Color3.fromHex("e1e4e8"), -- dropdown.border
    DialogInput = Color3.fromHex("fafbfc"),  -- input.background
    DialogInputLine = Color3.fromHex("2188ff"), -- focusBorder

    Text = Color3.fromHex("24292e"), -- editor.foreground
    SubText = Color3.fromHex("6a737d"), -- descriptionForeground
    Hover = Color3.fromHex("ebf0f4"), -- list.hoverBackground
    HoverChange = 0.1 -- Slightly more pronounced hover effect
}
themes["GitHub Light Default"] = {
    Accent = Color3.fromHex("#0969da"), -- focusBorder

    AcrylicMain = Color3.fromHex("#f6f8fa"), -- sideBar.background
    AcrylicBorder = Color3.fromHex("#d0d7de"), -- titleBar.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#f6f8fa"), Color3.fromHex("#f6f8fa")), -- sideBar.background
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#d0d7de"), -- titleBar.border
    Tab = Color3.fromHex("#1f2328"), -- tab.activeForeground

    Element = Color3.fromHex("#ffffff"), -- input.background
    ElementBorder = Color3.fromHex("#d0d7de"), -- input.border
    InElementBorder = Color3.fromHex("#0969da"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#0969da"), -- focusBorder
    ToggleToggled = Color3.fromHex("#ffffff"),  -- input.background

    SliderRail = Color3.fromHex("#0969da"),  -- focusBorder

    DropdownFrame = Color3.fromHex("#ffffff"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#ffffff"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#d0d7de"), -- dropdown.border
    DropdownOption = Color3.fromHex("#1f2328"), -- dropdown.foreground

    Keybind = Color3.fromHex("#ffffff"), -- input.background

    Input = Color3.fromHex("#ffffff"), -- input.background
    InputFocused = Color3.fromHex("#ffffff"), -- input.background
    InputIndicator = Color3.fromHex("#6e7781"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#ffffff"),  -- notifications.background
    DialogHolder = Color3.fromHex("#ffffff"), -- notifications.background
    DialogHolderLine = Color3.fromHex("#d0d7de"), -- notifications.border
    DialogButton = Color3.fromHex("#ffffff"),  -- Your preferred button background
    DialogButtonBorder = Color3.fromHex("#20252c"),  -- Your preferred button border
    DialogBorder = Color3.fromHex("#d0d7de"),  -- notifications.border
    DialogInput = Color3.fromHex("#ffffff"), -- notifications.background
    DialogInputLine = Color3.fromHex("#0969da"),-- focusborder


    Text = Color3.fromHex("#1f2328"), -- editor.foreground
    SubText = Color3.fromHex("#656d76"), -- descriptionForeground
    Hover = Color3.fromHex("#eaeef2"), -- list.hoverBackground
    HoverChange = 0.1  -- A subtle hover effect
}
themes["GitHub Light High Contrast"] = {
    Accent = Color3.fromHex("#0349b4"), -- focusBorder

    AcrylicMain = Color3.fromHex("#ffffff"), -- sideBar.background
    AcrylicBorder = Color3.fromHex("#20252c"), -- titleBar.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#ffffff"), Color3.fromHex("#ffffff")), -- sideBar.background
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#20252c"), -- titleBar.border
    Tab = Color3.fromHex("#0e1116"), -- tab.activeForeground

    Element = Color3.fromHex("#ffffff"), -- input.background
    ElementBorder = Color3.fromHex("#20252c"),  -- input.border
    InElementBorder = Color3.fromHex("#0349b4"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#0349b4"), -- focusBorder
    ToggleToggled = Color3.fromHex("#ffffff"), -- input.background

    SliderRail = Color3.fromHex("#0349b4"), -- focusBorder

    DropdownFrame = Color3.fromHex("#ffffff"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#ffffff"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#20252c"), -- dropdown.border
    DropdownOption = Color3.fromHex("#0e1116"),  -- dropdown.foreground

    Keybind = Color3.fromHex("#ffffff"), -- input.background

    Input = Color3.fromHex("#ffffff"), -- input.background
    InputFocused = Color3.fromHex("#ffffff"),  -- input.background
    InputIndicator = Color3.fromHex("#66707b"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#ffffff"), -- Using a light background for dialog
    DialogHolder = Color3.fromHex("#ffffff"), -- Using a light background for dialog holder
    DialogHolderLine = Color3.fromHex("#20252c"), -- Using a subtle line color
    DialogButton = Color3.fromHex("#ffffff"), -- input.background
    DialogButtonBorder = Color3.fromHex("#20252c"), -- dropdown.border
    DialogBorder = Color3.fromHex("#20252c"), -- dropdown.border
    DialogInput = Color3.fromHex("#ffffff"), -- input.background
    DialogInputLine = Color3.fromHex("#0349b4"),-- focusBorder

    Text = Color3.fromHex("#0e1116"), -- editor.foreground
    SubText = Color3.fromHex("#66707b"), -- descriptionForeground (or a slightly lighter shade)
    Hover = Color3.fromHex("#e7ecf0"), -- list.hoverBackground
    HoverChange = 0.1 -- Slightly more pronounced hover effect
}
themes["GitHub Light Colorblind"] = {
    Accent = Color3.fromHex("#0969da"), -- focusBorder

    AcrylicMain = Color3.fromHex("#f6f8fa"), -- textBlockQuote.background
    AcrylicBorder = Color3.fromHex("#d0d7de"), -- textBlockQuote.border
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#f6f8fa"), Color3.fromHex("#f6f8fa")), -- textBlockQuote.background
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#d0d7de"), -- titleBar.border
    Tab = Color3.fromHex("#24292f"), -- foreground

    Element = Color3.fromHex("#ffffff"),  -- input.background
    ElementBorder = Color3.fromHex("#d0d7de"), -- input.border
    InElementBorder = Color3.fromHex("#0969da"), -- focusBorder
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#0969da"), -- focusBorder
    ToggleToggled = Color3.fromHex("#ffffff"), -- input.background

    SliderRail = Color3.fromHex("#0969da"), -- focusBorder

    DropdownFrame = Color3.fromHex("#ffffff"), -- dropdown.background
    DropdownHolder = Color3.fromHex("#ffffff"), -- dropdown.background
    DropdownBorder = Color3.fromHex("#d0d7de"), -- dropdown.border
    DropdownOption = Color3.fromHex("#24292f"), -- foreground

    Keybind = Color3.fromHex("#ffffff"), -- input.background

    Input = Color3.fromHex("#ffffff"), -- input.background
    InputFocused = Color3.fromHex("#ffffff"), -- input.background
    InputIndicator = Color3.fromHex("#6e7781"), -- input.placeholderForeground

    Dialog = Color3.fromHex("#ffffff"), -- notifications.background
    DialogHolder = Color3.fromHex("#ffffff"), -- notifications.background
    DialogHolderLine = Color3.fromHex("#d0d7de"),  -- notifications.border
    DialogButton = Color3.fromHex("#ffffff"), -- Your preferred button background
    DialogButtonBorder = Color3.fromHex("#20252c"), -- Your preferred button border
    DialogBorder = Color3.fromHex("#d0d7de"), -- notifications.border
    DialogInput = Color3.fromHex("#ffffff"),  -- notifications.background
    DialogInputLine = Color3.fromHex("#0969da"), -- focusBorder

    Text = Color3.fromHex("#24292f"),  -- foreground
    SubText = Color3.fromHex("#57606a"), -- descriptionForeground
    Hover = Color3.fromHex("#eaeef2"),  -- list.hoverBackground (alpha removed)
    HoverChange = 0.1
}
themes["Viow Arabian"] = {
    Accent = Color3.fromHex("#7b36e2"),

    AcrylicMain = Color3.fromHex("#110e1a"),
    AcrylicBorder = Color3.fromHex("#444444"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#110e1a"), Color3.fromHex("#110e1a")),
    AcrylicNoise = 0.92,

    TitleBarLine = Color3.fromHex("#444444"),
    Tab = Color3.fromHex("#CCCCCC"),

    Element = Color3.fromHex("#2D2D2D"),
    ElementBorder = Color3.fromHex("#404040"),
    InElementBorder = Color3.fromHex("#7b36e2"),
    ElementTransparency = 0.85,

    ToggleSlider = Color3.fromHex("#7b36e2"),
    ToggleToggled = Color3.fromHex("#110e1a"),

    SliderRail = Color3.fromHex("#7b36e2"),

    DropdownFrame = Color3.fromHex("#2D2D2D"),
    DropdownHolder = Color3.fromHex("#252526"),
    DropdownBorder = Color3.fromHex("#404040"),
    DropdownOption = Color3.fromHex("#a497b5"),

    Keybind = Color3.fromHex("#2D2D2D"),

    Input = Color3.fromHex("#3C3C3C"),
    InputFocused = Color3.fromHex("#3C3C3C"),
    InputIndicator = Color3.fromHex("#808080"),

    Dialog = Color3.fromHex("#2a1c3e"),
    DialogHolder = Color3.fromHex("#110e1a"),
    DialogHolderLine = Color3.fromHex("#100422"),
    DialogButton = Color3.fromHex("#2D2D2D"),
    DialogButtonBorder = Color3.fromHex("#404040"),
    DialogBorder = Color3.fromHex("#444444"),
    DialogInput = Color3.fromHex("#3C3C3C"),
    DialogInputLine = Color3.fromHex("#7b36e2"),

    Text = Color3.fromHex("#a497b5"),
    SubText = Color3.fromHex("#60576f"),
    Hover = Color3.fromHex("#2A2D2E"),
    HoverChange = 0.05
}
themes["Viow Arabian Mix"] = {
    Accent = Color3.fromHex("#7b36e2"),

    AcrylicMain = Color3.fromHex("#110e1a"),
    AcrylicBorder = Color3.fromHex("#444444"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#110e1a"), Color3.fromHex("#110e1a")),
    AcrylicNoise = 0.92,

    TitleBarLine = Color3.fromHex("#444444"),
    Tab = Color3.fromHex("#CCCCCC"),

    Element = Color3.fromHex("#2D2D2D"),
    ElementBorder = Color3.fromHex("#404040"),
    InElementBorder = Color3.fromHex("#7b36e2"),
    ElementTransparency = 0.85,

    ToggleSlider = Color3.fromHex("#7b36e2"),
    ToggleToggled = Color3.fromHex("#110e1a"),

    SliderRail = Color3.fromHex("#7b36e2"),

    DropdownFrame = Color3.fromHex("#2D2D2D"),
    DropdownHolder = Color3.fromHex("#252526"),
    DropdownBorder = Color3.fromHex("#404040"),
    DropdownOption = Color3.fromHex("#a497b5"),

    Keybind = Color3.fromHex("#2D2D2D"),

    Input = Color3.fromHex("#3C3C3C"),
    InputFocused = Color3.fromHex("#3C3C3C"),
    InputIndicator = Color3.fromHex("#808080"),

    Dialog = Color3.fromHex("#2a1c3e"),
    DialogHolder = Color3.fromHex("#150E33"),
    DialogHolderLine = Color3.fromHex("#100422"),
    DialogButton = Color3.fromHex("#2D2D2D"),
    DialogButtonBorder = Color3.fromHex("#404040"),
    DialogBorder = Color3.fromHex("#444444"),
    DialogInput = Color3.fromHex("#3C3C3C"),
    DialogInputLine = Color3.fromHex("#7b36e2"),

    Text = Color3.fromHex("#a497b5"),
    SubText = Color3.fromHex("#60576f"),
    Hover = Color3.fromHex("#2A2D2E"),
    HoverChange = 0.05
}
themes["Viow Darker"] = {
    Accent = Color3.fromHex("#165fb3"),

    AcrylicMain = Color3.fromHex("#21252b"),
    AcrylicBorder = Color3.fromHex("#383838"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#21252b"), Color3.fromHex("#21252b")),
    AcrylicNoise = 0.92,

    TitleBarLine = Color3.fromHex("#383838"),
    Tab = Color3.fromHex("#d3d0c8"),

    Element = Color3.fromHex("#2d333c"),
    ElementBorder = Color3.fromHex("#383838"),
    InElementBorder = Color3.fromHex("#165fb3"),
    ElementTransparency = 0.85,

    ToggleSlider = Color3.fromHex("#165fb3"),
    ToggleToggled = Color3.fromHex("#21252b"),

    SliderRail = Color3.fromHex("#165fb3"),

    DropdownFrame = Color3.fromHex("#2d333c"),
    DropdownHolder = Color3.fromHex("#1e2228"),
    DropdownBorder = Color3.fromHex("#383838"),
    DropdownOption = Color3.fromHex("#d3d0c8"),

    Keybind = Color3.fromHex("#2d333c"),

    Input = Color3.fromHex("#2d333c"),
    InputFocused = Color3.fromHex("#2d333c"),
    InputIndicator = Color3.fromHex("#747369"),

    Dialog = Color3.fromHex("#21252b"),
    DialogHolder = Color3.fromHex("#1E2228"),
    DialogHolderLine = Color3.fromHex("#383838"),
    DialogButton = Color3.fromHex("#2d333c"),
    DialogButtonBorder = Color3.fromHex("#383838"),
    DialogBorder = Color3.fromHex("#383838"),
    DialogInput = Color3.fromHex("#2d333c"),
    DialogInputLine = Color3.fromHex("#165fb3"),

    Text = Color3.fromHex("#d3d0c8"),
    SubText = Color3.fromHex("#747369"),
    Hover = Color3.fromHex("#383838"),
    HoverChange = 0.05
}
themes["Viow Flat"] = {
    Accent = Color3.fromHex("#165fb3"),

    AcrylicMain = Color3.fromHex("#191c28"),
    AcrylicBorder = Color3.fromHex("#191c28"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#191c28"), Color3.fromHex("#191c28")),
    AcrylicNoise = 0.92,

    TitleBarLine = Color3.fromHex("#191c28"),
    Tab = Color3.fromHex("#d3d0c8"),

    Element = Color3.fromHex("#191c28"),
    ElementBorder = Color3.fromHex("#191c28"),
    InElementBorder = Color3.fromHex("#165fb3"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#165fb3"),
    ToggleToggled = Color3.fromHex("#191c28"),

    SliderRail = Color3.fromHex("#165fb3"),

    DropdownFrame = Color3.fromHex("#191c28"),
    DropdownHolder = Color3.fromHex("#191c28"),
    DropdownBorder = Color3.fromHex("#191c28"),
    DropdownOption = Color3.fromHex("#d3d0c8"),

    Keybind = Color3.fromHex("#191c28"),

    Input = Color3.fromHex("#191c28"),
    InputFocused = Color3.fromHex("#191c28"),
    InputIndicator = Color3.fromHex("#747369"),

    Dialog = Color3.fromHex("#191c28"),
    DialogHolder = Color3.fromHex("#191c28"),
    DialogHolderLine = Color3.fromHex("#191c28"),
    DialogButton = Color3.fromHex("#191c28"),
    DialogButtonBorder = Color3.fromHex("#191c28"),
    DialogBorder = Color3.fromHex("#191c28"),
    DialogInput = Color3.fromHex("#191c28"),
    DialogInputLine = Color3.fromHex("#165fb3"),

    Text = Color3.fromHex("#d3d0c8"),
    SubText = Color3.fromHex("#747369"),
    Hover = Color3.fromHex("#464870"),
    HoverChange = 0.05
}
themes["Viow Light"] = {
    Accent = Color3.fromHex("#0f96ff"),

    AcrylicMain = Color3.fromHex("#ffffff"),
    AcrylicBorder = Color3.fromHex("#d4d4d4"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#ffffff"), Color3.fromHex("#ffffff")),
    AcrylicNoise = 1,

    TitleBarLine = Color3.fromHex("#d4d4d4"),
    Tab = Color3.fromHex("#8e8e8e"),

    Element = Color3.fromHex("#f3f3f3"),
    ElementBorder = Color3.fromHex("#cecece"),
    InElementBorder = Color3.fromHex("#0f96ff"),
    ElementTransparency = 0,

    ToggleSlider = Color3.fromHex("#0f96ff"),
    ToggleToggled = Color3.fromHex("#ffffff"),

    SliderRail = Color3.fromHex("#0f96ff"),

    DropdownFrame = Color3.fromHex("#ffffff"),
    DropdownHolder = Color3.fromHex("#ffffff"),
    DropdownBorder = Color3.fromHex("#cecece"),
    DropdownOption = Color3.fromHex("#57606c"),

    Keybind = Color3.fromHex("#ffffff"),

    Input = Color3.fromHex("#ffffff"),
    InputFocused = Color3.fromHex("#ffffff"),
    InputIndicator = Color3.fromHex("#767676"),

    Dialog = Color3.fromHex("#f3f3f3"),
    DialogHolder = Color3.fromHex("#ffffff"),
    DialogHolderLine = Color3.fromHex("#d4d4d4"),
    DialogButton = Color3.fromHex("#f3f3f3"),
    DialogButtonBorder = Color3.fromHex("#cecece"),
    DialogBorder = Color3.fromHex("#d4d4d4"),
    DialogInput = Color3.fromHex("#ffffff"),
    DialogInputLine = Color3.fromHex("#0f96ff"),

    Text = Color3.fromHex("#57606c"),
    SubText = Color3.fromHex("#6f6f6f"),
    Hover = Color3.fromHex("#e8e8e8"),
    HoverChange = 0.1
}
themes["Viow Mars"] = {
    Accent = Color3.fromHex("#e32b00"),

    AcrylicMain = Color3.fromHex("#130c0f"),
    AcrylicBorder = Color3.fromHex("#28191d"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#130c0f"), Color3.fromHex("#130c0f")),
    AcrylicNoise = 0.92,

    TitleBarLine = Color3.fromHex("#28191d"),
    Tab = Color3.fromHex("#d3d0c8"),

    Element = Color3.fromHex("#321f27"),
    ElementBorder = Color3.fromHex("#5a0d29"),
    InElementBorder = Color3.fromHex("#e32b00"),
    ElementTransparency = 0.85,

    ToggleSlider = Color3.fromHex("#e32b00"),
    ToggleToggled = Color3.fromHex("#130c0f"),

    SliderRail = Color3.fromHex("#e32b00"),

    DropdownFrame = Color3.fromHex("#321f27"),
    DropdownHolder = Color3.fromHex("#271e22"),
    DropdownBorder = Color3.fromHex("#5a0d29"),
    DropdownOption = Color3.fromHex("#d3d0c8"),

    Keybind = Color3.fromHex("#321f27"),

    Input = Color3.fromHex("#321f27"),
    InputFocused = Color3.fromHex("#321f27"),
    InputIndicator = Color3.fromHex("#747369"),

    Dialog = Color3.fromHex("#462531"),
    DialogHolder = Color3.fromHex("#3a1223"),
    DialogHolderLine = Color3.fromHex("#5c1b33"),
    DialogButton = Color3.fromHex("#321f27"),
    DialogButtonBorder = Color3.fromHex("#5a0d29"),
    DialogBorder = Color3.fromHex("#ff4f15"),
    DialogInput = Color3.fromHex("#321f27"),
    DialogInputLine = Color3.fromHex("#e32b00"),

    Text = Color3.fromHex("#d3d0c8"),
    SubText = Color3.fromHex("#747369"),
    Hover = Color3.fromHex("#5c1b33"),
    HoverChange = 0.05
}
themes["Viow Neon"] = {
    Accent = Color3.fromHex("#1591ff"),

    AcrylicMain = Color3.fromHex("#202432"),
    AcrylicBorder = Color3.fromHex("#191c28"),
    AcrylicGradient = ColorSequence.new(Color3.fromHex("#202432"), Color3.fromHex("#202432")),
    AcrylicNoise = 0.92,

    TitleBarLine = Color3.fromHex("#191c28"),
    Tab = Color3.fromHex("#d3d0c8"),

    Element = Color3.fromHex("#202432"),
    ElementBorder = Color3.fromHex("#0d2c5a"),
    InElementBorder = Color3.fromHex("#1591ff"),
    ElementTransparency = 0.85,

    ToggleSlider = Color3.fromHex("#1591ff"),
    ToggleToggled = Color3.fromHex("#202432"),

    SliderRail = Color3.fromHex("#1591ff"),

    DropdownFrame = Color3.fromHex("#202432"),
    DropdownHolder = Color3.fromHex("#1e2228"),
    DropdownBorder = Color3.fromHex("#0d2c5a"),
    DropdownOption = Color3.fromHex("#d3d0c8"),

    Keybind = Color3.fromHex("#202432"),

    Input = Color3.fromHex("#202432"),
    InputFocused = Color3.fromHex("#202432"),
    InputIndicator = Color3.fromHex("#747369"),

    Dialog = Color3.fromHex("#252f46"),
    DialogHolder = Color3.fromHex("#1c1f2b"),
    DialogHolderLine = Color3.fromHex("#1b375c"),
    DialogButton = Color3.fromHex("#202432"),
    DialogButtonBorder = Color3.fromHex("#0d2c5a"),
    DialogBorder = Color3.fromHex("#1591ff"),
    DialogInput = Color3.fromHex("#202432"),
    DialogInputLine = Color3.fromHex("#1591ff"),

    Text = Color3.fromHex("#d3d0c8"),
    SubText = Color3.fromHex("#747369"),
    Hover = Color3.fromHex("#1b375c"),
    HoverChange = 0.05
}
return themes
