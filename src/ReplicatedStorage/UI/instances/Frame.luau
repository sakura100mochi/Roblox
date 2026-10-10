-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement
-- functions --
local resolvedProps = require(script.Parent.Parent.ResolveProps)

export type FrameProps = {
	AnchorPoint: Vector2?,
	BackgroundColor3: Color3?,
	BackgroundTransparency: number?,
	Name: string?,
	Position: UDim2?,
	Size: UDim2?,
	Visible: boolean?,
	ZIndex: number?,
	AutoLocalize: boolean?,
	children: React.ReactNode?,
}

local defaultProps = {
	AnchorPoint = Vector2.new(0, 0),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	Name = "Frame",
	Position = UDim2.new(0, 0, 0, 0),
	Size = UDim2.fromScale(1, 1),
	Visible = true,
	ZIndex = 1,
	AutoLocalize = true,
	children = nil,
}

return function(props: FrameProps?)
	local resolved = resolvedProps(props, defaultProps)

	return e("Frame", {
		AnchorPoint = resolved.AnchorPoint,
		BackgroundColor3 = resolved.BackgroundColor3,
		BackgroundTransparency = resolved.BackgroundTransparency,
		Name = resolved.Name,
		Position = resolved.Position,
		Size = resolved.Size,
		Visible = resolved.Visible,
		ZIndex = resolved.ZIndex,
		AutoLocalize = resolved.AutoLocalize,
	}, props and props.children)
end
