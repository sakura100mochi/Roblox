--Name		: Fire_Cracker
--Explain	: 花火大会用にプログラムされた花火
-- 4拍子
-- Launchers : 1 2 | 3 | 4 5
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
	self.beat = 2.2
	self.Launchers = self.Festival.makeLauncher(self.folder, MainLauncher, self.Launcher_Half, 'z')
	self.isPlaying = false

	self.fireworks = {}

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

	-- self:stop()
end

function Fire_Cracker:stop()
	self.bgm:Stop()
	self.isPlaying = false
end

return Fire_Cracker
