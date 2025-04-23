--Name		: Gerb
--Explain	: ジャーブ　噴水のように火の粉を噴き上げる花火
--			AFireworkの子クラス
local AFirework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"].AFirework)
local Gerb = setmetatable({}, {__index = AFirework})
Gerb.__index = Gerb

local GerbPrototype = {
	Type = "Gerb",
	Color1 = AFirework.Colors.C,
	Color2 = AFirework.Colors.C,
	Color3 = AFirework.Colors.C,
	Color4 = AFirework.Colors.C,
	Color5 = AFirework.Colors.C
}

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

--Function Name	: new
--Explain		: ジャーブの花火をインスタンス化する
--Arguments| Table	: (table)Tableの値を設定する。値がない場合はPrototypeで指定されているデフォルト値にする
--Return Value	: (table) 設定した後のtable
function Gerb.new(Table, Origin)
	if Origin == nil then
		Origin = GerbPrototype
	end
	local self = AFirework.new(Origin, Table)
	setmetatable(self, Gerb)

	return self
end

--Method Name	: launch
--Explain		: ジャーブタイプの花火を打ち上げる
--Return Value	: none
function Gerb:launch()
	local firework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"])

	firework.Sound.PlaySound("SmallExplode")

	local particle1 = makeGerbParticle(self.Parent, self.Color1, NumberRange.new(5, 60), Vector2.new(5, 5))
	particle1:Emit(30)
	task.wait(0.01)
	local particle2 = makeGerbParticle(self.Parent, self.Color2, NumberRange.new(40, 110), Vector2.new(5, 5))
	particle2:Emit(40)
	task.wait(0.01)
	local particle3 = makeGerbParticle(self.Parent, self.Color3, NumberRange.new(90, 160), Vector2.new(7, 7))
	particle3:Emit(40)
	task.wait(0.01)
	local particle4 = makeGerbParticle(self.Parent, self.Color4, NumberRange.new(140, 210), Vector2.new(7, 7))
	particle4:Emit(40)
	task.wait(0.01)
	local particle5 = makeGerbParticle(self.Parent, self.Color5, NumberRange.new(190, 250), Vector2.new(6, 6))
	particle5:Emit(40)
end

--Method Name	: AutoSystem
--Explain		: ジャーブタイプの花火を自動でたくさん打ち上げる
--Return Value	: none
function Gerb:AutoSystem()
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
	while true do
		local Table = {
			Color1 = ColorSequence.new(AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]]),
			Color2 = ColorSequence.new(AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]]),
			Color3 = ColorSequence.new(AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]]),
			Color4 = ColorSequence.new(AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]]),
			Color5 = ColorSequence.new(AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]])
		}
		local newGerb = Gerb.new(Table)
		task.spawn(function()newGerb:launch()end)
		task.wait(3)
	end
end

--Method Name	: fan
--Explain		: ジャーブタイプの花火を扇型に打ち上げる
--Return Value	: none
function Gerb:fan()
	local firework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"])
	local NUM = 13

	for i = 0, NUM, 1 do
		task.spawn(function()

		local t = (i - ((NUM - 1) / 2)) / ((NUM - 1) / 2)
		local angle = t * 60
		local attachment = Instance.new("Attachment")
		attachment.Parent = self.Parent
		attachment.Rotation = Vector3.new(0, 0, angle)
		game:GetService("Debris"):AddItem(attachment, self.ExplodeTime + 3)

		local Table = {
			Parent = attachment
		}
		local newGerb = Gerb.new(Table, self)
		newGerb:launch()
		end)
	end
end


return Gerb
