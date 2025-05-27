--Name		: Festival
--Explain	: 花火大会用にプログラムされた花火
local Festival = {}

local function makeFolder() : Folder
	local folder = Instance.new("Folder")
	folder.Parent = workspace
	folder.Name = "Festival"

	return folder
end

local function makeBGM(SoundID : string) : Sound
	local bgm = Instance.new("Sound")
	bgm.Parent = game:GetService("SoundService")
	bgm.SoundId = SoundID
	bgm.Volume = 2

	return bgm
end

local function makeLauncher(folder : Folder, MainLauncher : any, LauncherHalf : number, Direction : string) : table
	local Launchers = {}
	for i = -LauncherHalf, LauncherHalf, 1 do
		local launcher = Instance.new("Part")
		launcher.Parent = folder
		launcher.Name = "Launcher"
		if Direction == 'x' then
			launcher.CFrame = CFrame.new(Vector3.new(i * 15, 0, 0)) * MainLauncher.CFrame
		else
			launcher.CFrame = CFrame.new(Vector3.new(0, 0, i * 15)) * MainLauncher.CFrame
		end
		launcher.Transparency = 0
		launcher.Anchored = true
		table.insert(Launchers, launcher)
	end

	return Launchers
end

local function CountDown(self : table)
	task.spawn(function()
		local i = 0
		while self.isPlaying do
			print(i)
			i = i + 1
			task.wait(1)
		end
	end)
end

-- Launchers 1 2 3 4 5 6 | 7 | 8 9 10 11 12 13

Festival.Colors_of_Our_Lives = {}
Festival.Colors_of_Our_Lives.__index = Festival.Colors_of_Our_Lives

Festival.Colors_of_Our_Lives.RainbowColors = {
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

function Festival.Colors_of_Our_Lives.new(MainLauncher : Part) : table
	local self = setmetatable({}, Festival.Colors_of_Our_Lives)

	self.FireworkSystem = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)
	self.AFirework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem.AFirework)
	self.folder = makeFolder()
	self.Launcher_Num = 13
	self.Launcher_Half = self.Launcher_Num // 2
	self.bgm = makeBGM("rbxassetid://119169641481723")
	self.beat = 2.2
	self.Launchers = makeLauncher(self.folder, MainLauncher, self.Launcher_Half, 'z')
	self.isPlaying = false
	
	self.fireworks = {}
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Gerb_" .. key .. i] = self.FireworkSystem.Gerb.new({
				Parent = self.Launchers[i],
				Color1 = color,
				Interval = 0.05
			})
		end
		for j, color in ipairs(Festival.Colors_of_Our_Lives.RainbowColors) do
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
		for j, color in ipairs(Festival.Colors_of_Our_Lives.RainbowColors) do
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
		Color5 = Festival.Colors_of_Our_Lives.RainbowColors[9],
	})

	self.isSetUp = true
	return self
end

function Festival.Colors_of_Our_Lives:launch()
	if self == nil or self.isSetUp == false then
		warn("You need to \'setup\' first.")
		return
	end
	
	self.isSetUp = false
	self.isPlaying = true
	task.spawn(function()self.fireworks["Botan_C1"]:launch()end)
	task.spawn(function()self.fireworks["Botan_Sr3"]:launch()end)
	task.spawn(function()self.fireworks["Botan_C7"]:launch()end)
	task.spawn(function()self.fireworks["Botan_Sr11"]:launch()end)
	task.spawn(function()self.fireworks["Botan_C13"]:launch()end)
	task.wait(self.beat)
	self.bgm:Play()
	CountDown(self)
	for i = 1, self.Launcher_Num, 1 do
		task.spawn(function()self.fireworks["Gerb_C" .. i]:launch()end)
	end
	task.wait(self.beat - 0.2)
	for i = 1, self.Launcher_Num, 1 do
		task.spawn(function()self.fireworks["Gerb_Rainbow_" .. i .. "_" .. i]:launch()end)
		task.wait(0.1)
	end
	task.wait(self.beat - 1.3)
	for i = self.Launcher_Num, 1, -1 do
		task.spawn(function()self.fireworks["Gerb_Rainbow_" .. self.Launcher_Num - i + 1 .. "_" .. i]:launch()end)
		task.wait(0.1)
	end
	task.spawn(function()self.fireworks["Botan_Al1"]:launch()end)
	task.spawn(function()self.fireworks["Botan_Al3"]:launch()end)
	task.spawn(function()self.fireworks["Botan_Al7"]:launch()end)
	task.spawn(function()self.fireworks["Botan_Al11"]:launch()end)
	task.spawn(function()self.fireworks["Botan_Al13"]:launch()end)
	task.wait(self.beat)
	for i = 1, self.Launcher_Num, 1 do
		task.spawn(function()self.fireworks["Gerb_Al" .. i]:launch()end)
	end
	task.spawn(function()self.fireworks["Toranoo_fan3"]:fan(7)end)
	task.spawn(function()self.fireworks["Toranoo_fan11"]:fan(7)end)
	task.spawn(function()self.fireworks["Kiku_Double_7"]:launchDouble()end)
	task.wait(self.beat)
	task.spawn(function()self.fireworks["Kamuro_C1"]:launch()end)
	task.spawn(function()self.fireworks["Kamuro_C9"]:launch()end)
	-- task.spawn(function()self.fireworks["Kiku_C1"]:launch()end)
	-- task.spawn(function()self.fireworks["Kiku_C9"]:launch()end)
	task.wait(self.beat)
	for i = 1, 6, 1 do
		task.spawn(function()self.fireworks["Gerb_C" .. i]:launch()end)
		task.wait(0.1)
	end
	task.spawn(function()self.fireworks["Kamuro_K5"]:launch()end)
	task.spawn(function()self.fireworks["Kamuro_K13"]:launch()end)
	-- task.spawn(function()self.fireworks["Kiku_K5"]:launch()end)
	-- task.spawn(function()self.fireworks["Kiku_K13"]:launch()end)
	task.wait(self.beat)
	for i = 8, 13, 1 do
		task.spawn(function()self.fireworks["Gerb_K" .. i]:launch()end)
		task.wait(0.1)
	end
	task.spawn(function()self.fireworks["Kamuro_Cu1"]:launch()end)
	task.spawn(function()self.fireworks["Kamuro_Cu9"]:launch()end)
	-- task.spawn(function()self.fireworks["Kiku_Cu1"]:launch()end)
	-- task.spawn(function()self.fireworks["Kiku_Cu9"]:launch()end)
	task.wait(self.beat)
	for i = 1, 6, 1 do
		task.spawn(function()self.fireworks["Gerb_Cu" .. i]:launch()end)
		task.wait(0.1)
	end
	task.spawn(function()self.fireworks["Kamuro_Rb5"]:launch()end)
	task.spawn(function()self.fireworks["Kamuro_Rb13"]:launch()end)
	-- task.spawn(function()self.fireworks["Kiku_Rb5"]:launch()end)
	-- task.spawn(function()self.fireworks["Kiku_Rb13"]:launch()end)
	task.wait(self.beat)
	for i = 8, 13, 1 do
		task.spawn(function()self.fireworks["Gerb_Rb" .. i]:launch()end)
		task.wait(0.1)
	end
	task.spawn(function()self.fireworks["Kamuro_Ba1"]:launch()end)
	task.spawn(function()self.fireworks["Kamuro_Ba9"]:launch()end)
	-- task.spawn(function()self.fireworks["Kiku_Ba1"]:launch()end)
	-- task.spawn(function()self.fireworks["Kiku_Ba9"]:launch()end)
	task.wait(self.beat)
	for i = 1, 6, 1 do
		task.spawn(function()self.fireworks["Gerb_Ba" .. i]:launch()end)
		task.wait(0.1)
	end
end

function Festival.Colors_of_Our_Lives:stop()
	self.bgm:Stop()
	self.isPlaying = false
end

return Festival
