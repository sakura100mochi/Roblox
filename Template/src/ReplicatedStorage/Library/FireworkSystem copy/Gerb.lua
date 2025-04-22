--Name		: Gerb
--Explain	: ジャーブ　噴水のように火の粉を噴き上げる花火
local Gerb = {}

local function makeGerbParticle(GerbParent, Color, Speed, SpreadAngle)
	local newGerb = Instance.new("ParticleEmitter")
	newGerb.Parent = GerbParent
	newGerb.Color = Color
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
		Color1 = ColorSequence.new(firework.Colors.K)
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
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
	while true do
		local Color1 = ColorSequence.new(firework.Colors[Colors_Table[math.random(1, #Colors_Table)]])
		local Color2 = ColorSequence.new(firework.Colors[Colors_Table[math.random(1, #Colors_Table)]])
		local Color3 = ColorSequence.new(firework.Colors[Colors_Table[math.random(1, #Colors_Table)]])
		local Color4 = ColorSequence.new(firework.Colors[Colors_Table[math.random(1, #Colors_Table)]])
		local Color5 = ColorSequence.new(firework.Colors[Colors_Table[math.random(1, #Colors_Table)]])
		local ft_table = {
			function()firework.Gerb.launch(GerbParent, Color1, Color2, Color3, Color4, Color5)end,
			function()firework.Gerb.launch(GerbParent, Color1)end
		}
		task.spawn(function()ft_table[math.random(1, #ft_table)]()end)
		task.wait(3)
	end
end

function Gerb.fan(GerbParent, Color1, Color2, Color3, Color4, Color5)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	local NUM = 13

	if GerbParent == nil then
		warn("ERROR: no argument [fireworkSystem.Gerb.fan]")
		return
	end
	if Color1 == nil then
		Color1 = ColorSequence.new(firework.Colors.K)
	end
	if Color2 == nil or Color3 == nil or Color4 == nil or Color5 == nil then
		Color2 = Color1
		Color3 = Color1
		Color4 = Color1
		Color5 = Color1
	end

	for i = 0, NUM, 1 do
		task.spawn(function()

		local t = (i - ((NUM - 1) / 2)) / ((NUM - 1) / 2)
		local angle = t * 60
		local attachment = Instance.new("Attachment")
		attachment.Parent = GerbParent
		attachment.Rotation = Vector3.new(0, 0, angle)
		game:GetService("Debris"):AddItem(attachment, 3)

		local LaunchSound = firework.Sound.makeSound("SmallExplode")
		LaunchSound:Play()

		local particle1 = makeGerbParticle(attachment, Color1, NumberRange.new(5, 60), Vector2.new(5, 5))
		particle1:Emit(30)
		task.wait(0.01)
		local particle2 = makeGerbParticle(attachment, Color2, NumberRange.new(40, 110), Vector2.new(5, 5))
		particle2:Emit(40)
		task.wait(0.01)
		local particle3 = makeGerbParticle(attachment, Color3, NumberRange.new(90, 160), Vector2.new(7, 7))
		particle3:Emit(40)
		task.wait(0.01)
		local particle4 = makeGerbParticle(attachment, Color4, NumberRange.new(140, 210), Vector2.new(7, 7))
		particle4:Emit(40)
		task.wait(0.01)
		local particle5 = makeGerbParticle(attachment, Color5, NumberRange.new(190, 250), Vector2.new(6, 6))
		particle5:Emit(40)

		firework.Smoke.launch(GerbParent)
		end)
	end
end


return Gerb
