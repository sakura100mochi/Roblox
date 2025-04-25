--Name		: UFO
--Explain	: 型物　UFO・土星
--			AFireworkの子クラス
local AFirework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"].AFirework)
local UFO = setmetatable({}, {__index = AFirework})
UFO.__index = UFO

local UFOPrototype = {
	Type = "UFO",
	Color2 = AFirework.Colors.C,
	ExplodeTime = 3,
	ExplodeSpeed = NumberRange.new(350, 370)
}

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

--Function Name	: new
--Explain		: 型物　土星・UFOタイプの花火をインスタンス化する
--Arguments| Table	: (table)Tableの値を設定する。値がない場合はPrototypeで指定されているデフォルト値にする
--Return Value	: (table) 設定した後のtable
function UFO.new(Table, Origin)
	if Origin == nil then
		Origin = UFOPrototype
	end
	local self = AFirework.new(Origin, Table)
	setmetatable(self, UFO)

	return self
end

--Method Name	: launch
--Explain		: 型物　土星・UFOタイプの花火を打ち上げる
--Return Value	: none
function UFO:launch()
	local firework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"])

	local Nobori = firework.Nobori.makeNobori(self);
	game:GetService("Debris"):AddItem(Nobori, self.ExplodeTime + 1)

	firework.Sound.PlaySound("Explode")

	for i = 1, 3, 1 do
		local particle = makeRingParticle(Nobori, ColorSequence.new(self.Color1), NumberRange.new(self.ExplodeTime), NumberRange.new(self.ExplodeSpeed.Min + 20, self.ExplodeSpeed.Max + 20))
		particle:Emit(math.random(30, 50))
	end
	for i = 1, 5, 1 do
		local particle = makeBotanParticle(Nobori, ColorSequence.new(self.Color2), NumberRange.new(self.ExplodeTime), self.ExplodeSpeed)
		particle:Emit(math.random(70,100))
	end

	firework.Sound.PlaySound("After")
end

--Method Name	: launchRandom
--Explain		: 型物　土星・UFOタイプの花火をランダムな色、大きさで打ち上げる
--Return Value	: none
function UFO:launchRandom()
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
	local tmp = math.random(250, 350)
	local Table = {
		Color1 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]],
		Color2 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]],
		ExplodeTime = math.random(200, 300) / 100,
		ExplodeSpeed = NumberRange.new(tmp, tmp + 20),
	}
	local newUFO = UFO.new(Table, self)
	newUFO:launch()
end

--Method Name	: AutoSystem
--Explain		: 型物　土星・UFOタイプの花火を自動でたくさん打ち上げる
--Return Value	: none
function UFO:AutoSystem()
	while true do
		for i = 1, math.random(1, 2), 1 do
			task.spawn(function()self:launchRandom()end)
		end
		task.wait(2)
	end
end

return UFO
