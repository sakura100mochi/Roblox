--Name		: Kamuro
--Explain	: 冠
local Kamuro = {}

local function makeFlarePart(particleParent)
	local newPart = Instance.new("Part")
	newPart.Parent = particleParent
	newPart.Transparency = 1
	newPart.TopSurface = "Smooth"
	newPart.BottomSurface = "Smooth"
	newPart.formFactor = "Custom"
	newPart.Size = Vector3.new(0.4, 0.4, 0.4)
	newPart.CanCollide = false
	newPart.CFrame = particleParent.CFrame * CFrame.Angles(math.pi, 0, 0)
	newPart.Velocity = (particleParent.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))).lookVector * 20

	return newPart
end

local function makeFlareparticles(particleParent, Color)
	local particles = {}

	for i = 1, 4, 1 do
		local newSparkle = Instance.new("Sparkles")
		newSparkle.SparkleColor = Color
		newSparkle.Parent = particleParent
		table.insert(particles, newSparkle)
	end

	local newFire = Instance.new("Fire")
	newFire.Color = Color
	newFire.SecondaryColor = Color
	newFire.Heat = 25
	newFire.Parent = particleParent
	table.insert(particles, newFire)

	return particles
end

local function makeFlare(particleParent, Color, Lifetime)
	for i= 1, 70, 1 do
		local newPart = makeFlarePart(particleParent)
		local particles = makeFlareparticles(newPart, Color)

		-- 浮力の追加
		local newBodyForce = Instance.new("BodyForce")
		newBodyForce.force = Vector3.new(0, newPart:GetMass() * 196.2 * 0.95, 0)
		newBodyForce.Parent = newPart

		game:GetService("Debris"):AddItem(newPart, Lifetime)

		task.delay(Lifetime - 1, function()
			for _, child in pairs(particles) do
				if child and child.Parent and child.Enabled then
					child.Enabled = false
				end
			end
		end)
	end
end

--Function Name	:Kamuro
--Explain		:冠タイプの花火を打ち上げる　defaultは、錦冠
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Arguments| Color			: (Color3 or nil) 花火の色
--										defaultは、Ca
--Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
--										defaultは、2
--Return Value	: none
function Kamuro.launch(Start_CFrame, Color, ExplodeTime)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	if Start_CFrame == nil then
		warn("ERROR: no argument [fireworkSystem.Kamuro]")
		return
	end
	if Color == nil or ExplodeTime == nil then
		Color = firework.Colors.Ca
		ExplodeTime = 4
	end

	local Nobori = firework.Nobori.makeNobori(Start_CFrame)

	local ExplodeSound = firework.Sound.makeSound("Explode")
	ExplodeSound:Play()

	makeFlare(Nobori, Color, ExplodeTime)

	task.wait(ExplodeTime)

	local FizzleSound = firework.Sound.makeSound("Fizzle")
	FizzleSound:Play()

	Nobori:Destroy()

	task.wait(1)
	ExplodeSound:Destroy()
	FizzleSound:Destroy()
end

--Function Name	:AutoSystem
--Explain		:冠タイプの花火を自動でたくさん打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function Kamuro.AutoSystem(Start_CFrame)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al"}
	while true do
		for i = 1, math.random(2, 3), 1 do
			local Color = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ExplodeTime = math.random(300, 450) / 100
			task.spawn(function()Kamuro.launch(Start_CFrame, Color, ExplodeTime)end)
		end
		task.wait(5)
	end
end

return Kamuro
