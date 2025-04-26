--Name		: Kiku
--Explain	: 菊
--			AFireworkの子クラス
local AFirework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem.AFirework)
local Kiku = setmetatable({}, {__index = AFirework})
Kiku.__index = Kiku

local KikuPrototype = {
	Type = "Kiku",
	NoboriTime = math.random(30, 50) / 10,
	ExplodeTime = 2.5,
	ExplodeSpeed = 125,
	Flare_num = 300
}

local function makeKikuParticle(particleParent, Color, ExplodeTime)
	local new = Instance.new("ParticleEmitter")
	new.Parent = particleParent
	new.Texture = "rbxassetid://272050333"
	new.Brightness = 10
	new.Rate = 0
	new.Size = NumberSequence.new(4, 0)
	new.SpreadAngle = Vector2.new(0, 0)
	new.LightEmission = 1
	new.Drag = 5
	new.Color = Color
	new.Lifetime = NumberRange.new(ExplodeTime / 2 + 1)
	new.Speed = NumberRange.new(0)
	new.VelocityInheritance = 0.5

	return new
end

local function makeFlarePart(particleParent, ExplodeSpeed)
	local newPart = Instance.new("Part")
	newPart.Parent = particleParent
	newPart.Transparency = 1
	newPart.TopSurface = "Smooth"
	newPart.BottomSurface = "Smooth"
	newPart.formFactor = "Custom"
	newPart.Size = Vector3.new(0.4, 0.4, 0.4)
	newPart.CanCollide = false
	newPart.CFrame = particleParent.CFrame
	local theta = math.random() * 2 * math.pi
	local phi = math.acos(2 * math.random() - 1)
	local x = math.sin(phi) * math.cos(theta)
	local y = math.sin(phi) * math.sin(theta)
	local z = math.cos(phi)
	newPart.Velocity = Vector3.new(x, y, z) * ExplodeSpeed

	-- 浮力の追加
	local newBodyForce = Instance.new("BodyForce")
	newBodyForce.force = Vector3.new(0, newPart:GetMass() * 196.2 * 0.99, 0)
	newBodyForce.Parent = newPart

	return newPart
end

local function makeFireParticles(particleParent)
	local fire = Instance.new("ParticleEmitter")
	fire.Color = ColorSequence.new(AFirework.Colors.C)
	fire.Brightness = 10
	fire.LightEmission = 1
	fire.Size = NumberSequence.new(2, 0)
	fire.Texture = "rbxassetid://272050333"
	fire.Parent = particleParent
	fire.Drag = 0
	fire.Lifetime = NumberRange.new(1, 1.5)
	fire.Speed = NumberRange.new(1.25, 2.5)
	fire.SpreadAngle = Vector2.new(5, 5)
	fire.Rate = 200
	fire.VelocityInheritance = 0.1

	return fire
end

local function makeFlare(particleParent, Flare_num, ExplodeTime, ExplodeSpeed, firstColor, secondColor)
	for i= 1, Flare_num, 1 do
		local newPart = makeFlarePart(particleParent, ExplodeSpeed)
		local newFire = makeFireParticles(newPart)

		task.delay(ExplodeTime - (ExplodeTime / 2), function()
			newFire.Enabled = false
			if firstColor ~= nil then
				local KikuColor = ColorSequence.new(firstColor)
				if secondColor ~= nil then
					KikuColor = ColorSequence.new{
						ColorSequenceKeypoint.new(0, firstColor),
						ColorSequenceKeypoint.new(0.4, secondColor),
						ColorSequenceKeypoint.new(1, secondColor)
					}
				end
				local particle = makeKikuParticle(newPart, KikuColor, ExplodeTime)
				particle:Emit(1)
			end
		end)
	end
end

--Function Name	: new
--Explain		: 菊の花火をインスタンス化する
--Arguments| Table	: (table)Tableの値を設定する。値がない場合はPrototypeで指定されているデフォルト値にする
--Return Value	: (table) 設定した後のtable
function Kiku.new(Table, Origin)
	if Origin == nil then
		Origin = KikuPrototype
	end
	local self = AFirework.new(Origin, Table)
	setmetatable(self, Kiku)

	Table = Table or {}
	self.Flare_num = Table.Flare_num or KikuPrototype.Flare_num

	return self
end

--Method Name	: launch
--Explain		: 菊タイプの花火を打ち上げる
--Return Value	: none
function Kiku:launch()
	local firework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)

	local Nobori = firework.Nobori.makeNobori(self);
	game:GetService("Debris"):AddItem(Nobori, self.ExplodeTime + 5)

	firework.Sound.PlaySound("Explode")

	makeFlare(Nobori, self.Flare_num, self.ExplodeTime, self.ExplodeSpeed, self.Color2, self.Color3)

	firework.Sound.PlaySound("After")
end

--Method Name	: launchRandom
--Explain		: 菊タイプの花火をランダムな色、大きさで打ち上げる
--Return Value	: none
function Kiku:launchRandom()
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
	local Table = {
		Color2 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table + #Colors_Table / 2)]],
		Color3 = AFirework.Colors[Colors_Table[math.random(1, #Colors_Table + #Colors_Table)]],
		ExplodeTime = math.random(200, 300) / 100,
		ExplodeSpeed = math.random(1200, 1400) / 10,
	}
	local newKiku = Kiku.new(Table, self)
	newKiku:launch()
end

--Method Name	: AutoSystem
--Explain		: 菊タイプの花火を自動でたくさん打ち上げる
--Return Value	: none
function Kiku:AutoSystem()
	while true do
		task.spawn(function()self:launchRandom()end)
		task.wait(4)
	end
end

--Method Name	: launchDouble
--Explain		: 菊タイプの花火を同時に2個打ち上げる
--Return Value	: none
function Kiku:launchDouble()
	local firework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)

	local Nobori = firework.Nobori.makeNobori(self);
	game:GetService("Debris"):AddItem(Nobori, self.ExplodeTime + 5)

	firework.Sound.PlaySound("Explode")

	makeFlare(Nobori, self.Flare_num, self.ExplodeTime, self.ExplodeSpeed, self.Color2, self.Color3)
	makeFlare(Nobori, self.Flare_num, self.ExplodeTime / 2, self.ExplodeSpeed, self.Color4, self.Color5)

	firework.Sound.PlaySound("After")
end

return Kiku
