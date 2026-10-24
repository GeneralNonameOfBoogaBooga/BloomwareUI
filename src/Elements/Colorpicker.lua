-- Based on Fluent by dawid (MIT).
local UserInputService = game:GetService("UserInputService")
local Root = script.Parent.Parent
local Creator = require(Root.Creator)
local New, Components, Colorpicker = Creator.New, Root.Components, {}
Colorpicker.__index = Colorpicker
Colorpicker.__type = "Colorpicker"
function Colorpicker.New(self, id, config)
	local Library = self.Library
	assert(config.Title, "Colorpicker - Missing Title")
	assert(config.Default, "AddColorPicker: Missing default value.")
	local option = {
		Value = config.Default,
		Transparency = config.Transparency or 0,
		Type = "Colorpicker",
		Title = type(config.Title) == "string" and config.Title or "Colorpicker",
		Callback = config.Callback or function(value) end,
		Changed = config.Changed,
		UpdateOnChange = config.UpdateOnChange == true or config.UpdateWhileSliding == true,
	}
	function option.SetHSVFromRGB(self, color)
		local hue, saturation, brightness = Color3.toHSV(color)
		option.Hue = hue
		option.Sat = saturation
		option.Vib = brightness
	end
	option:SetHSVFromRGB(option.Value)
	local card =
		require(Components.Element)(config.Title, config.Description, self.Container, true)
	option._Element = card
	option.Instance = card
	option.SetTitle = card.SetTitle
	option.SetDesc = card.SetDesc
	local swatch = New("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = option.Value,
		Parent = card.Frame,
	}, {
		New("UICorner", {
			CornerRadius = UDim.new(0, 4),
		}),
	})
	local swatchButton, openDialog =
		New("ImageLabel", {
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Parent = card.Frame,
			Image = "http://www.roblox.com/asset/?id=14204231522",
			ImageTransparency = 0.45,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.fromOffset(40, 40),
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			swatch,
		}), function()
			if Library.DialogOpen then return end
			Library:ClosePopups()
			local dialog = require(Components.Dialog):Create()
			dialog.Title.Text = option.Title
			dialog.Root.Size = UDim2.fromOffset(430, 330)
			local Hue, Sat, Vib, Transparency, createInput, createInputLabel = option.Hue, option.Sat, option.Vib, option.Transparency, function()
				local textbox = require(Components.Textbox)()
				textbox.Frame.Parent = dialog.Root
				textbox.Frame.Size = UDim2.new(0, 90, 0, 32)
				return textbox
			end, function(text, position)
				return New("TextLabel", {
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
					Text = text,
					TextColor3 = Color3.fromRGB(240, 240, 240),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					Size = UDim2.new(1, 0, 0, 32),
					Position = position,
					BackgroundTransparency = 1,
					Parent = dialog.Root,
					ThemeTag = {
						TextColor3 = "Text",
					},
				})
			end
			local getRGB, colorCursor = function()
				local color = Color3.fromHSV(Hue, Sat, Vib)
				return {
					R = math.floor(color.r * 255),
					G = math.floor(color.g * 255),
					B = math.floor(color.b * 255),
				}
			end, New("ImageLabel", {
				Size = UDim2.new(0, 18, 0, 18),
				ScaleType = Enum.ScaleType.Fit,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "http://www.roblox.com/asset/?id=4805639000",
			})
			local colorMap, alphaPreviewColor = New("ImageLabel", {
				Size = UDim2.fromOffset(180, 160),
				Position = UDim2.fromOffset(20, 55),
				Image = "rbxassetid://4155801252",
				BackgroundColor3 = option.Value,
				BackgroundTransparency = 0,
				Parent = dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				colorCursor,
			}), New("Frame", {
				BackgroundColor3 = option.Value,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = option.Transparency,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			})
			local alphaPreview, colorPreview = New("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(112, 220),
				Size = UDim2.fromOffset(88, 24),
				Parent = dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 2,
					Transparency = 0.75,
				}),
				alphaPreviewColor,
			}), New("Frame", {
				BackgroundColor3 = option.Value,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 0,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			})
			local colorPreviewHolder, hueStops = New("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(20, 220),
				Size = UDim2.fromOffset(88, 24),
				Parent = dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 2,
					Transparency = 0.75,
				}),
				colorPreview,
			}), {}
			for step = 0, 1, 0.1 do
				table.insert(hueStops, ColorSequenceKeypoint.new(step, Color3.fromHSV(step, 1, 1)))
			end
			local hueGradient, hueDragArea = New("UIGradient", {
				Color = ColorSequence.new(hueStops),
				Rotation = 90,
			}), New("Frame", {
				Size = UDim2.new(1, 0, 1, -10),
				Position = UDim2.fromOffset(0, 5),
				BackgroundTransparency = 1,
			})
			local hueCursor, hueBar, hexInput = New("ImageLabel", {
				Size = UDim2.fromOffset(14, 14),
				Image = "http://www.roblox.com/asset/?id=12266946128",
				Parent = hueDragArea,
				ThemeTag = {
					ImageColor3 = "DialogInput",
				},
			}), New("Frame", {
				Size = UDim2.fromOffset(12, 190),
				Position = UDim2.fromOffset(210, 55),
				Parent = dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
				hueGradient,
				hueDragArea,
			}), createInput()
			hexInput.Frame.Position = UDim2.fromOffset(config.Transparency and 260 or 240, 55)
			createInputLabel("Hex", UDim2.fromOffset(config.Transparency and 360 or 340, 55))
			local redInput = createInput()
			redInput.Frame.Position = UDim2.fromOffset(config.Transparency and 260 or 240, 95)
			createInputLabel("Red", UDim2.fromOffset(config.Transparency and 360 or 340, 95))
			local greenInput = createInput()
			greenInput.Frame.Position = UDim2.fromOffset(config.Transparency and 260 or 240, 135)
			createInputLabel("Green", UDim2.fromOffset(config.Transparency and 360 or 340, 135))
			local blueInput = createInput()
			blueInput.Frame.Position = UDim2.fromOffset(config.Transparency and 260 or 240, 175)
			createInputLabel("Blue", UDim2.fromOffset(config.Transparency and 360 or 340, 175))
			local alphaInput
			if config.Transparency then
				alphaInput = createInput()
				alphaInput.Frame.Position = UDim2.fromOffset(260, 215)
				createInputLabel("Alpha", UDim2.fromOffset(360, 215))
			end
			local alphaBar, alphaCursor, alphaFill
			if config.Transparency then
				local alphaDragArea = New("Frame", {
					Size = UDim2.new(1, 0, 1, -10),
					Position = UDim2.fromOffset(0, 5),
					BackgroundTransparency = 1,
				})
				alphaCursor = New("ImageLabel", {
					Size = UDim2.fromOffset(14, 14),
					Image = "http://www.roblox.com/asset/?id=12266946128",
					Parent = alphaDragArea,
					ThemeTag = {
						ImageColor3 = "DialogInput",
					},
				})
				alphaFill = New("Frame", {
					Size = UDim2.fromScale(1, 1),
				}, {
					New("UIGradient", {
						Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1),
						}),
						Rotation = 270,
					}),
					New("UICorner", {
						CornerRadius = UDim.new(1, 0),
					}),
				})
				alphaBar = New("Frame", {
					Size = UDim2.fromOffset(12, 190),
					Position = UDim2.fromOffset(230, 55),
					Parent = dialog.Root,
					BackgroundTransparency = 1,
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(1, 0),
					}),
					New("ImageLabel", {
						Image = "http://www.roblox.com/asset/?id=14204231522",
						ImageTransparency = 0.45,
						ScaleType = Enum.ScaleType.Tile,
						TileSize = UDim2.fromOffset(40, 40),
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Parent = dialog.Root,
					}, {
						New("UICorner", {
							CornerRadius = UDim.new(1, 0),
						}),
					}),
					alphaFill,
					alphaDragArea,
				})
			end
			local updatePreview = function()
				colorMap.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
				hueCursor.Position = UDim2.new(0, -1, Hue, -6)
				colorCursor.Position = UDim2.new(Sat, 0, 1 - Vib, 0)
				colorPreview.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
				hexInput.Input.Text = "#" .. Color3.fromHSV(Hue, Sat, Vib):ToHex()
				redInput.Input.Text = tostring(getRGB().R)
				greenInput.Input.Text = tostring(getRGB().G)
				blueInput.Input.Text = tostring(getRGB().B)
				if config.Transparency then
					alphaFill.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
					colorPreview.BackgroundTransparency = Transparency
					alphaCursor.Position = UDim2.new(0, -1, 1 - Transparency, -6)
					alphaInput.Input.Text = require(Root):Round((1 - Transparency) * 100, 0) .. "%"
				end
				if option.UpdateOnChange then option:SetValue({Hue,Sat,Vib},Transparency) end
			end
			Creator.AddSignal(hexInput.Input.FocusLost, function(enterPressed)
				if enterPressed then
					local success, color = pcall(Color3.fromHex, hexInput.Input.Text)
					if success and typeof(color) == "Color3" then
						Hue, Sat, Vib = Color3.toHSV(color)
					end
				end
				updatePreview()
			end)
			Creator.AddSignal(redInput.Input.FocusLost, function(enterPressed)
				if enterPressed then
					local rgb = getRGB()
					local success, color = pcall(Color3.fromRGB, redInput.Input.Text, rgb.G, rgb.B)
					if success and typeof(color) == "Color3" then
						if tonumber(redInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(color)
						end
					end
				end
				updatePreview()
			end)
			Creator.AddSignal(greenInput.Input.FocusLost, function(enterPressed)
				if enterPressed then
					local rgb = getRGB()
					local success, color = pcall(Color3.fromRGB, rgb.R, greenInput.Input.Text, rgb.B)
					if success and typeof(color) == "Color3" then
						if tonumber(greenInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(color)
						end
					end
				end
				updatePreview()
			end)
			Creator.AddSignal(blueInput.Input.FocusLost, function(enterPressed)
				if enterPressed then
					local rgb = getRGB()
					local success, color = pcall(Color3.fromRGB, rgb.R, rgb.G, blueInput.Input.Text)
					if success and typeof(color) == "Color3" then
						if tonumber(blueInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(color)
						end
					end
				end
				updatePreview()
			end)
			if config.Transparency then
				Creator.AddSignal(alphaInput.Input.FocusLost, function(enterPressed)
					if enterPressed then
						pcall(function()
							local percent = tonumber(alphaInput.Input.Text)
							if percent >= 0 and percent <= 100 then
								Transparency = 1 - percent * 0.01
							end
						end)
					end
					updatePreview()
				end)
			end
            local dragKind, dragInput
            local function applyPointer(input)
                if dragKind == "sv" then
                    local p, size = colorMap.AbsolutePosition, colorMap.AbsoluteSize
                    if size.X > 0 and size.Y > 0 then
                        Sat = math.clamp((input.Position.X - p.X) / size.X, 0, 1)
                        Vib = 1 - math.clamp((input.Position.Y - p.Y) / size.Y, 0, 1)
                    end
                elseif dragKind == "hue" then
                    local p, size = hueBar.AbsolutePosition, hueBar.AbsoluteSize
                    if size.Y > 0 then Hue = math.clamp((input.Position.Y - p.Y) / size.Y, 0, 1) end
                elseif dragKind == "alpha" then
                    local p, size = alphaBar.AbsolutePosition, alphaBar.AbsoluteSize
                    if size.Y > 0 then Transparency = 1 - math.clamp((input.Position.Y - p.Y) / size.Y, 0, 1) end
                end
                updatePreview()
            end
            local function bindDrag(target, kind)
                Creator.AddSignal(target.InputBegan, function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragKind, dragInput = kind, input
                        applyPointer(input)
                    end
                end, dialog.Root)
            end
            bindDrag(colorMap, "sv")
            bindDrag(hueBar, "hue")
            if config.Transparency then bindDrag(alphaBar, "alpha") end
            Creator.AddSignal(UserInputService.InputChanged, function(input)
                if dragInput and (input == dragInput or dragInput.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement) then applyPointer(input) end
            end, dialog.Root)
            Creator.AddSignal(UserInputService.InputEnded, function(input)
                if input == dragInput or input.UserInputType == Enum.UserInputType.MouseButton1 then dragInput, dragKind = nil, nil end
            end, dialog.Root)
			updatePreview()
			dialog:Button("Done", function()
				option:SetValue({
					Hue,
					Sat,
					Vib,
				}, Transparency)
			end)
			dialog:Button("Cancel")
			dialog:Open()
		end
	function option.Display(self)
		option.Value = Color3.fromHSV(option.Hue, option.Sat, option.Vib)
		swatch.BackgroundColor3 = option.Value
		swatch.BackgroundTransparency = option.Transparency
		Library:SafeCallback(option.Callback, option.Value)
		Library:SafeCallback(option.Changed, option.Value)
	end
	function option.SetValue(self, hsv, transparency)
		local color = Color3.fromHSV(hsv[1], hsv[2], hsv[3])
		option.Transparency = transparency or 0
		option:SetHSVFromRGB(color)
		option:Display()
	end
	function option.SetValueRGB(self, color, transparency)
		option.Transparency = transparency or 0
		option:SetHSVFromRGB(color)
		option:Display()
	end
	function option.OnChanged(self, callback)
		option.Changed = callback
		Library:SafeCallback(callback,option.Value)
	end
	function option.Destroy(self)
		card:Destroy()
		if Library.Options[id] == option then Library.Options[id] = nil end
	end
	Creator.AddSignal(card.Frame.Activated, function()
		openDialog()
	end)
	card:SetControl(swatch.Parent, { Width = 44, Height = 28, StackWidth = 260 })
	option:Display()
	Library.Options[id] = option
	return option
end
return Colorpicker
