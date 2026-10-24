-- Based on Fluent by dawid (MIT).
local Root = script.Parent.Parent
local Creator = require(Root.Creator)
local New, Components, Button = Creator.New, Root.Components, {}
Button.__index = Button
Button.__type = "Button"
function Button.New(self, config)
	assert(config.Title, "Button - Missing Title")
	config.Callback = config.Callback or function() end
	local card =
		require(Components.Element)(config.Title, config.Description, self.Container, true)
	local arrow = New("ImageLabel", {
		Image = "rbxassetid://10709791437",
		Size = UDim2.fromOffset(16, 16),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		BackgroundTransparency = 1,
		Parent = card.Frame,
		ThemeTag = {
			ImageColor3 = "Text",
		},
	})
	card:SetControl(arrow, { Width = 18, Height = 18, StackWidth = 220 })
	Creator.AddSignal(card.Frame.Activated, function()
		self.Library:SafeCallback(config.Callback, config.Value)
	end)
	return card
end
return Button
