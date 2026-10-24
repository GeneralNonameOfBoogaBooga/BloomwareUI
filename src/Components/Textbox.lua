-- Based on Fluent by dawid (MIT).
local TextService, Root = game:GetService("TextService"), script.Parent.Parent
local Flipper, Creator = require(Root.Packages.Flipper), require(Root.Creator)
local New = Creator.New
return function(parent, embedded)
	embedded = embedded or false
	local textbox = {}
	textbox.Input = New("TextBox", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromOffset(10, 0),
		ThemeTag = {
			TextColor3 = "Text",
			PlaceholderColor3 = "SubText",
		},
	})
	textbox.Container = New("Frame", {
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Position = UDim2.new(0, 6, 0, 0),
		Size = UDim2.new(1, -12, 1, 0),
	}, {
		textbox.Input,
	})
	textbox.Indicator = New("Frame", {
		Size = UDim2.new(1, -4, 0, 1),
		Position = UDim2.new(0, 2, 1, 0),
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = embedded and 0.5 or 0,
		ThemeTag = {
			BackgroundColor3 = embedded and "InputIndicator" or "DialogInputLine",
		},
	})
	textbox.Frame = New("Frame", {
		Size = UDim2.new(0, 0, 0, 30),
		BackgroundTransparency = embedded and 0.9 or 0,
		Parent = parent,
		ThemeTag = {
			BackgroundColor3 = embedded and "Input" or "DialogInput",
		},
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 7),
		}),
		New("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Transparency = embedded and 0.5 or 0.65,
			ThemeTag = {
				Color = embedded and "InElementBorder" or "DialogButtonBorder",
			},
		}),
		textbox.Indicator,
		textbox.Container,
	})
	local updateCursor = function()
		local padding, width = 2, textbox.Container.AbsoluteSize.X
		if not textbox.Input:IsFocused() or textbox.Input.TextBounds.X <= width - 2 * padding then
			textbox.Input.Position = UDim2.new(0, padding, 0, 0)
		else
			local CursorPosition = textbox.Input.CursorPosition
			if CursorPosition ~= -1 then
				local textBeforeCursor = string.sub(textbox.Input.Text, 1, CursorPosition - 1)
				local textWidth = TextService:GetTextSize(
					textBeforeCursor,
					textbox.Input.TextSize,
					textbox.Input.Font,
					Vector2.new(math.huge, math.huge)
				).X
				local cursorX = textbox.Input.Position.X.Offset + textWidth
				if cursorX < padding then
					textbox.Input.Position = UDim2.fromOffset(padding - textWidth, 0)
				elseif cursorX > width - padding - 1 then
					textbox.Input.Position = UDim2.fromOffset(width - textWidth - padding - 1, 0)
				end
			end
		end
	end
	task.spawn(updateCursor)
	Creator.AddSignal(textbox.Input:GetPropertyChangedSignal("Text"), updateCursor)
	Creator.AddSignal(textbox.Input:GetPropertyChangedSignal("CursorPosition"), updateCursor)
	Creator.AddSignal(textbox.Input.Focused, function()
		updateCursor()
		textbox.Indicator.Size = UDim2.new(1, -2, 0, 2)
		textbox.Indicator.Position = UDim2.new(0, 1, 1, 0)
		textbox.Indicator.BackgroundTransparency = 0
		Creator.OverrideTag(textbox.Frame, {
			BackgroundColor3 = embedded and "InputFocused" or "DialogHolder",
		})
		Creator.OverrideTag(textbox.Indicator, {
			BackgroundColor3 = "Accent",
		})
	end)
	Creator.AddSignal(textbox.Input.FocusLost, function()
		updateCursor()
		textbox.Indicator.Size = UDim2.new(1, -4, 0, 1)
		textbox.Indicator.Position = UDim2.new(0, 2, 1, 0)
		textbox.Indicator.BackgroundTransparency = 0.5
		Creator.OverrideTag(textbox.Frame, {
			BackgroundColor3 = embedded and "Input" or "DialogInput",
		})
		Creator.OverrideTag(textbox.Indicator, {
			BackgroundColor3 = embedded and "InputIndicator" or "DialogInputLine",
		})
	end)
	return textbox
end
