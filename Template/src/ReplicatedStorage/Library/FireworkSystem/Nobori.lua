--Name		: Nobori
--Explain	: 花火が打ち揚げられ、親玉が開花する前に、親玉に装着されている部品
local Nobori = {}

local function makeFire(fireParent)
	local new = Instance.new("ParticleEmitter")
	new.Brightness = 4.325
	new.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(204, 56, 56)),
		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(240, 106, 83)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(228, 197, 85))
	}
	new.LightEmission = 0.45
	new.Size = NumberSequence.new{
		NumberSequenceKeypoint.new(0,0),
		NumberSequenceKeypoint.new(0.75,0.15),
		NumberSequenceKeypoint.new(1,0)
	}
	new.Texture = "http://www.roblox.com/asset/?id=1195495135"
	new.EmissionDirection = Enum.NormalId.Bottom
	new.Lifetime = NumberRange.new(0.25, 0.45)
	new.Rate = 75
	new.Rotation = NumberRange.new(-360, 360)
	new.RotSpeed = NumberRange.new(-360, 360)
	new.Speed = NumberRange.new(10, 15)
	new.SpreadAngle = Vector2.new(15, 15)
	new.LockedToPart = true
	new.Parent = fireParent

	return new
end

local function makeFireStarter(Start_CFrame)
	local new = Instance.new("Part")
	new.Parent = workspace
	new.Anchored = false
	new.Transparency = 1
	new.CanCollide = false
	new.Size = Vector3.new(1,1,1)
	new.CFrame = Start_CFrame

	return new
end

local function makeBodyGyro(BodyGyroParent)
	local new = Instance.new("BodyGyro")
	new.Parent = BodyGyroParent

	return new
end

local function makeBodyVelocity(BodyVelocityParent)
	local new = Instance.new("BodyVelocity")
	new.Parent = BodyVelocityParent
	new.Velocity = Vector3.new(math.random(0, 20), math.random(50, 60), math.random(0, 20))

	return new
end

function Nobori.makeNobori(Start_CFrame, Time)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	if Start_CFrame == nil then
		warn("ERROR: no argument [FireworkSystem.Nobori]")
		return
	end
	if Time == nil then
		Time = math.random(15, 30) / 10
	end

	local Part = makeFireStarter(Start_CFrame)
	local fire = makeFire(Part)
	makeBodyGyro(Part)
	makeBodyVelocity(Part)

	local LaunchSound = firework.Sound.makeSound("Launch")
	LaunchSound:Play()

	task.wait(Time)

	LaunchSound:Destroy()
	fire:Destroy()

	return Part
end

return Nobori
