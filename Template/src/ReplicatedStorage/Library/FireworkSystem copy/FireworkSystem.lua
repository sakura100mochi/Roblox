-- local SoundService = game:GetService("SoundService")
-- --Name		: FireworkSystem
-- --Explain	: 計算
-- local firework = {}

-- firework.Colors = {
-- 	["Li"] = Color3.fromHex("#ff2167"),
-- 	["Na"] = Color3.fromHex("#ff5601"),
-- 	["K"] = Color3.fromHex("#ff4ed6"),
-- 	["Rb"] = Color3.fromHex("#6011b9"),
-- 	["Cs"] = Color3.fromHex("#8952ff"),
-- 	["Ca"] = Color3.fromHex("#ff8000"),
-- 	["Sr"] = Color3.fromHex("#ff2600"),
-- 	["Ba"] = Color3.fromHex("#a4fdff"),
-- 	["Cu"] = Color3.fromHex("#4bbc58")
-- }

-- local function makeBotanParticle(particleParent, Color, Lifetime, Speed)
-- 	local new = Instance.new("ParticleEmitter")
-- 	new.Parent = particleParent
-- 	new.Texture = "rbxassetid://272050333"
-- 	new.Brightness = 10
-- 	new.Rate = 0
-- 	new.Size = NumberSequence.new(2, 0)
-- 	new.SpreadAngle = Vector2.new(-360, 360)
-- 	new.LightEmission = 1
-- 	new.Drag = 20
-- 	new.Color = Color
-- 	new.Lifetime = Lifetime
-- 	new.Speed = Speed

-- 	return new
-- end

-- local function makeRingParticle(particleParent, Color, Lifetime, Speed)
-- 	local new = Instance.new("ParticleEmitter")
-- 	new.Parent = particleParent
-- 	new.Texture = "rbxassetid://272050333"
-- 	new.Brightness = 10
-- 	new.Rate = 0
-- 	new.Size = NumberSequence.new(4, 0)
-- 	new.SpreadAngle = Vector2.new(0, 360)
-- 	new.LightEmission = 1
-- 	new.Drag = 13
-- 	new.Color = Color
-- 	new.Lifetime = Lifetime
-- 	new.Speed = Speed
-- 	new.EmissionDirection = Enum.NormalId.Right

-- 	return new
-- end

-- local function makeFlarePart(particleParent)
-- 	local newPart = Instance.new("Part")
-- 	newPart.Parent = particleParent
-- 	newPart.Transparency = 1
-- 	newPart.TopSurface = "Smooth"
-- 	newPart.BottomSurface = "Smooth"
-- 	newPart.formFactor = "Custom"
-- 	newPart.Size = Vector3.new(0.4, 0.4, 0.4)
-- 	newPart.CanCollide = false
-- 	newPart.CFrame = particleParent.CFrame * CFrame.Angles(math.pi, 0, 0)
-- 	newPart.Velocity = (particleParent.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))).lookVector * 20

-- 	return newPart
-- end

-- local function makeFlarePartikles(particleParent, Color)
-- 	local partikles = {}

-- 	for i = 1, 4, 1 do
-- 		local newSparkles = Instance.new("Sparkles")
-- 		newSparkles.SparkleColor = Color
-- 		newSparkles.Parent = particleParent
-- 		table.insert(partikles, newSparkles)
-- 	end

-- 	local newFire = Instance.new("Fire")
-- 	newFire.Color = Color
-- 	newFire.SecondaryColor = Color
-- 	newFire.Heat = 25
-- 	newFire.Parent = particleParent
-- 	table.insert(partikles, newFire)

-- 	return partikles
-- end

-- local function makeFlare(particleParent, Color, Lifetime)
-- 	for i= 1, 70, 1 do
-- 		local newPart = makeFlarePart(particleParent)
-- 		local partikles = makeFlarePartikles(newPart, Color)

-- 		-- 浮力の追加
-- 		local newBodyForce = Instance.new("BodyForce")
-- 		newBodyForce.force = Vector3.new(0, newPart:GetMass() * 196.2 * 0.95, 0)
-- 		newBodyForce.Parent = newPart

-- 		game:GetService("Debris"):AddItem(newPart, Lifetime)

-- 		task.delay(Lifetime - 1, function()
-- 			for _, child in pairs(partikles) do
-- 				if child and child.Parent and child.Enabled then
-- 					child.Enabled = false
-- 				end
-- 			end
-- 		end)
-- 	end
-- end

-- local function makeFire(fireParent)
-- 	local new = Instance.new("ParticleEmitter")
-- 	new.Brightness = 4.325
-- 	new.Color = ColorSequence.new{
-- 		ColorSequenceKeypoint.new(0, Color3.fromRGB(204, 56, 56)),
-- 		ColorSequenceKeypoint.new(0.75, Color3.fromRGB(240, 106, 83)),
-- 		ColorSequenceKeypoint.new(1, Color3.fromRGB(228, 197, 85))
-- 	}
-- 	new.LightEmission = 0.45
-- 	new.Size = NumberSequence.new{
-- 		NumberSequenceKeypoint.new(0,0),
-- 		NumberSequenceKeypoint.new(0.75,0.15),
-- 		NumberSequenceKeypoint.new(1,0)
-- 	}
-- 	new.Texture = "http://www.roblox.com/asset/?id=1195495135"
-- 	new.EmissionDirection = Enum.NormalId.Bottom
-- 	new.Lifetime = NumberRange.new(0.25, 0.45)
-- 	new.Rate = 75
-- 	new.Rotation = NumberRange.new(-360, 360)
-- 	new.RotSpeed = NumberRange.new(-360, 360)
-- 	new.Speed = NumberRange.new(10, 15)
-- 	new.SpreadAngle = Vector2.new(15, 15)
-- 	new.LockedToPart = true
-- 	new.Parent = fireParent

-- 	return new
-- end

-- local function makeTrail(trailParent, Color)
-- 	local Att0 = Instance.new("Attachment")
-- 	Att0.Parent = trailParent
-- 	Att0.CFrame = CFrame.new(Att0.CFrame.X + 0.5, Att0.CFrame.Y + 0.5, Att0.CFrame.Z + 0.5)
-- 	local Att1 = Instance.new("Attachment")
-- 	Att1.Parent = trailParent
-- 	Att1.CFrame = CFrame.new(Att1.CFrame.X - 0.5, Att1.CFrame.Y - 0.5, Att1.CFrame.Z - 0.5)
-- 	local newTrail = Instance.new("Trail")
-- 	newTrail.Parent = trailParent
-- 	newTrail.Attachment0 = Att0
-- 	newTrail.Attachment1 = Att1
-- 	newTrail.Color = ColorSequence.new(Color)
-- 	newTrail.LightEmission = 1
-- 	newTrail.Lifetime = 0.25
-- 	newTrail.WidthScale = NumberSequence.new(1, 0)

-- 	return newTrail
-- end

-- local function makeToranooParticle(particleParent, Color)
-- 	local new = Instance.new("ParticleEmitter")
-- 	new.Parent = particleParent
-- 	new.Texture = "rbxassetid://272050333"
-- 	new.Brightness = 10
-- 	new.Rate = 100
-- 	new.Size = NumberSequence.new(0.5, 0)
-- 	new.SpreadAngle = Vector2.new(0, 0)
-- 	new.LightEmission = 1
-- 	new.Drag = 20
-- 	new.Color = ColorSequence.new(Color)
-- 	new.Lifetime = NumberRange.new(1, 5)
-- 	new.VelocityInheritance = 1
-- 	new.Speed = NumberRange.new(1)
-- 	new.EmissionDirection = Enum.NormalId.Bottom

-- 	return new
-- end

-- local function makeNeonPart(Start_CFrame, Color)
-- 	local new = Instance.new("Part")
-- 	new.Parent = workspace
-- 	new.Anchored = false
-- 	new.Transparency = 0
-- 	new.CanCollide = false
-- 	new.CFrame = Start_CFrame * CFrame.Angles(math.pi, 0, 0)
-- 	new.Color = Color
-- 	new.Material = Enum.Material.Neon
-- 	new.Shape = Enum.PartType.Ball
-- 	new.Anchored = false
-- 	new.Velocity = Vector3.new(math.random(-1, 1), 2, math.random(-1, 1)) * 20
-- 	new.Size = Vector3.new(0.5, 0.5, 0.5)
-- 	new.Transparency = 0.75

-- 	local light = Instance.new("PointLight")
-- 	light.Color = Color
-- 	light.Brightness = 15
-- 	light.Range = 10

-- 	return new
-- end

-- local function makeFireStarter(Start_CFrame)
-- 	local new = Instance.new("Part")
-- 	new.Parent = workspace
-- 	new.Anchored = false
-- 	new.Transparency = 1
-- 	new.CanCollide = false
-- 	new.Size = Vector3.new(1,1,1)
-- 	new.CFrame = Start_CFrame

-- 	return new
-- end

-- local function makeBodyGyro(BodyGyroParent)
-- 	local new = Instance.new("BodyGyro")
-- 	new.Parent = BodyGyroParent

-- 	return new
-- end

-- local function makeBodyVelocity(BodyVelocityParent)
-- 	local new = Instance.new("BodyVelocity")
-- 	new.Parent = BodyVelocityParent
-- 	new.Velocity = Vector3.new(math.random(0, 20), math.random(50, 60), math.random(0, 20))

-- 	return new
-- end

-- local function makeSound(str)
-- 	local new = Instance.new("Sound")
-- 	new.Parent = game:GetService("SoundService")

-- 	if str == "Launch" then
-- 		new.SoundId = "rbxassetid://551051176"
-- 	elseif str == "Explode" then
-- 		new.SoundId = "rbxassetid://4583102108"
-- 		new.Volume = 5
-- 	elseif str == "After" then
-- 		new.SoundId = "rbxassetid://100817659362842"
-- 	end

-- 	return new
-- end

-- --Function Name	:Botan
-- --Explain		:牡丹タイプの花火を打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Arguments| Color			: (Color3 or nil) 花火の色
-- --										defaultは、Ca
-- --Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
-- --										defaultは、3
-- --Arguments| ExplodeSpeed	: (NumberRange or nil) 花火の爆発するスピード
-- --										defaultは、NumberRange.new(350,370)
-- --Return Value	: none
-- function firework.Botan(Start_CFrame, Color, ExplodeTime, ExplodeSpeed)
-- 	if Start_CFrame == nil then
-- 		warn("ERROR: no argument")
-- 	end
-- 	if Color == nil or ExplodeTime == nil or ExplodeSpeed == nil then
-- 		Color = firework.Colors.Ca
-- 		ExplodeTime = 3
-- 		ExplodeSpeed = NumberRange.new(350,370)
-- 	end

-- 	local Part = makeFireStarter(Start_CFrame)
-- 	local fire = makeFire(Part)
-- 	makeBodyGyro(Part)
-- 	makeBodyVelocity(Part)

-- 	local LaunchSound = makeSound("Launch")
-- 	LaunchSound:Play()

-- 	task.wait(math.random(15, 30) / 10)

-- 	local ExplodeSound = makeSound("Explode")
-- 	ExplodeSound:Play()

-- 	fire:Destroy()
-- 	for i = 1, 5, 1 do
-- 		local particle = makeBotanParticle(Part, ColorSequence.new(Color), NumberRange.new(ExplodeTime), ExplodeSpeed)
-- 		particle:Emit(math.random(70,100))
-- 	end

-- 	local AfterSound = makeSound("After")
-- 	AfterSound:Play()

-- 	task.wait(ExplodeTime)

-- 	Part:Destroy()

-- 	task.wait(1)
-- 	LaunchSound:Destroy()
-- 	ExplodeSound:Destroy()
-- 	AfterSound:Destroy()
-- end

-- --Function Name	:AutoSystem_Botan
-- --Explain		:牡丹タイプの花火を自動でたくさん打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Return Value	: none
-- function firework.AutoSystem_Botan(Start_CFrame)
-- 	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
-- 	while true do
-- 		for i = 1, math.random(3, 5), 1 do
-- 			local Color = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ExplodeTime = math.random(200, 300) / 100
-- 			local tmp = math.random(250, 350)
-- 			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
-- 			task.spawn(function()firework.Botan(Start_CFrame, Color, ExplodeTime, ExplodeSpeed)end)
-- 		end
-- 		task.wait(2)
-- 	end
-- end

-- --Function Name	:Ring
-- --Explain		:リングタイプの花火を打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Arguments| Color			: (Color3 or nil) 花火の色
-- --										defaultは、Ca
-- --Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
-- --										defaultは、3
-- --Arguments| ExplodeSpeed	: (NumberRange or nil) 花火の爆発するスピード
-- --										defaultは、NumberRange.new(350,370)
-- --Return Value	: none
-- function firework.Ring(Start_CFrame, Color, ExplodeTime, ExplodeSpeed)
-- 	if Start_CFrame == nil then
-- 		warn("ERROR: no argument")
-- 	end
-- 	if Color == nil or ExplodeTime == nil or ExplodeSpeed == nil then
-- 		Color = firework.Colors.Ca
-- 		ExplodeTime = 3
-- 		ExplodeSpeed = NumberRange.new(350,370)
-- 	end

-- 	local Part = makeFireStarter(Start_CFrame)
-- 	local fire = makeFire(Part)
-- 	makeBodyGyro(Part)
-- 	makeBodyVelocity(Part)

-- 	local LaunchSound = makeSound("Launch")
-- 	LaunchSound:Play()

-- 	task.wait(math.random(15, 30) / 10)

-- 	local ExplodeSound = makeSound("Explode")
-- 	ExplodeSound:Play()

-- 	fire:Destroy()
-- 	for i = 1, 3, 1 do
-- 		local particle = makeRingParticle(Part, ColorSequence.new(Color), NumberRange.new(ExplodeTime), ExplodeSpeed)
-- 		particle:Emit(math.random(30, 50))
-- 	end

-- 	local AfterSound = makeSound("After")
-- 	AfterSound:Play()

-- 	task.wait(ExplodeTime)

-- 	Part:Destroy()

-- 	task.wait(1)
-- 	LaunchSound:Destroy()
-- 	ExplodeSound:Destroy()
-- 	AfterSound:Destroy()
-- end

-- --Function Name	:AutoSystem_Ring
-- --Explain		:リングタイプの花火を自動でたくさん打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Return Value	: none
-- function firework.AutoSystem_Ring(Start_CFrame)
-- 	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
-- 	while true do
-- 		for i = 1, math.random(3, 5), 1 do
-- 			local Color = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ExplodeTime = math.random(200, 300) / 100
-- 			local tmp = math.random(250, 350)
-- 			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
-- 			task.spawn(function()firework.Ring(Start_CFrame, Color, ExplodeTime, ExplodeSpeed)end)
-- 		end
-- 		task.wait(2)
-- 	end
-- end

-- --Function Name	:UFO
-- --Explain		:型物　土星・UFOタイプの花火を打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Arguments| ColorBotan			: (Color3 or nil) 牡丹の花火の色
-- --										defaultは、Ca
-- --Arguments| ColorRing			: (Color3 or nil) リングの花火の色
-- --										defaultは、Ca
-- --Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
-- --										defaultは、3
-- --Arguments| ExplodeSpeed	: (NumberRange or nil) 花火の爆発するスピード
-- --										defaultは、NumberRange.new(350,370)
-- --Return Value	: none
-- function firework.UFO(Start_CFrame, ColorBotan, ColorRing, ExplodeTime, ExplodeSpeed)
-- 	if Start_CFrame == nil then
-- 		warn("ERROR: no argument")
-- 	end
-- 	if ColorBotan == nil or ColorRing == nil or ExplodeTime == nil or ExplodeSpeed == nil then
-- 		ColorBotan = firework.Colors.Ca
-- 		ColorRing = firework.Colors.Ca
-- 		ExplodeTime = 3
-- 		ExplodeSpeed = NumberRange.new(350,370)
-- 	end

-- 	local Part = makeFireStarter(Start_CFrame)
-- 	local fire = makeFire(Part)
-- 	makeBodyGyro(Part)
-- 	makeBodyVelocity(Part)

-- 	local LaunchSound = makeSound("Launch")
-- 	LaunchSound:Play()

-- 	task.wait(math.random(15, 30) / 10)

-- 	local ExplodeSound = makeSound("Explode")
-- 	ExplodeSound:Play()

-- 	fire:Destroy()
-- 	for i = 1, 3, 1 do
-- 		local particle = makeRingParticle(Part, ColorSequence.new(ColorRing), NumberRange.new(ExplodeTime), NumberRange.new(ExplodeSpeed.Min + 20, ExplodeSpeed.Max + 20))
-- 		particle:Emit(math.random(30, 50))
-- 	end
-- 	for i = 1, 5, 1 do
-- 		local particle = makeBotanParticle(Part, ColorSequence.new(ColorBotan), NumberRange.new(ExplodeTime), ExplodeSpeed)
-- 		particle:Emit(math.random(70,100))
-- 	end

-- 	local AfterSound = makeSound("After")
-- 	AfterSound:Play()

-- 	task.wait(ExplodeTime)

-- 	Part:Destroy()

-- 	task.wait(1)
-- 	LaunchSound:Destroy()
-- 	ExplodeSound:Destroy()
-- 	AfterSound:Destroy()
-- end

-- --Function Name	:AutoSystem_UFO
-- --Explain		:型物　土星・UFOタイプの花火を自動でたくさん打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Return Value	: none
-- function firework.AutoSystem_UFO(Start_CFrame)
-- 	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
-- 	while true do
-- 		for i = 1, math.random(1, 2), 1 do
-- 			local ColorBotan = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ColorRing = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ExplodeTime = math.random(200, 300) / 100
-- 			local tmp = math.random(250, 350)
-- 			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
-- 			task.spawn(function()firework.UFO(Start_CFrame, ColorBotan, ColorRing, ExplodeTime, ExplodeSpeed)end)
-- 		end
-- 		task.wait(2)
-- 	end
-- end

-- --Function Name	:Kamuro
-- --Explain		:冠タイプの花火を打ち上げる　defaultは、錦冠
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Arguments| Color			: (Color3 or nil) 花火の色
-- --										defaultは、Ca
-- --Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
-- --										defaultは、2
-- --Return Value	: none
-- function firework.Kamuro(Start_CFrame, Color, ExplodeTime)
-- 	if Start_CFrame == nil then
-- 		warn("ERROR: no argument")
-- 	end
-- 	if Color == nil or ExplodeTime == nil then
-- 		Color = firework.Colors.Ca
-- 		ExplodeTime = 2
-- 	end

-- 	local Part = makeFireStarter(Start_CFrame)
-- 	local fire = makeFire(Part)
-- 	makeBodyGyro(Part)
-- 	makeBodyVelocity(Part)

-- 	local LaunchSound = makeSound("Launch")
-- 	LaunchSound:Play()

-- 	task.wait(math.random(15, 30) / 10)

-- 	local ExplodeSound = makeSound("Explode")
-- 	ExplodeSound:Play()

-- 	fire:Destroy()
-- 	makeFlare(Part, Color, ExplodeTime)

-- 	local AfterSound = makeSound("After")
-- 	AfterSound:Play()

-- 	task.wait(ExplodeTime)

-- 	Part:Destroy()

-- 	task.wait(1)
-- 	LaunchSound:Destroy()
-- 	ExplodeSound:Destroy()
-- 	AfterSound:Destroy()
-- end

-- --Function Name	:AutoSystem_Kamuro
-- --Explain		:冠タイプの花火を自動でたくさん打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Return Value	: none
-- function firework.AutoSystem_Kamuro(Start_CFrame)
-- 	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
-- 	while true do
-- 		for i = 1, math.random(3, 5), 1 do
-- 			local Color = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ExplodeTime = math.random(150, 300) / 100
-- 			task.spawn(function()firework.Kamuro(Start_CFrame, Color, ExplodeTime)end)
-- 		end
-- 		task.wait(2)
-- 	end
-- end

-- --Function Name	:Tranoo
-- --Explain		:虎の尾タイプの花火を打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Arguments| Color			: (Color3 or nil) 花火の色
-- --										defaultは、Ca
-- --Arguments| ExplodeTime	: (Number or nil) 花火の爆発する時間
-- --										defaultは、2
-- --Return Value	: none
-- function firework.Toranoo(Start_CFrame, Color, ExplodeTime)
-- 	if Start_CFrame == nil then
-- 		warn("ERROR: no argument")
-- 	end
-- 	if Color == nil or ExplodeTime == nil then
-- 		Color = firework.Colors.Ca
-- 		ExplodeTime = 2
-- 	end

-- 	local Part = makeNeonPart(Start_CFrame, Color)
-- 	-- makeTrail(Part, Color)
-- 	-- makeTrail(Part, Color)
-- 	-- makeTrail(Part, Color)
-- 	local particle = makeToranooParticle(Part, Color)
-- 	particle:Emit(100)
-- 	-- local partikes = makeFlarePartikles(Part, Color)
-- 	-- task.delay(ExplodeTime, function()
-- 	-- 	for _, child in pairs(partikes) do
-- 	-- 		if child and child.Parent and child.Enabled then
-- 	-- 			child.Enabled = false
-- 	-- 		end
-- 	-- 	end
-- 	-- end)

-- 	-- 浮力の追加
-- 	local newBodyForce = Instance.new("BodyForce")
-- 	newBodyForce.force = Vector3.new(0, Part:GetMass() * 196.2 * 0.95, 0)
-- 	newBodyForce.Parent = Part

-- 	-- local LaunchSound = makeSound("Explode")
-- 	-- LaunchSound:Play()

-- 	task.wait(ExplodeTime)
-- 	Part:Destroy()

-- 	-- task.wait(1)
-- 	-- LaunchSound:Destroy()
-- end

-- --Function Name	:AutoSystem_Toranoo
-- --Explain		:虎の尾タイプの花火を自動でたくさん打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Return Value	: none
-- function firework.AutoSystem_Toranoo(Start_CFrame)
-- 	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
-- 	while true do
-- 		for i = 1, math.random(3, 5), 1 do
-- 			local Color = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ExplodeTime = math.random(150, 300) / 100
-- 			task.spawn(function()firework.Toranoo(Start_CFrame, Color, ExplodeTime)end)
-- 		end
-- 		task.wait(2)
-- 	end
-- end

-- --Function Name	:AutoSystem_All
-- --Explain		:全種類のタイプの花火を自動でたくさん打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Return Value	: none
-- function firework.AutoSystem_All(Start_CFrame)
-- 	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
-- 	while true do
-- 		for i = 1, math.random(1, 3), 1 do
-- 			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local Color2 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ExplodeTime = math.random(150, 300) / 100
-- 			local tmp = math.random(250, 350)
-- 			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
-- 			local ft_table = {
-- 				function()firework.Botan(Start_CFrame, Color1, ExplodeTime, ExplodeSpeed)end,
-- 				function()firework.Ring(Start_CFrame, Color1, ExplodeTime, ExplodeSpeed)end,
-- 				function()firework.UFO(Start_CFrame, Color1, Color2, ExplodeTime, ExplodeSpeed)end,
-- 				function()firework.Kamuro(Start_CFrame, Color1, ExplodeTime)end
-- 			}
-- 			task.spawn(function()ft_table[math.random(1, #ft_table)]()end)
-- 		end
-- 		task.wait(2)
-- 	end
-- end

-- --Function Name	:AutoSystem_1
-- --Explain		:全種類のタイプの花火を自動でたくさん打ち上げる
-- --Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
-- --Return Value	: none
-- function firework.AutoSystem_1(Start_CFrame)
-- 	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al", "Mg"}
-- 	while true do
-- 		for i = 1, math.random(1, 3), 1 do
-- 			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ExplodeTime = math.random(150, 300) / 100
-- 			local tmp = math.random(250, 350)
-- 			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
-- 			task.spawn(function()firework.Botan(Start_CFrame, Color1, ExplodeTime, ExplodeSpeed)end)
-- 		end
-- 		task.wait(2)
-- 		for i = 1, math.random(1, 3), 1 do
-- 			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ExplodeTime = math.random(150, 300) / 100
-- 			local tmp = math.random(250, 350)
-- 			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
-- 			task.spawn(function()firework.Ring(Start_CFrame, Color1, ExplodeTime, ExplodeSpeed)end)
-- 		end
-- 		task.wait(2)
-- 		for i = 1, math.random(1, 3), 1 do
-- 			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local Color2 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ExplodeTime = math.random(150, 300) / 100
-- 			local tmp = math.random(250, 350)
-- 			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
-- 			task.spawn(function()firework.UFO(Start_CFrame, Color1, Color2, ExplodeTime, ExplodeSpeed)end)
-- 		end
-- 		task.wait(2)
-- 		for i = 1, math.random(1, 3), 1 do
-- 			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
-- 			local ExplodeTime = math.random(150, 300) / 100
-- 			local tmp = math.random(250, 350)
-- 			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)

-- 			task.spawn(function()firework.Kamuro(Start_CFrame, Color1, ExplodeTime)end)
-- 		end
-- 		task.wait(2)
-- 	end
-- end

-- return firework

-- --*****Please put part and clickdetector at workspace and put this*****--

-- -- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- -- local firework = lib.firework

-- -- local function onMouseClicked()
-- -- 	firework.AutoSystem_All(script.Parent.CFrame)
-- -- end

-- -- script.Parent.ClickDetector.MouseClick:Connect(onMouseClicked)

-- --***********************************************************--
