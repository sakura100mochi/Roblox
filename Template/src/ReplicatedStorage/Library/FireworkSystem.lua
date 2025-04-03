local SoundService = game:GetService("SoundService")
--Name		: FireworkSystem
--Explain	: 計算
local firework = {}

local function makeParticle(particleParent, Color, Lifetime, Speed)
	local new = Instance.new("ParticleEmitter")
	new.Parent = particleParent
	new.Texture = "rbxassetid://7216979807"
	new.Brightness = 10
	new.Rate = 0
	new.Size = NumberSequence.new(5.13, 0)
	new.SpreadAngle = Vector2.new(-360, 360)
	new.LightEmission = 1
	new.Orientation = Enum.ParticleOrientation.VelocityParallel
	new.Drag = 20
	new.Color = Color
	new.Lifetime = Lifetime
	new.Speed = Speed

	return new
end

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

local function makePart(Start_CFrame)
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
	new.Velocity = Vector3.new(0, 50, 0)

	return new
end

local function makeSound(str)
	local new = Instance.new("Sound")
	new.Parent = game:GetService("SoundService")

	if str == "Launch" then
		new.SoundId = "rbxassetid://551051176"
	elseif str == "Explode" then
		new.SoundId = "rbxassetid://4583102108"
		new.Volume = 5
	end

	return new
end

--Function Name	:classic
--Explain		:classicタイプの花火を打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火が打ち上げる場所のCFrame
--Arguments| Color			: (ColorSequence or nil) 花火の色
--Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
--Arguments| ExplodeSpeed	: (NumberRange or nil) 花火の爆発するスピード
--Return Value	: none
function firework.classic(Start_CFrame, Color, ExplodeTime, ExplodeSpeed)
	if Start_CFrame == nil then
		warn("ERROR: no argument")
	end
	if Color == nil or ExplodeTime == nil or ExplodeSpeed == nil then
		Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 207, 96)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(192, 192, 192)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
		}
		ExplodeTime = 0.75
		ExplodeSpeed = NumberRange.new(150,200)
	end

	local Part = makePart(Start_CFrame)
	local fire = makeFire(Part)
	makeBodyGyro(Part)
	makeBodyVelocity(Part)

	local LaunchSound = makeSound("Launch")
	LaunchSound:Play()

	task.wait(math.random(1.2,1.5))

	local ExplodeSound = makeSound("Explode")
	ExplodeSound:Play()

	fire:Destroy()
	for i = 1, 5, 1 do
		local particle = makeParticle(Part, Color, NumberRange.new(ExplodeTime), ExplodeSpeed)
		particle:Emit(math.random(30,50))
	end

	task.wait(ExplodeTime)

	Part:Destroy()

	task.wait(1)
	LaunchSound:Destroy()
	ExplodeSound:Destroy()
end

return firework