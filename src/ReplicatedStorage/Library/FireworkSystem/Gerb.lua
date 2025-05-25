--Name		: Gerb
--Explain	: ジャーブ　噴水のように火の粉を噴き上げる花火
--			AFireworkの子クラス
local AFirework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem.AFirework)
local Gerb = setmetatable({}, {__index = AFirework})
Gerb.__index = Gerb

local GerbPrototype = {
	Parent = workspace:FindFirstChild("SpawnLocation"),
	Type = "Gerb",
	Color1 = AFirework.Colors.C,
	ExplodeSpeed = 60,
	ExplodeTime = 5,
}

local function makeGerbParticle(GerbParent, Color)
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
	newGerb.Texture = "rbxassetid://298984512"
	newGerb.Lifetime = NumberRange.new(0.1, 0.2)
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
	newBodyForce.force = Vector3.new(0, newPart:GetMass() * 196.2 * (math.random(30, 90) / 100), 0)
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
	newParticle.Enabled = false
	task.delay(0.15, function()
		newParticle.Enabled = true
		task.wait(0.55)
		newParticle.Enabled = false
		task.wait(1.3)
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

	Table = Table or {}

	self.FlareParts = {}
	self.GerbParticles = {}

	local GerbParticle = makeGerbParticle(self.Storage, self.Color1)
	for i = 0, 600, 1 do
		table.insert(self.FlareParts, makeFlarePart(self.Storage))
		table.insert(self.GerbParticles, GerbParticle:Clone())
	end

	return self
end

--Method Name	: launch
--Explain		: ジャーブタイプの花火を打ち上げる
--Return Value	: none
function Gerb:launch()
	local firework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)

	firework.Sound.PlaySound("SmallExplode")

	local Fountain = firework.Sound.PlaySound("Fountain")
	game:GetService("Debris"):AddItem(Fountain, self.ExplodeTime + 1)

	local num = 0
	for i = 0, self.ExplodeTime, 0.01 do
		for j = 1, 3, 1 do
			makeFlare(self, self.GerbParticles, num % 600 + 1)
			num = num + 1
		end
		task.wait(0.01)
	end
end

--Method Name	: launchRandom
--Explain		: ジャーブタイプの花火をランダムな色、大きさで打ち上げる
--Return Value	: none
function Gerb:launchRandom()
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
	local Table = {
		Color1 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]],
		Color2 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table + #Colors_Table)]],
		Color3 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]],
		Color4 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]],
		Color5 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
	}
	local newGerb = Gerb.new(Table, self)
	newGerb:launch()
end

--Method Name	: AutoSystem
--Explain		: ジャーブタイプの花火を自動でたくさん打ち上げる
--Return Value	: none
function Gerb:AutoSystem()
	while true do
		task.spawn(function()self:launchRandom()end)
		task.wait(3)
	end
end

--Method Name	: fan
--Explain		: ジャーブタイプの花火を扇型に打ち上げる
--Return Value	: none
function Gerb:fan()
	local NUM = 13

	if not self.Parent:IsA("BasePart") and not self.Parent:IsA("Attachment") then
		error("ERROR: Parent must be BasePart or Attachment [FireworkSystem/Gerb/fan]")
	end

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
