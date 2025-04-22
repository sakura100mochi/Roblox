--Name		: Kiku
--Explain	: 菊
local Kiku = {}

local function makeKikuParticle(particleParent, Color)
	local new = Instance.new("ParticleEmitter")
	new.Parent = particleParent
	new.Texture = "rbxassetid://272050333"
	new.Brightness = 10
	new.Rate = 0
	new.Size = NumberSequence.new(2, 0)
	new.SpreadAngle = Vector2.new(0, 0)
	new.LightEmission = 1
	new.Drag = 10
	new.Color = Color
	new.Lifetime = NumberRange.new(1.5)
	new.Speed = NumberRange.new(0)
	new.VelocityInheritance = 0.5

	return new
end

local function makeFlarePart(particleParent, Speed)
	local newPart = Instance.new("Part")
	newPart.Parent = particleParent
	newPart.Transparency = 1
	newPart.TopSurface = "Smooth"
	newPart.BottomSurface = "Smooth"
	newPart.formFactor = "Custom"
	newPart.Size = Vector3.new(0.4, 0.4, 0.4)
	newPart.CanCollide = false
	newPart.CFrame = particleParent.CFrame
	local theta = math.random() * 2 * math.pi
	local phi = math.acos(2 * math.random() - 1)
	local x = math.sin(phi) * math.cos(theta)
	local y = math.sin(phi) * math.sin(theta)
	local z = math.cos(phi)
	newPart.Velocity = Vector3.new(x, y, z) * Speed

	-- 浮力の追加
	local newBodyForce = Instance.new("BodyForce")
	newBodyForce.force = Vector3.new(0, newPart:GetMass() * 196.2 * 0.99, 0)
	newBodyForce.Parent = newPart

	return newPart
end

local function makeFire(particleParent)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	local newFire = Instance.new("Fire")
	newFire.Color = firework.Colors.C
	newFire.SecondaryColor = firework.Colors.C
	newFire.Heat = 1
	newFire.Parent = particleParent
	newFire.Size = 3

	return newFire
end

local function makeFireParticles(particleParent)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	local fire = Instance.new("ParticleEmitter")
	fire.Color = ColorSequence.new(firework.Colors.C)
	fire.Brightness = 10
	fire.LightEmission = 1
	fire.Size = NumberSequence.new(1.5, 0)
	fire.Texture = "http://www.roblox.com/asset/?id=11534281007"
	fire.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.5),
		NumberSequenceKeypoint.new(1, 1)
	}
	fire.Parent = particleParent
	fire.Drag = 0
	fire.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
	fire.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
	-- fire.Acceleration = Vector3.new(0, 8, 0)
	fire.Lifetime = NumberRange.new(1, 1.5)
	fire.Rate = 50
	-- fire.Rotation = NumberRange.new(-360, 360)
	-- fire.RotSpeed = NumberRange.new(-15, 15)
	fire.Speed = NumberRange.new(1.25, 2.5)
	fire.SpreadAngle = Vector2.new(5, 5)

	return fire
end

Kiku.FLARE_NUM = 300
local function makeFlare(particleParent, Color, Lifetime, Speed)
	for i= 1, Kiku.FLARE_NUM, 1 do
		local newPart = makeFlarePart(particleParent, Speed)
		local newFire = makeFireParticles(newPart)

		task.delay(Lifetime - (Lifetime / 5), function()
			newFire.Enabled = false
			if Color then
				local particle = makeKikuParticle(newPart, ColorSequence.new(Color))
				particle:Emit(1)
			end
		end)
		game:GetService("Debris"):AddItem(newPart, Lifetime + 1)
	end
end


--Function Name	:Kiku
--Explain		:菊タイプの花火を打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Arguments| Color			: (Color3 or nil) 指定すると、変化菊になる。
--Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
--										defaultは、2
--Arguments| ExplodeSpeed	: (NumberRange or nil) 花火の爆発するスピード
--										defaultは、NumberRange.new(300)
--Return Value	: none
function Kiku.launch(Start_CFrame, Color, ExplodeTime, ExplodeSpeed, NoboriTime)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	if Start_CFrame == nil then
		warn("ERROR: no argument [FireworkSystem.Kiku]")
		return
	end
	if ExplodeTime == nil or ExplodeSpeed == nil then
		ExplodeTime = 2
		ExplodeSpeed = 20
	end

	local Nobori = firework.Nobori.makeNobori(Start_CFrame, NoboriTime);

	local ExplodeSound = firework.Sound.makeSound("Explode")
	ExplodeSound:Play()

	makeFlare(Nobori, Color, ExplodeTime, ExplodeSpeed)

	local AfterSound = firework.Sound.makeSound("After")
	AfterSound:Play()

	task.wait(ExplodeTime)

	Nobori:Destroy()

	task.wait(1)
	ExplodeSound:Destroy()
	AfterSound:Destroy()
end

--Function Name	:AutoSystem
--Explain		:菊タイプの花火を自動でたくさん打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function Kiku.AutoSystem(Start_CFrame)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
	while true do
		for i = 1, math.random(1, 2), 1 do
			local Color = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ExplodeTime = math.random(200, 300) / 100
			local ExplodeSpeed = NumberRange.new(math.random(250, 300))
			task.spawn(function()Kiku.launch(Start_CFrame, nil, ExplodeTime, ExplodeSpeed)end)
		end
		task.wait(4)
	end
end

return Kiku
