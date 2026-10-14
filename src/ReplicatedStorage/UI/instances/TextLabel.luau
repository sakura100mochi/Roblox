-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement
-- UI --
local UI_Utils = require(script.Parent.Parent.UI_Utils)

export type TextLabelProps = {
	AnchorPoint: Vector2?,
	BackgroundColor3: Color3?,
	BackgroundTransparency: number?,
	Name: string?,
	Position: UDim2?,
	Rotation: number?,
	Size: UDim2?,
	Visible: boolean?,
	ZIndex: number?,
	AutoLocalize: boolean?,
	FontFace: Font?,
	RichText: boolean?,
	Text: string?,
	TextColor3: Color3?,
	TextScaled: boolean?,
	TextSize: number?,
	TextTransparency: number?,
	TextWrapped: boolean?,
	TextXAlignment: Enum.TextXAlignment?,
	TextYAlignment: Enum.TextYAlignment?,
	children: React.ReactNode?,
}

local defaultProps = {
	AnchorPoint = Vector2.new(0, 0),
	BackgroundColor3 = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1,
	Name = "TextLabel",
	Position = UDim2.new(0, 0, 0, 0),
	Rotation = 0,
	Size = UDim2.fromScale(1, 1),
	Visible = true,
	ZIndex = 1,
	AutoLocalize = true,
	FontFace = Font.fromEnum(Enum.Font.SourceSans),
	RichText = false,
	Text = "TextLabel",
	TextColor3 = Color3.fromRGB(0, 0, 0),
	TextScaled = true,
	TextSize = 14,
	TextTransparency = 0,
	TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Center,
	TextYAlignment = Enum.TextYAlignment.Center,
	children = nil,
}

return function(props: TextLabelProps?): createElementFn
	local resolved = UI_Utils.ResolveProps(props, defaultProps)

	return e("TextLabel", {
		AnchorPoint = resolved.AnchorPoint,
		BackgroundColor3 = resolved.BackgroundColor3,
		BackgroundTransparency = resolved.BackgroundTransparency,
		Name = resolved.Name,
		Position = resolved.Position,
		Rotation = resolved.Rotation,
		Size = resolved.Size,
		Visible = resolved.Visible,
		ZIndex = resolved.ZIndex,
		AutoLocalize = resolved.AutoLocalize,
		FontFace = resolved.FontFace,
		RichText = resolved.RichText,
		Text = resolved.Text,
		TextColor3 = resolved.TextColor3,
		TextScaled = resolved.TextScaled,
		TextSize = resolved.TextSize,
		TextTransparency = resolved.TextTransparency,
		TextWrapped = resolved.TextWrapped,
		TextXAlignment = resolved.TextXAlignment,
		TextYAlignment = resolved.TextYAlignment,
	}, props and props.children)
end
