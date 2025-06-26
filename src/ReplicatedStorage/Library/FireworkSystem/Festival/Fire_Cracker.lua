--Name		: Fire_Cracker
--Explain	: ファイヤークラッカー(https://www.youtube.com/watch?v=DLJIu3B1jE0)
-- meter	: 4拍子
-- beat 	: 1.7
-- Launchers	: 1 2 | 3 | 4 5
local Fire_Cracker = {}

Fire_Cracker = {}
Fire_Cracker.__index = Fire_Cracker

Fire_Cracker.Colors = {
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(66, 211, 255),
	Color3.fromRGB(5, 155, 255),
	Color3.fromRGB(32, 69, 255),
}

function Fire_Cracker.new(MainLauncher : Part) : table
	local self = setmetatable({}, Fire_Cracker)

	self.FireworkSystem = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)
	self.AFirework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem.AFirework)
	self.Festival = require(script.Parent)
	self.folder = self.Festival.makeFolder("Fire_Cracker")
	self.Launcher_Num = 5
	self.Launcher_Half = self.Launcher_Num // 2
	self.bgm = self.Festival.makeBGM("rbxassetid://123623432077552")
	self.beat = 1.7
	self.Launchers = self.Festival.makeLauncher(self.folder, MainLauncher, self.Launcher_Half, 'x', 50)
	self.isPlaying = false

	self.fireworks = {}
	-- Gerb
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Gerb_" .. key .. i] = self.FireworkSystem.Gerb.new({
				Parent = self.Launchers[i],
				Color1 = color,
				Interval = 0.05
			})
		end
		for index, color in ipairs(Fire_Cracker.Colors) do
			self.fireworks["Gerb_" .. index .. "_" .. i] = self.FireworkSystem.Gerb.new({
				Parent = self.Launchers[i],
				Color1 = color,
				Interval = 0.05
			})
		end
	end
	-- Botan
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Botan_" .. key .. i] = self.FireworkSystem.Botan.new({
				Parent = self.Launchers[i],
				Color1 = color,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
		for index, color in ipairs(Fire_Cracker.Colors) do
			self.fireworks["Botan_" .. index .. "_" .. i] = self.FireworkSystem.Botan.new({
				Parent = self.Launchers[i],
				Color1 = color,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
	end
	-- Kamuro
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Kamuro_" .. key .. i] = self.FireworkSystem.Kamuro.new({
				Parent = self.Launchers[i],
				Color1 = color,
				ExplodeTime = 3,
				Flare_num = 50,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
		for index, color in ipairs(Fire_Cracker.Colors) do
			self.fireworks["Kamuro_" .. index .. "_" .. i] = self.FireworkSystem.Kamuro.new({
				Parent = self.Launchers[i],
				Color1 = color,
				ExplodeTime = 3,
				Flare_num = 50,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
	end
	-- Kiku
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Kiku_" .. key .. i] = self.FireworkSystem.Kiku.new({
				Parent = self.Launchers[i],
				Color2 = color,
				ExplodeTime = 1.5,
				ExplodeSpeed = 60,
				Flare_num = 50,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
		for index, color in ipairs(Fire_Cracker.Colors) do
			self.fireworks["Kiku_" .. index .. "_" .. i] = self.FireworkSystem.Kiku.new({
				Parent = self.Launchers[i],
				Color2 = color,
				ExplodeTime = 1.5,
				ExplodeSpeed = 60,
				Flare_num = 50,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
	end
	-- Ring
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Ring_" .. key .. i] = self.FireworkSystem.Ring.new({
				Parent = self.Launchers[i],
				Color1 = color,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
		for index, color in ipairs(Fire_Cracker.Colors) do
			self.fireworks["Ring_" .. index .. "_" .. i] = self.FireworkSystem.Ring.new({
				Parent = self.Launchers[i],
				Color1 = color,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
	end
	-- UFO
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["UFO_" .. key .. i] = self.FireworkSystem.UFO.new({
				Parent = self.Launchers[i],
				Color1 = color,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
		for index, color in ipairs(Fire_Cracker.Colors) do
			self.fireworks["UFO_" .. index .. "_" .. i] = self.FireworkSystem.UFO.new({
				Parent = self.Launchers[i],
				Color1 = color,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
	end

	self.isSetUp = true
	return self
end

function Fire_Cracker:launch()
	if self == nil or self.isSetUp == false then
		warn("You need to \'setup\' first.")
		return
	end

	self.isSetUp = false
	self.isPlaying = true
	self.bgm:Play()
	self.Festival.CountDown(self)

	while true do
		task.wait(self.beat)
		self.fireworks["Gerb_C1"]:launch()
		task.wait(self.beat)
		self.fireworks["Botan_C1"]:launch()
		task.wait(self.beat)
		self.fireworks["Kamuro_C1"]:launch()
		task.wait(self.beat)
		self.fireworks["Kiku_C1"]:launch()
		task.wait(self.beat)
		self.fireworks["Ring_C1"]:launch()
		task.wait(self.beat)
		self.fireworks["UFO_C1"]:launch()
	end

	-- self:stop()
end

function Fire_Cracker:stop()
	self.bgm:Stop()
	self.isPlaying = false
end

return Fire_Cracker
