--Name		: Gerb
--Explain	: ジャーブ　噴水のように火の粉を噴き上げる花火
local Gerb = {}

local function makeGerbParticle(GerbParent, Color, Speed, SpreadAngle)
	local newGerb = Instance.new("ParticleEmitter")
	newGerb.Parent = GerbParent
	newGerb.Color = ColorSequence.new(Color)
	newGerb.LightEmission = 1
	newGerb.LightInfluence = 1
	newGerb.Orientation = Enum.ParticleOrientation.FacingCamera
	newGerb.Size = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(0.9, 2),
		NumberSequenceKeypoint.new(1, 1)
	}
	newGerb.Squash = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(0.2, 0),
		NumberSequenceKeypoint.new(1, 0)
	}
	newGerb.Texture = "rbxassetid://272050333"
	newGerb.Lifetime = NumberRange.new(0.3, 1)
	newGerb.Rate = 0
	newGerb.Speed = Speed
	newGerb.SpreadAngle = SpreadAngle
	newGerb.Drag = 10
	newGerb.Enabled = true
	newGerb.Brightness = 10

	game:GetService("Debris"):AddItem(newGerb, 2)
	return newGerb
end

function Gerb.launch(GerbParent, Color1, Color2, Color3, Color4, Color5)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	if GerbParent == nil then
		warn("ERROR: no argument [fireworkSystem.Gerb]")
		return
	end
	if Color1 == nil then
		Color1 = firework.Colors.K
	end
	if Color2 == nil or Color3 == nil or Color4 == nil or Color5 == nil then
		Color2 = Color1
		Color3 = Color1
		Color4 = Color1
		Color5 = Color1
	end

	local LaunchSound = firework.Sound.makeSound("SmallExplode")
	LaunchSound:Play()

	local particle1 = makeGerbParticle(GerbParent, Color1, NumberRange.new(5, 60), Vector2.new(5, 5))
	particle1:Emit(30)
	task.wait(0.01)
	local particle2 = makeGerbParticle(GerbParent, Color2, NumberRange.new(40, 110), Vector2.new(5, 5))
	particle2:Emit(40)
	task.wait(0.01)
	local particle3 = makeGerbParticle(GerbParent, Color3, NumberRange.new(90, 160), Vector2.new(7, 7))
	particle3:Emit(40)
	task.wait(0.01)
	local particle4 = makeGerbParticle(GerbParent, Color4, NumberRange.new(140, 210), Vector2.new(7, 7))
	particle4:Emit(40)
	task.wait(0.01)
	local particle5 = makeGerbParticle(GerbParent, Color5, NumberRange.new(190, 250), Vector2.new(6, 6))
	particle5:Emit(40)

	firework.Smoke.launch(GerbParent)
end

function Gerb.AutoSystem(GerbParent)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al"}
	while true do
		local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
		local Color2 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
		local Color3 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
		local Color4 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
		local Color5 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
		local ft_table = {
			function()firework.Gerb.launch(GerbParent, Color1, Color2, Color3, Color4, Color5)end,
			function()firework.Gerb.launch(GerbParent, Color1)end
		}
		task.spawn(function()ft_table[math.random(1, #ft_table)]()end)
		task.wait(3)
	end
end

return Gerb
