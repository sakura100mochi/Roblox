-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement
-- UI --
local UI_Utils = require(script.Parent.Parent.UI_Utils)
local Instances = require(script.Parent.Parent.Instances)
local RainbowAnimation = require(script.Parent.RainbowAnimation)

export type MenuProps = {
	Button1_Activated: Function?,
	Button2_Activated: Function?,
}

local defaultProps = {
	Button1_Activated = function()
			print("button1 activated")
		end,
	Button2_Activated = function()
			print("button2 activated")
		end,
}

return function(props: MenuProps?): createElementFn
	local resolved = UI_Utils.ResolveProps(props, defaultProps)
	local shown, setShown = React.useState(true)

	if shown == false then
		return nil
	end

	return e(Instances.Frame, {
		Size = UDim2.fromScale(0.3, 0.4),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
	}, {
		e(Instances.Frame, {
			BackgroundColor3 = Color3.fromRGB(31, 158, 33),
			BackgroundTransparency = 0,
			Size = UDim2.fromScale(0.8, 1),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
		}, {
			e(Instances.UICorner, {
				CornerRadius = UDim.new(0, 10),
			}),
			e(Instances.UIStroke, {
				Color = Color3.new(255, 255, 255),
				Thickness = 3,
			}, {
				e(RainbowAnimation, {
					Speed = 180,
				}),
			}),
			e(Instances.TextLabel, {
				Text = "Hello!",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				FontFace = Font.fromEnum(Enum.Font.SourceSansBold),
				Size = UDim2.fromScale(0.5, 0.75),
				Position = UDim2.fromScale(0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0),
			}),
			CloseButton = e(Instances.TextButton, {
				Size = UDim2.fromScale(0.3, 1),
				Position = UDim2.fromScale(0.9, 0.1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Text = "×",
				TextColor3 = Color3.fromRGB(255, 0, 0),
				FontFace = Font.fromEnum(Enum.Font.SourceSansBold),
				BackgroundTransparency = 1,
				OnActivated = function()
						setShown(false)
					end,
			}, {
				e("UIAspectRatioConstraint"),
				e(Instances.UICorner, {
					CornerRadius = UDim.new(1, 0),
				}),
				e(Instances.UIStroke, {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
					Thickness = 2,
					Color = Color3.fromRGB(160, 2, 2),
				})
			}),
		}),
		Button1 = e(Instances.TextButton, {
			Size = UDim2.fromScale(0.4, 0.2),
			Position = UDim2.fromScale(0.25, 0.85),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "Accept",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			FontFace = Font.fromEnum(Enum.Font.SourceSansBold),
			BackgroundColor3 = Color3.fromRGB(125, 255, 99),
			OnActivated = resolved.Button1_Activated,
		}, {
			e(Instances.UICorner, {
				CornerRadius = UDim.new(1, 0),
			}),
			e(Instances.UIStroke, {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = 2,
				Color = Color3.fromRGB(51, 111, 39),
			}),
			e(Instances.UIStroke, {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
				Thickness = 2,
				Color = Color3.fromRGB(0, 0, 0),
			}),
		}),
		Button2 = e(Instances.TextButton, {
			Size = UDim2.fromScale(0.4, 0.2),
			Position = UDim2.fromScale(0.75, 0.85),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "Decline",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			FontFace = Font.fromEnum(Enum.Font.SourceSansBold),
			BackgroundColor3 = Color3.fromRGB(255, 50, 50),
			OnActivated = resolved.Button2_Activated,
		}, {
			e(Instances.UICorner, {
				CornerRadius = UDim.new(1, 0),
			}),
			e(Instances.UIStroke, {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = 2,
				Color = Color3.fromRGB(162, 25, 25),
			}),
			e(Instances.UIStroke, {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
				Thickness = 2,
				Color = Color3.fromRGB(0, 0, 0),
			}),
		}),
	}, props and props.children)
end
