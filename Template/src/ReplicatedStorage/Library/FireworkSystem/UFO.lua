--Name		: UFO
--Explain	: 型物　UFO・土星
local UFO = {}

local function makeBotanParticle(particleParent, Color, Lifetime, Speed)
	local new = Instance.new("ParticleEmitter")
	new.Parent = particleParent
	new.Texture = "rbxassetid://272050333"
	new.Brightness = 10
	new.Rate = 0
	new.Size = NumberSequence.new(2, 0)
	new.SpreadAngle = Vector2.new(-360, 360)
	new.LightEmission = 1
	new.Drag = 20
	new.Color = Color
	new.Lifetime = Lifetime
	new.Speed = Speed

	return new
end

local function makeRingParticle(particleParent, Color, Lifetime, Speed)
	local new = Instance.new("ParticleEmitter")
	new.Parent = particleParent
	new.Texture = "rbxassetid://272050333"
	new.Brightness = 10
	new.Rate = 0
	new.Size = NumberSequence.new(4, 0)
	new.SpreadAngle = Vector2.new(0, 360)
	new.LightEmission = 1
	new.Drag = 13
	new.Color = Color
	new.Lifetime = Lifetime
	new.Speed = Speed
	new.EmissionDirection = Enum.NormalId.Right

	return new
end

--Function Name	:UFO
--Explain		:型物　土星・UFOタイプの花火を打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Arguments| ColorBotan			: (Color3 or nil) 牡丹の花火の色
--										defaultは、Ca
--Arguments| ColorRing			: (Color3 or nil) リングの花火の色
--										defaultは、Ca
--Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
--										defaultは、3
--Arguments| ExplodeSpeed	: (NumberRange or nil) 花火の爆発するスピード
--										defaultは、NumberRange.new(350,370)
--Return Value	: none
function UFO.launch(Start_CFrame, ColorBotan, ColorRing, ExplodeTime, ExplodeSpeed)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	if Start_CFrame == nil then
		warn("ERROR: no argument [FireworkSystem.UFO]")
		return
	end
	if ColorBotan == nil or ColorRing == nil or ExplodeTime == nil or ExplodeSpeed == nil then
		ColorBotan = firework.Colors.Ca
		ColorRing = firework.Colors.Ca
		ExplodeTime = 3
		ExplodeSpeed = NumberRange.new(350,370)
	end

	local Nobori = firework.Nobori.makeNobori(Start_CFrame);

	local ExplodeSound = firework.Sound.makeSound("Explode")
	ExplodeSound:Play()

	for i = 1, 3, 1 do
		local particle = makeRingParticle(Nobori, ColorSequence.new(ColorRing), NumberRange.new(ExplodeTime), NumberRange.new(ExplodeSpeed.Min + 20, ExplodeSpeed.Max + 20))
		particle:Emit(math.random(30, 50))
	end
	for i = 1, 5, 1 do
		local particle = makeBotanParticle(Nobori, ColorSequence.new(ColorBotan), NumberRange.new(ExplodeTime), ExplodeSpeed)
		particle:Emit(math.random(70,100))
	end

	local AfterSound = firework.Sound.makeSound("After")
	AfterSound:Play()

	task.wait(ExplodeTime)

	Nobori:Destroy()

	task.wait(1)
	ExplodeSound:Destroy()
	AfterSound:Destroy()
end

--Function Name	:AutoSystem
--Explain		:型物　土星・UFOタイプの花火を自動でたくさん打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function UFO.AutoSystem(Start_CFrame)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al"}
	while true do
		for i = 1, math.random(1, 2), 1 do
			local ColorBotan = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ColorRing = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ExplodeTime = math.random(200, 300) / 100
			local tmp = math.random(250, 350)
			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
			task.spawn(function()UFO.launch(Start_CFrame, ColorBotan, ColorRing, ExplodeTime, ExplodeSpeed)end)
		end
		task.wait(2)
	end
end

return UFO
