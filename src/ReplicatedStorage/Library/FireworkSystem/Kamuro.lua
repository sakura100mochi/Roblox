--Name		: Kamuro
--Explain	: 冠
--			AFireworkの子クラス
local AFirework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem.AFirework)
local Kamuro = setmetatable({}, {__index = AFirework})
Kamuro.__index = Kamuro

-- Type			: type
-- ExplodeTime	: 花火が開いている時間（秒）　大きいほど長くなる
-- ExplodeSpeed	: 花火が開く速度　大きいほど早く開く。冠はゆっくりがおすすめ
-- Flare_num	: 火花の数
local KamuroPrototype = {
	Type = "Kamuro",
	ExplodeTime = 4,
	ExplodeSpeed = 20,
	Flare_num = 70
}

local function makeFlarePart(particleParent : any) : Part
	local newPart = Instance.new("Part")
	newPart.Parent = particleParent
	newPart.Name = "Kamuro"
	newPart.Transparency = 1
	newPart.TopSurface = "Smooth"
	newPart.BottomSurface = "Smooth"
	newPart.formFactor = "Custom"
	newPart.Size = Vector3.new(0.1, 0.1, 0.1)
	newPart.CanCollide = false

	-- 浮力の追加
	local newBodyForce = Instance.new("BodyForce")
	newBodyForce.force = Vector3.new(0, newPart:GetMass() * 196.2 * 0.95, 0)
	newBodyForce.Parent = newPart

	return newPart
end

local function makeFlareparticles(particleParent : any, Color1 : Color3, Color2 : Color3, ExplodeTime : number) : table
	local particles = {}

	local newSparkle = Instance.new("Sparkles")
	newSparkle.SparkleColor = Color1
	newSparkle.Parent = particleParent
	table.insert(particles, newSparkle)

	local newFire = Instance.new("Fire")
	newFire.Color = Color1
	if Color2 ~= nil then
		newFire.SecondaryColor = Color2
	else
		newFire.SecondaryColor = Color1
	end
	newFire.Heat = 25
	newFire.Parent = particleParent
	table.insert(particles, newFire)

	return particles
end

local function makeFlare(self : table, FlareParent : Part)
	for i = 1, self.Flare_num, 1 do
		local newPart = self.FlareParts[i]
		newPart.Parent = FlareParent
		newPart.CFrame = FlareParent.CFrame
		local theta = math.random() * 2 * math.pi
		local phi = math.acos(2 * math.random() - 1)
		local x = math.sin(phi) * math.cos(theta)
		local y = math.sin(phi) * math.sin(theta)
		local z = math.cos(phi)
		newPart.Velocity = Vector3.new(x, y, z) * self.ExplodeSpeed

		local newParticle = self.Particles[i]
		for _, child in pairs(newParticle) do
			child.Parent = newPart
		end
	end

	task.delay(self.ExplodeTime - (self.ExplodeTime / 4), function()
		for i = 1, self.Flare_num, 1 do
			local newParticle = self.Particles[i]
			for _, child in pairs(newParticle) do
				child.Enabled = false
			end
		end
	end)
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

	self.Flare_num = Table.Flare_num or Origin.Flare_num
	self.FlareParts = {}
	self.Particles = {}

	self.FlarePart = makeFlarePart(self.Storage)
	self.Particle = makeFlareparticles(self.Storage, self.Color1, self.Color2, self.ExplodeTime)

	return self
end

--Method Name	:Kamuro
--Explain		:冠タイプの花火を打ち上げる　defaultは、錦冠
--Return Value	: none
function Kamuro:launch()
	task.spawn(function()
		for i = 1, self.Flare_num, 1 do
			table.insert(self.FlareParts, self.FlarePart:Clone())
			local tmp = {}
			for _, child in pairs(self.Particle) do
				table.insert(tmp, child:Clone())
			end
			table.insert(self.Particles, tmp)
		end
		local firework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)

		local Nobori = firework.Nobori.makeNobori(self)
		game:GetService("Debris"):AddItem(Nobori, self.ExplodeTime)

		firework.Sound.PlaySound("Explode")

		makeFlare(self, Nobori)

		task.wait(self.ExplodeTime)

		firework.Sound.PlaySound("Fizzle")

		for i = 1, self.Flare_num, 1 do
			self.FlareParts[i]:Destroy()
			for _, child in pairs(self.Particle) do
				child:Destroy()
			end
		end
		self.FlareParts = {}
		self.Particles = {}
	end)
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
			self:launchRandom()
		end
		task.wait(5)
	end
end

return Kamuro
