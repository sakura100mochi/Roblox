-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement
-- UI --
local UI_Utils = require(script.Parent.Parent.UI_Utils)

export type UIGradientProps = {
	Color: ColorSequence?,
	Enabled: boolean?,
	Offset: Vector2?,
	Rotation: number?,
	Transparency: NumberSequence?,
	Name: string?,
	children: React.ReactNode?,
}

local defaultProps = {
	Color = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
	Enabled = true,
	Offset = Vector2.new(0, 0),
	Rotation = 0,
	Transparency = NumberSequence.new(0),
	Name = "UIGradient",
	children = nil,
}

return function(props: UIGradientProps?): createElementFn
	local resolved = UI_Utils.ResolveProps(props, defaultProps)

	return e("UIGradient", {
		Color = resolved.Color,
		Enabled = resolved.Enabled,
		Offset = resolved.Offset,
		Rotation = resolved.Rotation,
		Transparency = resolved.Transparency,
		Name = resolved.Name,
	}, props and props.children)
end
