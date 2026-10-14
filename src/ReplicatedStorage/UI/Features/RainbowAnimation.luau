-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement
-- UI --
local UI_Utils = require(script.Parent.Parent.UI_Utils)
local Instances = require(script.Parent.Parent.Instances)
local UIGradient = Instances.UIGradient

export type RainbowAnimationProps = UIGradient.UIGradientProps & {
	-- Speed: number? = rotation speed in degrees per second
	Speed: number?,
}

local defaultProps = {
	Speed = 360,
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 32, 244)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 218, 255)),
	}),
}

return function(props: RainbowAnimationProps): createElementFn
	local resolved = UI_Utils.ResolveProps(props, defaultProps)

	local rot, setRot = React.useBinding(0)
	React.useEffect(function()
		local conn = RunService.Heartbeat:Connect(function(dt)
			setRot((rot:getValue() + dt * resolved.Speed) % 360)
		end)

		return function()
			conn:Disconnect()
		end
	end, { rot })
	resolved.Rotation = rot

	return e(Instances.UIGradient, resolved)
end