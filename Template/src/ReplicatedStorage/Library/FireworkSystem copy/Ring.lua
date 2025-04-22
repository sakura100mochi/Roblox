--Name		: Ring
--Explain	: リング
local Ring = {}

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

--Function Name	:Ring
--Explain		:リングタイプの花火を打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Arguments| Color			: (Color3 or nil) 花火の色
--										defaultは、Ca
--Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
--										defaultは、3
--Arguments| ExplodeSpeed	: (NumberRange or nil) 花火の爆発するスピード
--										defaultは、NumberRange.new(350,370)
--Return Value	: none
function Ring.launch(Start_CFrame, Color, ExplodeTime, ExplodeSpeed)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	if Start_CFrame == nil then
		warn("ERROR: no argument [FireworkSystem.Ring]")
		return
	end
	if Color == nil or ExplodeTime == nil or ExplodeSpeed == nil then
		Color = firework.Colors.Ca
		ExplodeTime = 3
		ExplodeSpeed = NumberRange.new(350,370)
	end

	local Nobori = firework.Nobori.makeNobori(Start_CFrame);

	local ExplodeSound = firework.Sound.makeSound("Explode")
	ExplodeSound:Play()

	for i = 1, 3, 1 do
		local particle = makeRingParticle(Nobori, ColorSequence.new(Color), NumberRange.new(ExplodeTime), ExplodeSpeed)
		particle:Emit(math.random(30, 50))
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
--Explain		:リングタイプの花火を自動でたくさん打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function Ring.AutoSystem(Start_CFrame)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
	while true do
		for i = 1, math.random(3, 5), 1 do
			local Color = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ExplodeTime = math.random(200, 300) / 100
			local tmp = math.random(250, 350)
			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
			task.spawn(function()Ring.launch(Start_CFrame, Color, ExplodeTime, ExplodeSpeed)end)
		end
		task.wait(2)
	end
end

return Ring
