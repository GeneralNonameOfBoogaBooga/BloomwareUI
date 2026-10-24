-- Based on Fluent by dawid (MIT).
local Root = script.Parent.Parent
local Flipper, Creator, Acrylic =
	require(Root.Packages.Flipper), require(Root.Creator), require(Root.Acrylic)
local Spring, Instant, New, Notification = Flipper.Spring.new, Flipper.Instant.new, Creator.New, {}
function Notification.Init(self, parent)
	Notification.Holder = New("Frame", {
		Position = UDim2.new(1, -30, 1, -30),
		Size = UDim2.new(0, 310, 1, -30),
		AnchorPoint = Vector2.new(1, 1),
		BackgroundTransparency = 1,
		Parent = parent,
	}, {
		New("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Bottom,
			Padding = UDim.new(0, 20),
		}),
	})
end
function Notification.New(self, config)
	config.Title = config.Title or "Title"
	config.Content = config.Content or "Content"
	config.SubContent = config.SubContent or ""
	config.Duration = config.Duration or nil
	config.Buttons = config.Buttons or {}
	local notification = {
		Closed = false,
	}
	notification.AcrylicPaint = Acrylic.AcrylicPaint()
	notification.Title = New("TextLabel", {
		Position = UDim2.new(0, 14, 0, 17),
		Text = config.Title,
		RichText = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextTransparency = 0,
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		TextSize = 13,
		TextXAlignment = "Left",
		TextYAlignment = "Center",
		Size = UDim2.new(1, -12, 0, 12),
		TextWrapped = true,
		BackgroundTransparency = 1,
		ThemeTag = {
			TextColor3 = "Text",
		},
	})
	notification.ContentLabel = New("TextLabel", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		Text = config.Content,
		TextColor3 = Color3.fromRGB(240, 240, 240),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(1, 0, 0, 14),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		TextWrapped = true,
		ThemeTag = {
			TextColor3 = "Text",
		},
	})
	notification.SubContentLabel = New("TextLabel", {
		FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
		Text = config.SubContent,
		TextColor3 = Color3.fromRGB(240, 240, 240),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(1, 0, 0, 14),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		TextWrapped = true,
		ThemeTag = {
			TextColor3 = "SubText",
		},
	})
	notification.LabelHolder = New("Frame", {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(14, 40),
		Size = UDim2.new(1, -28, 0, 0),
	}, {
		New("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 3),
		}),
		notification.ContentLabel,
		notification.SubContentLabel,
	})
	notification.CloseButton = New("TextButton", {
		Text = "",
		Position = UDim2.new(1, -14, 0, 13),
		Size = UDim2.fromOffset(20, 20),
		AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1,
	}, {
		New("ImageLabel", {
			Image = require(script.Parent.Assets).Close,
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			ThemeTag = {
				ImageColor3 = "Text",
			},
		}),
	})
	notification.Root = New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.fromScale(1, 0),
	}, {
		notification.AcrylicPaint.Frame,
		notification.Title,
		notification.CloseButton,
		notification.LabelHolder,
	})
	if config.Content == "" then
		notification.ContentLabel.Visible = false
	end
	if config.SubContent == "" then
		notification.SubContentLabel.Visible = false
	end
	notification.Holder = New("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 200),
		Parent = Notification.Holder,
	}, {
		notification.Root,
	})
	local positionMotor = Flipper.GroupMotor.new({
		Scale = 1,
		Offset = 60,
	})
	positionMotor:onStep(function(state)
		notification.Root.Position = UDim2.new(state.Scale, state.Offset, 0, 0)
	end)
	Creator.AddSignal(notification.CloseButton.MouseButton1Click, function()
		notification:Close()
	end)
	function notification.Open(self)
		local textHeight = notification.LabelHolder.AbsoluteSize.Y
		notification.Holder.Size = UDim2.new(1, 0, 0, 58 + textHeight)
		positionMotor:setGoal({
			Scale = Spring(0, {
				frequency = 5,
			}),
			Offset = Spring(0, {
				frequency = 5,
			}),
		})
	end
	function notification.Close(self)
		if not notification.Closed then
			notification.Closed = true
			task.spawn(function()
				positionMotor:setGoal({
					Scale = Spring(1, {
						frequency = 5,
					}),
					Offset = Spring(60, {
						frequency = 5,
					}),
				})
				task.wait(0.4)
				if notification.AcrylicPaint.Model then
					notification.AcrylicPaint.Model:Destroy()
				end
				notification.Holder:Destroy()
			end)
		end
	end
	notification:Open()
	if config.Duration then
		task.delay(config.Duration, function()
			notification:Close()
		end)
	end
	return notification
end
return Notification
