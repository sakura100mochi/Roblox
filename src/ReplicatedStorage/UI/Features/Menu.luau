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
		BackgroundColor3 = Color3.fromRGB(221, 93, 208),
		BackgroundTransparency = 0,
		Size = UDim2.fromScale(0.5, 0.5),
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
			Text = "This is menu.",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Size = UDim2.fromScale(0.5, 0.75),
			Position = UDim2.fromScale(0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0),
		}),
		Button1 = e(Instances.TextButton, {
			Size = UDim2.fromScale(0.4, 0.2),
			Position = UDim2.fromScale(0.25, 0.75),
			AnchorPoint = Vector2.new(0.5, 0),
			Text = "Yes",
			BackgroundColor3 = Color3.fromRGB(105, 214, 83),
			OnActivated = resolved.Button1_Activated,
		}, {
			e(Instances.UICorner, {
				CornerRadius = UDim.new(0, 10),
			}),
			e(Instances.UIStroke, {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = 1.5,
				Color = Color3.fromRGB(255, 255, 255),
			})
		}),
		Button2 = e(Instances.TextButton, {
			Size = UDim2.fromScale(0.4, 0.2),
			Position = UDim2.fromScale(0.75, 0.75),
			AnchorPoint = Vector2.new(0.5, 0),
			Text = "No",
			BackgroundColor3 = Color3.fromRGB(245, 107, 107),
			OnActivated = resolved.Button2_Activated,
		}, {
			e(Instances.UICorner, {
				CornerRadius = UDim.new(0, 10),
			}),
			e(Instances.UIStroke, {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = 1.5,
				Color = Color3.fromRGB(255, 255, 255),
			})
		}),
		CloseButton = e(Instances.TextButton, {
			Size = UDim2.fromScale(0.1, 1),
			Position = UDim2.fromScale(1, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Text = "×",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundColor3 = Color3.fromRGB(255, 0, 0),
			OnActivated = function()
					setShown(false)
				end,
		}, {
			e("UIAspectRatioConstraint"),
			e(Instances.UICorner, {
				CornerRadius = UDim.new(1, 0),
			}),
			e(Instances.UIStroke, {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = 2,
				Color = Color3.fromRGB(255, 255, 255),
			})
		})
	}, props and props.children)
end
