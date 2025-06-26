--Name		: Gerb
--Explain	: ジャーブ　噴水のように火の粉を噴き上げる花火
--			AFireworkの子クラス
local AFirework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem.AFirework)
local Gerb = setmetatable({}, {__index = AFirework})
Gerb.__index = Gerb

-- Parent		: 発射する場所
-- Type			: type
-- Color1		: 花火の色
-- ExplodeSpeed	: 打ち上げ速度（火花が上に上がる速度）　大きいほど速くなる
-- ExplodeTime	: 打ち上げている時間（秒）
-- Interval		: 火花を打ち上げる間隔（秒）　小さいほど火花が多く綺麗だが、その分重くなる。複数打ち上げるなら0.05推奨
local GerbPrototype = {
	Parent = workspace:FindFirstChild("SpawnLocation"),
	Type = "Gerb",
	Color1 = AFirework.Colors.C,
	ExplodeSpeed = 60,
	ExplodeTime = 0.7,
	Interval = 0.01
}

local function makeGerbParticle(GerbParent, Color)
	local newGerb = Instance.new("ParticleEmitter")
	newGerb.Parent = GerbParent
	newGerb.Color = ColorSequence.new(Color)
	newGerb.LightEmission = 1
	newGerb.LightInfluence = 1
	newGerb.Orientation = Enum.ParticleOrientation.FacingCamera
	newGerb.Size = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 2),
		NumberSequenceKeypoint.new(1, 2)
	}
	newGerb.Squash = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(0.2, 0),
		NumberSequenceKeypoint.new(1, 0)
	}
	newGerb.Texture = "rbxassetid://298984512"
	newGerb.Lifetime = NumberRange.new(0.1, 0.5)
	newGerb.Rate = 100
	newGerb.Drag = 10
	newGerb.Enabled = true
	newGerb.Brightness = 10

	return newGerb
end

local function makeFlarePart(particleParent : any) : Part
	local newPart = Instance.new("Part")
	newPart.Parent = particleParent
	newPart.Transparency = 1
	newPart.Size = Vector3.new(0.1, 0.1, 0.1)
	newPart.CanCollide = false

	-- 浮力の追加
	local newBodyForce = Instance.new("BodyForce")
	newBodyForce.force = Vector3.new(0, newPart:GetMass() * 196.2 * (math.random(50, 90) / 100), 0)
	newBodyForce.Parent = newPart

	return newPart
end

local function makeFlare(self : table, GerbParticles : table, index : number)
	local newPart = self.FlareParts[index]
	newPart.CFrame = self.Parent.CFrame
	local theta = math.random() * 2 * math.pi
	local phi = math.random() * math.rad(10)
	local x = math.sin(phi) * math.cos(theta)
	local y = math.cos(phi)
	local z = math.sin(phi) * math.sin(theta)
	newPart.Velocity = Vector3.new(x, y, z) * self.ExplodeSpeed
	newPart.Parent = self.Parent

	local newParticle = GerbParticles[index]
	newParticle.Parent = newPart
	newParticle.Enabled = true
	task.delay(0.7, function()
		newParticle.Enabled = false
		task.wait(0.3)
		newPart.Parent = nil
		newPart.Velocity = Vector3.new(0, 0, 0)
		newPart.CFrame = self.Parent.CFrame
	end)
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
	self.Interval = Table.Interval or Origin.Interval
	self.Flare_num = 1 / self.Interval * 3

	Table = Table or {}

	self.FlareParts = {}
	self.GerbParticles = {}

	local GerbParticle = makeGerbParticle(self.Storage, self.Color1)
	for i = 0, self.Flare_num, 1 do
		table.insert(self.FlareParts, makeFlarePart(self.Storage))
		table.insert(self.GerbParticles, GerbParticle:Clone())
	end

	if not self.Parent:IsA("BasePart") and not self.Parent:IsA("Attachment") then
		error("ERROR: Parent must be have a CFrame property [FireworkSystem/Gerb.new]")
	end

	return self
end

--Method Name	: launch
--Explain		: ジャーブタイプの花火を打ち上げる
--Return Value	: none
function Gerb:launch()
	task.spawn(function()
		local firework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)

		firework.Sound.PlaySound("SmallExplode")

		local Fountain = firework.Sound.PlaySound("Fountain")
		game:GetService("Debris"):AddItem(Fountain, self.ExplodeTime + 1)

		local num = 0
		for i = 0, self.ExplodeTime, self.Interval do
			for j = 1, 3, 1 do
				makeFlare(self, self.GerbParticles, num % self.Flare_num + 1)
				num = num + 1
			end
			task.wait(self.Interval)
		end
		for i = 1, #self.GerbParticles, 1 do
			self.GerbParticles[i].Enabled = false
		end
	end)
end

--Method Name	: launchRandom
--Explain		: ジャーブタイプの花火をランダムな色、大きさで打ち上げる
--Return Value	: none
function Gerb:launchRandom()
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
	local Table = {
		Color1 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]],
	}
	local newGerb = Gerb.new(Table, self)
	newGerb:launch()
end

--Method Name	: AutoSystem
--Explain		: ジャーブタイプの花火を自動でたくさん打ち上げる
--Return Value	: none
function Gerb:AutoSystem()
	while true do
		self:launchRandom()
		task.wait(3)
	end
end

--Method Name	: fan
--Explain		: ジャーブタイプの花火を扇型に打ち上げる
--Return Value	: none
-- function Gerb:fan()
-- 	local NUM = 13

-- 	if not self.Parent:IsA("BasePart") and not self.Parent:IsA("Attachment") then
-- 		error("ERROR: Parent must be BasePart or Attachment [FireworkSystem/Gerb/fan]")
-- 	end

-- 	for i = 0, NUM, 1 do
-- 		task.spawn(function()
-- 			local t = (i - ((NUM - 1) / 2)) / ((NUM - 1) / 2)
-- 			local angle = t * 60
-- 			local attachment = Instance.new("Attachment")
-- 			attachment.Parent = self.Parent
-- 			attachment.Rotation = Vector3.new(0, 0, angle)
-- 			game:GetService("Debris"):AddItem(attachment, self.ExplodeTime + 3)

-- 			local Table = {
-- 				Parent = attachment
-- 			}
-- 			local newGerb = Gerb.new(Table, self)
-- 			newGerb:launch()
-- 		end)
-- 	end
-- end


return Gerb
