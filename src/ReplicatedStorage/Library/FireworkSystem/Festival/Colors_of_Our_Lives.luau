--Name		: Colors_of_Our_Lives
--Explain	: 花火大会用にプログラムされた花火
-- Launchers 1 2 3 4 5 6 | 7 | 8 9 10 11 12 13

Colors_of_Our_Lives = {}
Colors_of_Our_Lives.__index = Colors_of_Our_Lives

Colors_of_Our_Lives.RainbowColors = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(255, 104, 39),
	Color3.fromRGB(255, 212, 55),
	Color3.fromRGB(191, 255, 62),
	Color3.fromRGB(75, 255, 58),
	Color3.fromRGB(72, 255, 173),
	Color3.fromRGB(66, 211, 255),
	Color3.fromRGB(5, 155, 255),
	Color3.fromRGB(32, 43, 255),
	Color3.fromRGB(130, 62, 255),
	Color3.fromRGB(207, 62, 255),
	Color3.fromRGB(255, 51, 248),
	Color3.fromRGB(255, 78, 161),
}

function Colors_of_Our_Lives.new(MainLauncher : Part) : table
	local self = setmetatable({}, Colors_of_Our_Lives)

	self.FireworkSystem = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)
	self.AFirework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem.AFirework)
	self.Festival = require(script.Parent)
	self.folder = self.Festival.makeFolder("Colors_of_Our_Lives")
	self.Launcher_Num = 13
	self.Launcher_Half = self.Launcher_Num // 2
	self.bgm = self.Festival.makeBGM("rbxassetid://119169641481723")
	self.beat = 2.2
	self.Launchers = self.Festival.makeLauncher(self.folder, MainLauncher, self.Launcher_Half, 'z', 15)
	self.isPlaying = false
	self.launchThread = nil
	self.clock = 19

	self.fireworks = {}
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Gerb_" .. key .. i] = self.FireworkSystem.Gerb.new({
				Parent = self.Launchers[i],
				Color1 = color,
				Interval = 0.05
			})
		end
		for j, color in ipairs(Colors_of_Our_Lives.RainbowColors) do
			self.fireworks["Gerb_Rainbow_" .. j .. "_" .. i] = self.FireworkSystem.Gerb.new({
				Parent = self.Launchers[i],
				Color1 = color,
				Interval = 0.05
			})
		end
	end
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Toranoo_fan" .. i] = self.FireworkSystem.Toranoo.new({
			Parent = self.Launchers[i],
			Direction = 'z'
		})
	end
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Botan_" .. key .. i] = self.FireworkSystem.Botan.new({
				Parent = self.Launchers[i],
				Color1 = color,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
		for j, color in ipairs(Colors_of_Our_Lives.RainbowColors) do
			self.fireworks["Botan_Rainbow_" .. j .. "_" .. i] = self.FireworkSystem.Botan.new({
				Parent = self.Launchers[i],
				Color1 = color,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
	end
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
	end
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
	end
	self.fireworks["Kiku_Double_7"] = self.FireworkSystem.Kiku.new({
		Parent = self.Launchers[7],
		NoboriTime = self.beat + 0.5,
		ExplodeTime = 1.5,
		ExplodeSpeed = 60,
		Flare_num = 200,
		Color2 = self.AFirework.Colors.Sr,
		Color3 = self.AFirework.Colors.C,
		Color4 = self.AFirework.Colors.C,
		Color5 = Colors_of_Our_Lives.RainbowColors[9],
	})

	self.isSetUp = true
	return self
end

function Colors_of_Our_Lives:launch()
	if self == nil or self.isSetUp == false then
		warn("You need to \'setup\' first.")
		return
	end
	if self.isPlaying == true then
		warn("Festival is already playing.")
		return
	end

	self.launchThread = coroutine.create(function()

	game.Lighting.ClockTime = self.clock
	self.isPlaying = true
	self.fireworks["Botan_C1"]:launch()
	self.fireworks["Botan_Sr3"]:launch()
	self.fireworks["Botan_C7"]:launch()
	self.fireworks["Botan_Sr11"]:launch()
	self.fireworks["Botan_C13"]:launch()
	task.wait(self.beat)
	self.bgm:Play()
	self.Festival.CountDown(self)
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Gerb_C" .. i]:launch()
	end
	task.wait(self.beat - 0.2)
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Gerb_Rainbow_" .. i .. "_" .. i]:launch()
		task.wait(0.1)
	end
	task.wait(self.beat - 1.3)
	for i = self.Launcher_Num, 1, -1 do
		self.fireworks["Gerb_Rainbow_" .. self.Launcher_Num - i + 1 .. "_" .. i]:launch()
		task.wait(0.1)
	end
	self.fireworks["Botan_Al1"]:launch()
	self.fireworks["Botan_Al3"]:launch()
	self.fireworks["Botan_Al7"]:launch()
	self.fireworks["Botan_Al11"]:launch()
	self.fireworks["Botan_Al13"]:launch()
	task.wait(self.beat)
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Gerb_Al" .. i]:launch()
	end
	self.fireworks["Toranoo_fan3"]:fan(7)
	self.fireworks["Toranoo_fan11"]:fan(7)
	self.fireworks["Kiku_Double_7"]:launchDouble()
	task.wait(self.beat)
	self.fireworks["Kamuro_C1"]:launch()
	self.fireworks["Kamuro_C9"]:launch()
	-- self.fireworks["Kiku_C1"]:launch()
	-- self.fireworks["Kiku_C9"]:launch()
	task.wait(self.beat)
	for i = 1, 6, 1 do
		self.fireworks["Gerb_C" .. i]:launch()
		task.wait(0.1)
	end
	self.fireworks["Kamuro_K5"]:launch()
	self.fireworks["Kamuro_K13"]:launch()
	-- self.fireworks["Kiku_K5"]:launch()
	-- self.fireworks["Kiku_K13"]:launch()
	task.wait(self.beat)
	for i = 8, 13, 1 do
		self.fireworks["Gerb_K" .. i]:launch()
		task.wait(0.1)
	end
	self.fireworks["Kamuro_Cu1"]:launch()
	self.fireworks["Kamuro_Cu9"]:launch()
	-- self.fireworks["Kiku_Cu1"]:launch()
	-- self.fireworks["Kiku_Cu9"]:launch()
	task.wait(self.beat)
	for i = 1, 6, 1 do
		self.fireworks["Gerb_Cu" .. i]:launch()
		task.wait(0.1)
	end
	self.fireworks["Kamuro_Rb5"]:launch()
	self.fireworks["Kamuro_Rb13"]:launch()
	-- self.fireworks["Kiku_Rb5"]:launch()
	-- self.fireworks["Kiku_Rb13"]:launch()
	task.wait(self.beat)
	for i = 8, 13, 1 do
		self.fireworks["Gerb_Rb" .. i]:launch()
		task.wait(0.1)
	end
	self.fireworks["Kamuro_Ba1"]:launch()
	self.fireworks["Kamuro_Ba9"]:launch()
	-- self.fireworks["Kiku_Ba1"]:launch()
	-- self.fireworks["Kiku_Ba9"]:launch()
	task.wait(self.beat)
	for i = 1, 6, 1 do
		self.fireworks["Gerb_Ba" .. i]:launch()
		task.wait(0.1)
	end

	self:stop()
	end)
	coroutine.resume(self.launchThread)
end

function Colors_of_Our_Lives:stop()
	self.bgm:Stop()
	self.isPlaying = false
	if self.launchThread and coroutine.status(self.launchThread) == "suspended" then
		coroutine.close(self.launchThread)
		self.launchThread = nil
	end
end

return Colors_of_Our_Lives