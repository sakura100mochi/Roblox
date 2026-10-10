-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement
-- UI --
local resolvedProps = require(script.Parent.Parent.ResolveProps)
local Instances = require(script.Parent.Parent.Instances)

export type MenuProps = {
	
}

local defaultProps = {
	
}

return function(props: MenuProps?)
	local resolved = resolvedProps(props, defaultProps)

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
		}),
		e(Instances.TextLabel, {
			Text = "This is menu.",
			TextColor3 = Color3.fromRGB(255, 255, 255),
			Size = UDim2.fromScale(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
		})
	}, props and props.children)
end
