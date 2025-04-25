--Name		: Kamuro
--Explain	: 冠
--			AFireworkの子クラス
local AFirework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"].AFirework)
local Kamuro = setmetatable({}, {__index = AFirework})
Kamuro.__index = Kamuro

local KamuroPrototype = {
	Type = "Kamuro",
	ExplodeTime = 4,
	ExplodeSpeed = 20
}

local function makeFlarePart(particleParent, Table)
	local newPart = Instance.new("Part")
	newPart.Parent = particleParent
	newPart.Name = "Kamuro"
	newPart.Transparency = 1
	newPart.TopSurface = "Smooth"
	newPart.BottomSurface = "Smooth"
	newPart.formFactor = "Custom"
	newPart.Size = Vector3.new(0.4, 0.4, 0.4)
	newPart.CanCollide = false
	newPart.CFrame = particleParent.CFrame * CFrame.Angles(math.pi, 0, 0)
	newPart.Velocity = (particleParent.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))).lookVector * Table.ExplodeSpeed
	-- 浮力の追加
	local newBodyForce = Instance.new("BodyForce")
	newBodyForce.force = Vector3.new(0, newPart:GetMass() * 196.2 * 0.95, 0)
	newBodyForce.Parent = newPart

	return newPart
end

local function makeFlareparticles(particleParent, Table)
	local particles = {}

	for i = 1, 4, 1 do
		local newSparkle = Instance.new("Sparkles")
		newSparkle.SparkleColor = Table.Color1
		newSparkle.Parent = particleParent
		task.delay(Table.ExplodeTime - (Table.ExplodeTime / 4), function()
			newSparkle.Enabled = false
		end)
		table.insert(particles, newSparkle)
	end

	local newFire = Instance.new("Fire")
	newFire.Color = Table.Color1
	if Table.Color2 ~= nil then
		newFire.SecondaryColor = Table.Color2
	else
		newFire.SecondaryColor = Table.Color1
	end
	newFire.Heat = 25
	newFire.Parent = particleParent
	task.delay(Table.ExplodeTime - (Table.ExplodeTime / 4), function()
		newFire.Enabled = false
	end)
	table.insert(particles, newFire)

	return particles
end

local function makeFlare(particleParent, Table)
	for i= 1, 70, 1 do
		local newPart = makeFlarePart(particleParent, Table)
		makeFlareparticles(newPart, Table)
	end
end

--Function Name	: new
--Explain		: 冠の花火をインスタンス化する
--Arguments| Table	: (table)Tableの値を設定する。値がない場合はPrototypeで指定されているデフォルト値にする
--Return Value	: (table) 設定した後のtable
function Kamuro.new(Table, Origin)
	if Origin == nil then
		Origin = KamuroPrototype
	end
	local self = AFirework.new(Origin, Table)
	setmetatable(self, Kamuro)

	return self
end

--Method Name	:Kamuro
--Explain		:冠タイプの花火を打ち上げる　defaultは、錦冠
--Return Value	: none
function Kamuro:launch()
	local firework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"])

	local Nobori = firework.Nobori.makeNobori(self)
	game:GetService("Debris"):AddItem(Nobori, self.ExplodeTime)

	firework.Sound.PlaySound("Explode")

	makeFlare(Nobori, self)

	task.wait(self.ExplodeTime)

	firework.Sound.PlaySound("Fizzle")
end

--Method Name	: launchRandom
--Explain		: 冠タイプの花火をランダムな色、大きさで打ち上げる
--Return Value	: none
function Kamuro:launchRandom()
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
	local Table = {
		Color1 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table)]],
		Color2 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table + #Colors_Table)]],
		ExplodeTime = math.random(300, 450) / 100
	}
	local newKamuro = Kamuro.new(Table, self)
	newKamuro:launch()
end

--Method Name	:AutoSystem
--Explain		:冠タイプの花火を自動でたくさん打ち上げる
--Return Value	: none
function Kamuro:AutoSystem()
	while true do
		for i = 1, math.random(2, 3), 1 do
			task.spawn(function()self:launchRandom()end)
		end
		task.wait(5)
	end
end

return Kamuro
