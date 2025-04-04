local SoundService = game:GetService("SoundService")
--Name		: FireworkSystem
--Explain	: 計算
local firework = {}

firework.Colors = {
	ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 207, 96)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(192, 192, 192)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
		},
	ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 207, 96)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(248, 240, 93)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(247, 225, 103))
		},
	ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 79, 79)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(223, 73, 73)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(229, 125, 125))
		},
	ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(59, 161, 90)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(104, 228, 135)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(182, 249, 149))
		},
	ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(249, 83, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(217, 122, 225)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(205, 138, 229))
		},
	ColorSequence.new(Color3.fromRGB(72, 110, 198), Color3.fromRGB(125, 167, 211))
}

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
	new.Velocity = Vector3.new(math.random(0, 20), math.random(50, 60), math.random(0, 20))

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
	elseif str == "After" then
		new.SoundId = "rbxassetid://100817659362842"
	end

	return new
end

--Function Name	:classic
--Explain		:classicタイプの花火を打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Arguments| Color			: (ColorSequence or nil) 花火の色
--										defaultは、ゴールド、シルバー、白のフィナーレの花火の色
--Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
--										defaultは、0.75
--Arguments| ExplodeSpeed	: (NumberRange or nil) 花火の爆発するスピード
--										defaultは、NumberRange.new(150,200)
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

	task.wait(math.random(15, 30) / 10)

	local ExplodeSound = makeSound("Explode")
	ExplodeSound:Play()

	fire:Destroy()
	for i = 1, 5, 1 do
		local particle = makeParticle(Part, Color, NumberRange.new(ExplodeTime), ExplodeSpeed)
		particle:Emit(math.random(30,50))
	end

	local AfterSound = makeSound("After")
	AfterSound:Play()

	task.wait(ExplodeTime)

	Part:Destroy()

	task.wait(1)
	LaunchSound:Destroy()
	ExplodeSound:Destroy()
	AfterSound:Destroy()
end

--Function Name	:AutoSystem_clasic
--Explain		:classicタイプの花火を自動でたくさん打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function firework.AutoSystem_clasic(Start_CFrame)
	while true do
		for i = 1, math.random(3, 5), 1 do
			local Color = firework.Colors[math.random(1, #firework.Colors)]
			local ExplodeTime = math.random(75, 200) / 100
			local tmp = math.random(150, 250)
			local ExplodeSpeed = NumberRange.new(tmp, tmp + 50)
			task.spawn(function()firework.classic(Start_CFrame, Color, ExplodeTime, ExplodeSpeed)end)
		end
		task.wait(2)
	end
end



--Function Name	:double
--Explain		:classicタイプの花火の中心に、もうひとつ小さなclassicタイプの花火を打ち上げる
--Arguments| Start_CFrame		: (CFrame) 花火を打ち上げる場所のCFrame
--Arguments| ColorBIG			: (ColorSequence or nil) 大きな花火の色
--										defaultは、ゴールド、シルバー、白のフィナーレの花火の色
--Arguments| ColorSMALL			: (ColorSequence or nil) 大きな花火の中心に打ちあがる、小さな花火の色
--										defaultは、ゴールド、シルバー、白のフィナーレの花火の色
--Arguments| ExplodeTime		: (Number or nil) 花火の爆発する時間
--										defaultは、0.75
--Arguments| ExplodeSpeedBIG	: (NumberRange or nil) 大きな花火の爆発するスピード
--										defaultは、NumberRange.new(150,200)
--Arguments| ExplodeSpeedSMALL	: (NumberRange or nil) 大きな花火の中心に打ちあがる、小さな花火の爆発するスピード
--										defaultは、NumberRange.new(50,150)
--Return Value	: none
function firework.double(Start_CFrame, ColorBIG, ColorSMALL, ExplodeTime, ExplodeSpeedBIG, ExplodeSpeedSMALL)
	if Start_CFrame == nil then
		warn("ERROR: no argument")
	end
	if ColorBIG == nil or ColorSMALL == nil or ExplodeTime == nil or ExplodeSpeedBIG == nil or ExplodeSpeedSMALL == nil then
		ColorBIG = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 207, 96)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(192, 192, 192)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
		}
		ColorSMALL = ColorBIG
		ExplodeTime = 0.75
		ExplodeSpeedBIG = NumberRange.new(150,200)
		ExplodeSpeedSMALL = NumberRange.new(50, 150)
	end

	local Part = makePart(Start_CFrame)
	local fire = makeFire(Part)
	makeBodyGyro(Part)
	makeBodyVelocity(Part)

	local LaunchSound = makeSound("Launch")
	LaunchSound:Play()

	task.wait(math.random(15, 30) / 10)

	local ExplodeSound = makeSound("Explode")
	ExplodeSound:Play()

	fire:Destroy()
	for i = 1, 5, 1 do
		local particleBig = makeParticle(Part, ColorBIG, NumberRange.new(ExplodeTime), ExplodeSpeedBIG)
		particleBig:Emit(math.random(30,50))
		local particleSmall = makeParticle(Part, ColorSMALL, NumberRange.new(ExplodeTime), ExplodeSpeedSMALL)
		particleSmall:Emit(math.random(30,50))
	end

	local AfterSound = makeSound("After")
	AfterSound:Play()

	task.wait(ExplodeTime)

	Part:Destroy()

	task.wait(1)
	LaunchSound:Destroy()
	ExplodeSound:Destroy()
	AfterSound:Destroy()
end

--Function Name	:AutoSystem_double
--Explain		:doubleタイプの花火を自動でたくさん打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function firework.AutoSystem_double(Start_CFrame)
	while true do
		for i = 1, math.random(3, 5), 1 do
			local ColorBIG = firework.Colors[math.random(1, #firework.Colors)]
			local ColorSMALL = firework.Colors[math.random(1, #firework.Colors)]
			local ExplodeTime = math.random(75, 200) / 100
			local tmp = math.random(150, 250)
			local ExplodeSpeedBIG = NumberRange.new(tmp, tmp + 50)
			local ExplodeSpeedSMALL = NumberRange.new(tmp - 100, tmp)
			task.spawn(function()firework.double(Start_CFrame, ColorBIG, ColorSMALL, ExplodeTime, ExplodeSpeedBIG, ExplodeSpeedSMALL)end)
		end
		task.wait(2)
	end
end

--Function Name	:triple
--Explain		:classicタイプの花火の中心に、2つの小さなclassicタイプの花火を打ち上げる
--Arguments| Start_CFrame		: (CFrame) 花火を打ち上げる場所のCFrame
--Arguments| ColorBIG			: (ColorSequence or nil) 大きな花火の色
--										defaultは、ゴールド、シルバー、白のフィナーレの花火の色
--Arguments| ColorMIDDLE		: (ColorSequence or nil) 中くらいの花火の色
--										defaultは、ゴールド、シルバー、白のフィナーレの花火の色
--Arguments| ColorSMALL			: (ColorSequence or nil) 小さな花火の色
--										defaultは、ゴールド、シルバー、白のフィナーレの花火の色
--Arguments| ExplodeTime		: (Number or nil) 花火の爆発する時間
--										defaultは、0.75
--Arguments| ExplodeSpeedBIG	: (NumberRange or nil) 大きな花火の爆発するスピード
--										defaultは、NumberRange.new(150,200)
--Arguments| ExplodeSpeedMIDDLE	: (NumberRange or nil) 中くらいの花火の爆発するスピード
--										defaultは、NumberRange.new(75,150)
--Arguments| ExplodeSpeedSMALL	: (NumberRange or nil) 小さな花火の爆発するスピード
--										defaultは、NumberRange.new(0,75)
--Return Value	: none
function firework.triple(Start_CFrame, ColorBIG, ColorMiddle, ColorSMALL, ExplodeTime, ExplodeSpeedBIG, ExplodeSpeedMiddle, ExplodeSpeedSMALL)
	if Start_CFrame == nil then
		warn("ERROR: no argument")
	end
	if ColorBIG == nil or ColorSMALL == nil or ExplodeTime == nil or ExplodeSpeedBIG == nil or ExplodeSpeedSMALL == nil or
		ColorMiddle == nil or ExplodeSpeedMiddle == nil then
		ColorBIG = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(226, 207, 96)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(192, 192, 192)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
		}
		ColorMiddle = ColorBIG
		ColorSMALL = ColorBIG
		ExplodeTime = 0.75
		ExplodeSpeedBIG = NumberRange.new(150,200)
		ExplodeSpeedMiddle = NumberRange.new(75,150)
		ExplodeSpeedSMALL = NumberRange.new(0, 75)
	end

	local Part = makePart(Start_CFrame)
	local fire = makeFire(Part)
	makeBodyGyro(Part)
	makeBodyVelocity(Part)

	local LaunchSound = makeSound("Launch")
	LaunchSound:Play()

	task.wait(math.random(15, 30) / 10)

	local ExplodeSound = makeSound("Explode")
	ExplodeSound:Play()

	fire:Destroy()
	for i = 1, 5, 1 do
		local particleBig = makeParticle(Part, ColorBIG, NumberRange.new(ExplodeTime), ExplodeSpeedBIG)
		particleBig:Emit(math.random(30,50))
		local particleMiddle = makeParticle(Part, ColorMiddle, NumberRange.new(ExplodeTime), ExplodeSpeedMiddle)
		particleMiddle:Emit(math.random(30,50))
		local particleSmall = makeParticle(Part, ColorSMALL, NumberRange.new(ExplodeTime), ExplodeSpeedSMALL)
		particleSmall:Emit(math.random(30,50))
	end

	local AfterSound = makeSound("After")
	AfterSound:Play()

	task.wait(ExplodeTime)

	Part:Destroy()

	task.wait(1)
	LaunchSound:Destroy()
	ExplodeSound:Destroy()
	AfterSound:Destroy()
end

--Function Name	:AutoSystem_triple
--Explain		:tripleタイプの花火を自動でたくさん打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function firework.AutoSystem_triple(Start_CFrame)
	while true do
		for i = 1, math.random(3, 5), 1 do
			local ColorBIG = firework.Colors[math.random(1, #firework.Colors)]
			local ColorMiddle = firework.Colors[math.random(1, #firework.Colors)]
			local ColorSMALL = firework.Colors[math.random(1, #firework.Colors)]
			local ExplodeTime = math.random(75, 200) / 100
			local tmp = math.random(150, 250)
			local ExplodeSpeedBIG = NumberRange.new(tmp, tmp + 50)
			local ExplodeSpeedMiddle = NumberRange.new(tmp - 50, tmp)
			local ExplodeSpeedSMALL = NumberRange.new(0, tmp - 50)
			task.spawn(function()firework.triple(Start_CFrame, ColorBIG, ColorMiddle, ColorSMALL, ExplodeTime, ExplodeSpeedBIG, ExplodeSpeedMiddle, ExplodeSpeedSMALL)end)
		end
		task.wait(2)
	end
end

--Function Name	:AutoSystem_All
--Explain		:全種類のタイプの花火を自動でたくさん打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function firework.AutoSystem_All(Start_CFrame)
	while true do
		for i = 1, math.random(3, 5), 1 do
			local ColorBIG = firework.Colors[math.random(1, #firework.Colors)]
			local ColorMiddle = firework.Colors[math.random(1, #firework.Colors)]
			local ColorSMALL = firework.Colors[math.random(1, #firework.Colors)]
			local ExplodeTime = math.random(75, 200) / 100
			local tmp = math.random(150, 250)
			local ExplodeSpeedBIG = NumberRange.new(tmp, tmp + 50)
			local ExplodeSpeedMiddle = NumberRange.new(tmp - 50, tmp)
			local ExplodeSpeedSMALL = NumberRange.new(0, tmp - 50)
			local ft_table = {
				function()firework.classic(Start_CFrame, ColorBIG, ExplodeTime, ExplodeSpeedBIG)end,
				function()firework.double(Start_CFrame, ColorBIG, ColorSMALL, ExplodeTime, ExplodeSpeedBIG, ExplodeSpeedSMALL)end,
				function()firework.triple(Start_CFrame, ColorBIG, ColorMiddle, ColorSMALL, ExplodeTime, ExplodeSpeedBIG, ExplodeSpeedMiddle, ExplodeSpeedSMALL)end
			}
			task.spawn(function()ft_table[math.random(1, #ft_table)]()end)
		end
		task.wait(2)
	end
end

return firework