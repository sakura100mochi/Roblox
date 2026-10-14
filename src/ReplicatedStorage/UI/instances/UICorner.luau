-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement
-- UI --
local UI_Utils = require(script.Parent.Parent.UI_Utils)

export type UICornerProps = {
	CornerRadius: UDim?,
	Name: string?,
	BottomLeftRadius: UDim?,
	BottomRightRadius: UDim?,
	TopLeftRadius: UDim?,
	TopRightRadius: UDim?,
	children: React.ReactNode?,
}

local defaultProps = {
	CornerRadius = UDim.new(0, 8),
	Name = "UICorner",
	BottomLeftRadius = UDim.new(0, 8),
	BottomRightRadius = UDim.new(0, 8),
	TopLeftRadius = UDim.new(0, 8),
	TopRightRadius = UDim.new(0, 8),
	children = nil,
}

return function(props: UICornerProps?): createElementFn
	local resolved = UI_Utils.ResolveProps(props, defaultProps)

	return e("UICorner", {
		CornerRadius = resolved.CornerRadius,
		Name = resolved.Name,
		BottomLeftRadius = resolved.BottomLeftRadius,
		BottomRightRadius = resolved.BottomRightRadius,
		TopLeftRadius = resolved.TopLeftRadius,
		TopRightRadius = resolved.TopRightRadius,
	}, props and props.children)
end
