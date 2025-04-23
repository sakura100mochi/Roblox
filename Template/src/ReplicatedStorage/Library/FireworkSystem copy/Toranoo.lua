--Name		: Toranoo
--Explain	: 虎の尾
--			AFireworkの子クラス
local AFirework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"].AFirework)
local Toranoo = setmetatable({}, {__index = AFirework})
Toranoo.__index = Toranoo

local ToranooPrototype = {
	Type = "Toranoo",
	Color1 = AFirework.Colors.Al,
	ExplodeTime = 2,
	ExplodeSpeed = 20,
	Velocity = Vector3.new(math.random(-1, 1), 2, math.random(-1, 1))
}

local function makeFlareparticles(particleParent, Color, ExplodeTime)
	local particles = {}

	for i = 1, 10, 1 do
		local newSparkles = Instance.new("Sparkles")
		newSparkles.SparkleColor = Color
		newSparkles.Parent = particleParent
		table.insert(particles, newSparkles)
	end

	for i = 1, 20, 1 do
		local newFire = Instance.new("Fire")
		newFire.Color = Color
		newFire.SecondaryColor = Color
		newFire.Heat = 25
		newFire.Size = 3
		newFire.Parent = particleParent
		table.insert(particles, newFire)
		task.wait(0.001)
	end

	task.delay(ExplodeTime, function()
		for _, child in pairs(particles) do
			if child and child.Parent and child.Enabled then
				child.Enabled = false
			end
		end
	end)
end

local function makeNeonPart(Table)
	local new = Instance.new("Part")
	new.Parent = workspace
	new.Anchored = false
	new.Transparency = 0
	new.CanCollide = false
	new.CFrame = Table.Start_CFrame * CFrame.Angles(math.pi, 0, 0)
	new.Color = Table.Color1
	new.Material = Enum.Material.Neon
	new.Shape = Enum.PartType.Ball
	new.Anchored = false
	new.Velocity = Table.Velocity * Table.ExplodeSpeed
	new.Size = Vector3.new(0.5, 0.5, 0.5)
	new.Transparency = 0.75

	local light = Instance.new("PointLight")
	light.Color = Table.Color1
	light.Brightness = 15
	light.Range = 10

	task.delay(Table.ExplodeTime, function()
		new.Transparency = 1
	end)
	-- 浮力の追加
	local newBodyForce = Instance.new("BodyForce")
	newBodyForce.force = Vector3.new(0, new:GetMass() * 196.2 * 0.95, 0)
	newBodyForce.Parent = new

	return new
end

--Function Name	: new
--Explain		: 虎の尾の花火をインスタンス化する
--Arguments| Table	: (table)Tableの値を設定する。値がない場合はPrototypeで指定されているデフォルト値にする
--Return Value	: (table) 設定した後のtable
function Toranoo.new(Table, Origin)
	if Origin == nil then
		Origin = ToranooPrototype
	end
	local self = AFirework.new(Origin, Table)
	setmetatable(self, Toranoo)

	Table = Table or {}
	self.Velocity = Table.Velocity or Origin.Velocity

	return self
end

--Method Name	: launch
--Explain		: 虎の尾タイプの花火を打ち上げる
--Return Value	: none
function Toranoo:launch()
	local firework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"])

	firework.Sound.PlaySound("SmallExplode")

	local Part = makeNeonPart(self)
	game:GetService("Debris"):AddItem(Part, self.ExplodeTime + 1)
	makeFlareparticles(Part, self.Color1, self.ExplodeTime)

	task.wait(self.ExplodeTime - 0.8)

	firework.Sound.PlaySound("Fizzle")
end

--Method Name	: AutoSystem
--Explain		: 虎の尾タイプの花火を自動でたくさん打ち上げる
--Return Value	: none
function Toranoo:AutoSystem()
	while true do
		for i = 1, math.random(3, 5), 1 do
			local Table = {
				ExplodeTime = math.random(150, 300) / 100
			}
			local newToranoo = Toranoo.new(Table)
			task.spawn(function()newToranoo:launch()end)
		end
		task.wait(2)
	end
end

--Method Name	: fan
--Explain		: 虎の尾タイプの花火を扇型に打ち上げる
--Return Value	: none
function Toranoo:fan()
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	local NUM = 13

	for i = 0, NUM, 1 do
		local t = (i - ((NUM - 1) / 2)) / ((NUM - 1) / 2)
		local angle = t * math.rad(60)
		local Speed = 40
		local minSpeed = Speed - 5
		local maxSpeed = Speed
		local factor = 1 - math.abs(t) ^ 1.5 -- 中心：1、端：0.18くらい
		local speed = minSpeed + (maxSpeed - minSpeed) * factor
		local Table = {
			ExplodeTime = 1.5,
			ExplodeSpeed = speed,
			Velocity = Vector3.new(math.sin(angle), math.cos(angle), 0)
		}
		local newToranoo = Toranoo.new(Table, self)
		task.spawn(function()newToranoo:launch()end)
	end
end

return Toranoo
