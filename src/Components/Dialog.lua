-- Based on Fluent by dawid (MIT).
local UserInputService, Mouse, Camera, Root =
	game:GetService("UserInputService"),
	game:GetService("Players").LocalPlayer:GetMouse(),
	game:GetService("Workspace").CurrentCamera,
	script.Parent.Parent
local Flipper, Creator = require(Root.Packages.Flipper), require(Root.Creator)
local Spring, Instant, New, DialogModule =
	Flipper.Spring.new, Flipper.Instant.new, Creator.New, {
		Window = nil,
	}
local Compatibility = require(Root.Compatibility)
function DialogModule.Init(self, window)
	DialogModule.Window = window
	return DialogModule
end
function DialogModule.Create(self)
	local dialog = {
		Buttons = 0,
        IsClosed = false,
        Closed = Compatibility.Signal(),
	}
	dialog.TintFrame = New("TextButton", {
		Text = "",
        ZIndex = 70,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		Parent = DialogModule.Window.Root,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
	})
	local tintMotor, setTint =
		Creator.SpringMotor(1, dialog.TintFrame, "BackgroundTransparency", true)
	dialog.ButtonHolder = New("Frame", {
		Size = UDim2.new(1, -40, 1, -40),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundTransparency = 1,
	}, {
		New("UIListLayout", {
			Padding = UDim.new(0, 10),
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})
	dialog.ButtonHolderFrame = New("Frame", {
		Size = UDim2.new(1, 0, 0, 70),
		Position = UDim2.new(0, 0, 1, -70),
		ThemeTag = {
			BackgroundColor3 = "DialogHolder",
		},
	}, {
		New("Frame", {
			Size = UDim2.new(1, 0, 0, 1),
			ThemeTag = {
				BackgroundColor3 = "DialogHolderLine",
			},
		}),
		dialog.ButtonHolder,
	})
	dialog.Title = New("TextLabel", {
		FontFace = Font.new(
			"rbxasset://fonts/families/GothamSSm.json",
			Enum.FontWeight.SemiBold,
			Enum.FontStyle.Normal
		),
		Text = "Dialog",
		TextColor3 = Color3.fromRGB(240, 240, 240),
		TextSize = 22,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -40, 0, 22),
        TextTruncate = Enum.TextTruncate.AtEnd,
		Position = UDim2.fromOffset(20, 25),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		ThemeTag = {
			TextColor3 = "Text",
		},
	})
	dialog.Scale = New("UIScale", {
		Scale = 1,
	})
	local scaleMotor, setScale = Creator.SpringMotor(1.1, dialog.Scale, "Scale")
	dialog.Root = New("CanvasGroup", {
		Size = UDim2.fromOffset(300, 165),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		GroupTransparency = 1,
		Parent = dialog.TintFrame,
		ThemeTag = {
			BackgroundColor3 = "Dialog",
		},
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
		New("UIStroke", {
			Transparency = 0.5,
			ThemeTag = {
				Color = "DialogBorder",
			},
		}),
		dialog.Scale,
		dialog.Title,
		dialog.ButtonHolderFrame,
	})
	local contentMotor, setContentTransparency = Creator.SpringMotor(1, dialog.Root, "GroupTransparency")
    local function fitScale()
        local window = DialogModule.Window
        dialog.BaseScale = math.max(0.1, math.min(1,
            (window.Size.X.Offset - 24) / math.max(1, dialog.Root.Size.X.Offset),
            (window.Size.Y.Offset - 24) / math.max(1, dialog.Root.Size.Y.Offset)))
        return dialog.BaseScale
    end
    Creator.AddSignal(DialogModule.Window.Root:GetPropertyChangedSignal("Size"), function()
        if not dialog.IsClosed then setScale(fitScale()) end
    end, dialog.Root)
    Creator.AddSignal(dialog.TintFrame.Destroying, function()
        dialog.IsClosed = true
        if not dialog._ClosedFired then dialog._ClosedFired=true;dialog.Closed:Fire()end
        dialog.Closed:Destroy()
        if DialogModule.Active == dialog then DialogModule.Active = nil; require(Root).DialogOpen = false end
    end)
	function dialog.Open(self)
		DialogModule.Active = dialog
        require(Root).DialogOpen = true
		dialog.Scale.Scale = fitScale() * 1.03
		setTint(0.75)
		setContentTransparency(0)
		setScale(dialog.BaseScale)
	end
	function dialog.Close(self)
        if dialog.IsClosed then return end
        dialog.IsClosed = true
        dialog._ClosedFired=true;dialog.Closed:Fire()
		if DialogModule.Active == dialog then DialogModule.Active = nil; require(Root).DialogOpen = false end
		setTint(1)
		setContentTransparency(1)
		setScale((dialog.BaseScale or 1) * 1.03)
		dialog.Root.UIStroke:Destroy()
		task.wait(0.15)
		dialog.TintFrame:Destroy()
	end
	function dialog.Button(self, title, callback)
		dialog.Buttons = dialog.Buttons + 1
		title = title or "Button"
		callback = callback or function() end
		local button = require(Root.Components.Button)("", dialog.ButtonHolder, true)
		button.Title.Text = title
		for index, child in next, dialog.ButtonHolder:GetChildren() do
			if child:IsA("TextButton") then
				child.Size = UDim2.new(
					1 / dialog.Buttons,
					-(((dialog.Buttons - 1) * 10) / dialog.Buttons),
					0,
					require(Root).Mobile and 44 or 32
				)
			end
		end
		Creator.AddSignal(button.Frame.Activated, function()
			require(Root):SafeCallback(callback)
			pcall(function()
				dialog:Close()
			end)
		end)
		return button
	end
	return dialog
end
return DialogModule
