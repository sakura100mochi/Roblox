--Name		: Botan
--Explain	: 牡丹
--			AFireworkの子クラス
local AFirework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"].AFirework)
local Botan = setmetatable({}, {__index = AFirework})
Botan.__index = Botan

local BotanPrototype = {
	Type = "Botan",
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

--Function Name	: new
--Explain		: 牡丹の花火をインスタンス化する
--Arguments| Table	: (table)Tableの値を設定する。値がない場合はPrototypeで指定されているデフォルト値にする
--Return Value	: (table) 設定した後のtable
function Botan.new(Table, Origin)
	if Origin == nil then
		Origin = BotanPrototype
	end
	local self = AFirework.new(Origin, Table)
	setmetatable(self, Botan)

	return self
end

--Method Name	:launch
--Explain		:牡丹タイプの花火を打ち上げる
--Return Value	: none
function Botan:launch()
	local firework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"])

	local Nobori = firework.Nobori.makeNobori(self);
	game:GetService("Debris"):AddItem(Nobori, self.ExplodeTime + 1)

	firework.Sound.PlaySound("Explode")

	local BotanColor = ColorSequence.new(self.Color1)
	if self.Color2 ~= nil then
		BotanColor = ColorSequence.new{
			ColorSequenceKeypoint.new(0, self.Color1),
			ColorSequenceKeypoint.new(0.4, self.Color2),
			ColorSequenceKeypoint.new(1, self.Color2)
		}
	end

	for i = 1, 5, 1 do
		local particle = makeBotanParticle(Nobori, BotanColor, NumberRange.new(self.ExplodeTime), self.ExplodeSpeed)
		particle:Emit(math.random(70,100))
	end

	firework.Sound.PlaySound("After")
end

--Method Name	: launchRandom
--Explain		: 牡丹タイプの花火をランダムな色、大きさで打ち上げる
--Return Value	: none
function Botan:launchRandom()
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
	local tmp = math.random(250, 350)
	local Table = {
		Color1 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]],
		Color2 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table + #Colors_Table)]],
		ExplodeTime = math.random(200, 300) / 100,
		ExplodeSpeed = NumberRange.new(tmp, tmp + 20),
	}
	local newBotan = Botan.new(Table, self)
	newBotan:launch()
end

--Method Name	: AutoSystem
--Explain		: 牡丹タイプの花火を自動でたくさん打ち上げる
--Return Value	: none
function Botan:AutoSystem()
	while true do
		for i = 1, math.random(3, 5), 1 do
			task.spawn(function()self:launchRandom()end)
		end
		task.wait(2)
	end
end

return Botan
