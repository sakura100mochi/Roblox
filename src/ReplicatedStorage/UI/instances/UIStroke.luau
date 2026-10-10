-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement
-- functions --
local resolvedProps = require(script.Parent.Parent.ResolveProps)

export type UIStrokeProps = {
	-- https://create.roblox.com/docs/ja-jp/reference/engine/enums/ApplyStrokeMode
	-- Contextual: 0
	-- Border : 1
	ApplyStrokeMode: Enum.ApplyStrokeMode?,
	BorderOffset: UDim?,
	BorderStrokePosition: Enum.BorderStrokePosition?,
	Color: Color3?,
	LineJoinMode: Enum.LineJoinMode?,
	StrokeSizingMode: Enum.StrokeSizingMode?,
	Thickness: number?,
	Transparency: number?,
	ZIndex: number?,
	Enabled: boolean?,
	Name: string?,
	children: React.ReactNode?,
}

local defaultProps = {
	ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
	BorderOffset = UDim.new(0, 0),
	BorderStrokePosition = Enum.BorderStrokePosition.Outer,
	Color = Color3.fromRGB(0, 0, 0),
	LineJoinMode = Enum.LineJoinMode.Round,
	StrokeSizingMode = Enum.StrokeSizingMode.FixedSize,
	Thickness = 1,
	Transparency = 0,
	ZIndex = 1,
	Enabled = true,
	Name = "UIStroke",
	children = nil,
}

return function(props: UIStrokeProps?)
	local resolved = resolvedProps(props, defaultProps)

	return e("UIStroke", {
		ApplyStrokeMode = resolved.ApplyStrokeMode,
		BorderOffset = resolved.BorderOffset,
		BorderStrokePosition = resolved.BorderStrokePosition,
		Color = resolved.Color,
		LineJoinMode = resolved.LineJoinMode,
		StrokeSizingMode = resolved.StrokeSizingMode,
		Thickness = resolved.Thickness,
		Transparency = resolved.Transparency,
		ZIndex = resolved.ZIndex,
		Enabled = resolved.Enabled,
		Name = resolved.Name,
	}, props and props.children)
end
