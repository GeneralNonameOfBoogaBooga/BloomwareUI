-- Based on Fluent by dawid (MIT).
local Root = script.Parent.Parent
local Flipper, Creator = require(Root.Packages.Flipper), require(Root.Creator)
local New, new = Creator.New, Flipper.Spring.new
return function(text, parent, ignoreDialog)
	ignoreDialog = ignoreDialog or false
	local button = {}
	button.Title = New("TextLabel", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 14,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ThemeTag = {
			TextColor3 = "Text",
		},
	})
	button.HoverFrame = New("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ThemeTag = {
			BackgroundColor3 = "Hover",
		},
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
	})
	button.Frame = New("TextButton", {
		Size = UDim2.new(0, 0, 0, require(Root).Mobile and 44 or 32),
		Parent = parent,
		ThemeTag = {
			BackgroundColor3 = "DialogButton",
		},
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
		New("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Transparency = 0.65,
			ThemeTag = {
				Color = "DialogButtonBorder",
			},
		}),
		button.HoverFrame,
		button.Title,
	})
	local hoverMotor, setHoverTransparency =
		Creator.SpringMotor(1, button.HoverFrame, "BackgroundTransparency", ignoreDialog)
	Creator.AddSignal(button.Frame.MouseEnter, function()
		setHoverTransparency(0.97)
	end)
	Creator.AddSignal(button.Frame.MouseLeave, function()
		setHoverTransparency(1)
	end)
	Creator.AddSignal(button.Frame.MouseButton1Down, function()
		setHoverTransparency(1)
	end)
	Creator.AddSignal(button.Frame.MouseButton1Up, function()
		setHoverTransparency(0.97)
	end)
	return button
end
