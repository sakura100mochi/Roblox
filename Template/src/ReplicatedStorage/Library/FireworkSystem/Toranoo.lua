--Name		: Toranoo
--Explain	: 虎の尾
local Toranoo = {}

local function makeFlareparticles(particleParent, Color, ExplodeTime)
	local particles = {}

	for i = 1, 10, 1 do
		local newSparkles = Instance.new("Sparkles")
		newSparkles.SparkleColor = Color
		newSparkles.Parent = particleParent
		table.insert(particles, newSparkles)
	end

	for i = 1, 20, 1 do
		local newFire = Instance.new("Fire")
		newFire.Color = Color
		newFire.SecondaryColor = Color
		newFire.Heat = 25
		newFire.Size = 3
		newFire.Parent = particleParent
		table.insert(particles, newFire)
		task.wait(0.001)
	end

	task.delay(ExplodeTime, function()
		for _, child in pairs(particles) do
			if child and child.Parent and child.Enabled then
				child.Enabled = false
			end
		end
	end)
end

local function makeNeonPart(Start_CFrame, Color, Velocity, ExplodeTime)
	local new = Instance.new("Part")
	new.Parent = workspace
	new.Anchored = false
	new.Transparency = 0
	new.CanCollide = false
	new.CFrame = Start_CFrame * CFrame.Angles(math.pi, 0, 0)
	new.Color = Color
	new.Material = Enum.Material.Neon
	new.Shape = Enum.PartType.Ball
	new.Anchored = false
	new.Velocity = Velocity
	new.Size = Vector3.new(0.5, 0.5, 0.5)
	new.Transparency = 0.75

	local light = Instance.new("PointLight")
	light.Color = Color
	light.Brightness = 15
	light.Range = 10

	task.delay(ExplodeTime, function()
		new.Transparency = 1
	end)
	-- 浮力の追加
	local newBodyForce = Instance.new("BodyForce")
	newBodyForce.force = Vector3.new(0, new:GetMass() * 196.2 * 0.95, 0)
	newBodyForce.Parent = new

	return new
end

--Function Name	:launch
--Explain		:虎の尾タイプの花火を打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Arguments| Color			: (Color3 or nil) 花火の色
--										defaultは、Ca
--Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
--										defaultは、2
--Return Value	: none
function Toranoo.launch(Start_CFrame, Color, ExplodeTime, Velocity)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	if Start_CFrame == nil then
		warn("ERROR: no argument [fireworkSystem.Toranoo]")
		return
	end
	if Color == nil or ExplodeTime == nil or Velocity == nil then
		Color = firework.Colors.Ca
		ExplodeTime = 2
		Velocity = Vector3.new(math.random(-1, 1), 2, math.random(-1, 1)) * 20
	end

	local LaunchSound = firework.Sound.makeSound("SmallExplode")
	LaunchSound:Play()
	game:GetService("Debris"):AddItem(LaunchSound, 3)

	local Part = makeNeonPart(Start_CFrame, Color, Velocity, ExplodeTime)
	game:GetService("Debris"):AddItem(Part, 3)
	makeFlareparticles(Part, Color, ExplodeTime)

	task.wait(ExplodeTime - 0.8)

	local FizzleSound = firework.Sound.makeSound("Fizzle")
	FizzleSound:Play()
	game:GetService("Debris"):AddItem(FizzleSound, 2)
end

--Function Name	:AutoSystem
--Explain		:虎の尾タイプの花火を自動でたくさん打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function Toranoo.AutoSystem(Start_CFrame)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	while true do
		for i = 1, math.random(3, 5), 1 do
			local Color = firework.Colors.Al
			local ExplodeTime = math.random(150, 300) / 100
			local Velocity = Vector3.new(math.random(-1, 1), 2, math.random(-1, 1)) * 20
			task.spawn(function()Toranoo.launch(Start_CFrame, Color, ExplodeTime, Velocity)end)
		end
		task.wait(2)
	end
end

--Function Name	:fan
--Explain		:虎の尾タイプの花火を扇型に打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function Toranoo.fan(Start_CFrame)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	local NUM = 13
	for i = 0, NUM, 1 do
		local Color = firework.Colors.Al
		local ExplodeTime = 1.5
		local t = (i - ((NUM - 1) / 2)) / ((NUM - 1) / 2)
		local angle = t * math.rad(60)

		local minSpeed = 35
		local maxSpeed = 40
		local factor = 1 - math.abs(t) ^ 1.5 -- 中心：1、端：0.18くらい
		local speed = minSpeed + (maxSpeed - minSpeed) * factor
		local x = math.sin(angle) * speed
		local y = math.cos(angle) * speed
		local Velocity = Vector3.new(x, y, 0)
		task.spawn(function()Toranoo.launch(Start_CFrame, Color, ExplodeTime, Velocity)end)
	end
end

return Toranoo
