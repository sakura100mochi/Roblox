--Name		: Smoke
--Explain	: 煙
local Smoke = {}

local function makeSmoke(smokeParent)
	local newSmoke = Instance.new("ParticleEmitter")
	newSmoke.Parent = smokeParent
	newSmoke.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
	newSmoke.LightEmission = 1
	newSmoke.LightInfluence = 1
	newSmoke.Orientation = Enum.ParticleOrientation.FacingCamera
	newSmoke.Size = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.625),
		NumberSequenceKeypoint.new(0.072, 3.37),
		NumberSequenceKeypoint.new(0.525, 3.75),
		NumberSequenceKeypoint.new(0.852, 3.44),
		NumberSequenceKeypoint.new(1, 0)
	}
	newSmoke.Squash = NumberSequence.new(0)
	newSmoke.Texture = "http://www.roblox.com/asset/?id=14855615895"
	newSmoke.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.956),
		NumberSequenceKeypoint.new(0.955, 0.95),
		NumberSequenceKeypoint.new(1, 1)
	}
	newSmoke.Lifetime = NumberRange.new(5)
	newSmoke.Rate = 99999997952
	newSmoke.RotSpeed = NumberRange.new(-5, 5)
	newSmoke.Speed = NumberRange.new(2, 175)
	newSmoke.SpreadAngle = Vector2.new(7, 7)
	newSmoke.Drag = 3
	newSmoke.Enabled = false
	newSmoke.Acceleration = Vector3.new(7, 0, 0)

	return newSmoke
end

function Smoke.launch(smokeParent)
	local newSmoke = makeSmoke(smokeParent)
	game:GetService("Debris"):AddItem(newSmoke, 3)
	newSmoke.Enabled = true
	task.wait(0.2)
	newSmoke.Enabled = false
end

return Smoke
