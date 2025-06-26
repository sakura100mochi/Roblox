--Name		: Fire_Cracker
--Explain	: ファイヤークラッカー(https://www.youtube.com/watch?v=DLJIu3B1jE0)
-- meter	: 4拍子
-- beat 	: 1.7
-- Launchers	: 1 2 3 | 4 | 5 6 || 7 || 8 9 | 10 | 11 12 13
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
	self.Launcher_Num = 13
	self.Launcher_Half = self.Launcher_Num // 2
	self.bgm = self.Festival.makeBGM("rbxassetid://123623432077552")
	self.beat = 1.7
	self.Launchers = self.Festival.makeLauncher(self.folder, MainLauncher, self.Launcher_Half, 'x', 15)
	self.isPlaying = false

	self.fireworks = {}
	-- Gerb
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Gerb_" .. key .. "_" .. i] = self.FireworkSystem.Gerb.new({
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
			self.fireworks["Botan_" .. key .. "_" .. i] = self.FireworkSystem.Botan.new({
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
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Botan_1_" .. i .. "_long"] = self.FireworkSystem.Botan.new({
			Parent = self.Launchers[i],
			Color1 = Fire_Cracker.Colors[1],
			NoboriTime = self.beat + self.beat * 0.5,
		})
		self.fireworks["Botan_1_" .. i .. "_big"] = self.FireworkSystem.Botan.new({
			Parent = self.Launchers[i],
			Color1 = Fire_Cracker.Colors[1],
			ExplodeSpeed = NumberRange.new(430, 450),
			ExplodeTime = 4,
			NoboriTime = self.beat
		})
	end
	-- Kamuro
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Kamuro_" .. key .. "_" .. i] = self.FireworkSystem.Kamuro.new({
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
			self.fireworks["Kiku_" .. key .. "_" .. i] = self.FireworkSystem.Kiku.new({
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
	-- Kiku change color
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Kiku_Rb_K_" .. i] = self.FireworkSystem.Kiku.new({
			Parent = self.Launchers[i],
			Color2 = self.AFirework.Colors.Rb,
			Color3 = self.AFirework.Colors.K,
			ExplodeTime = 1.5,
			ExplodeSpeed = 60,
			Flare_num = 50,
			NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
		})
	end
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Kiku_Ba_Al_" .. i] = self.FireworkSystem.Kiku.new({
			Parent = self.Launchers[i],
			Color2 = self.AFirework.Colors.Ba,
			Color3 = self.AFirework.Colors.Al,
			ExplodeTime = 1.5,
			ExplodeSpeed = 60,
			Flare_num = 50,
			NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
		})
	end
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Kiku_C_Cu_" .. i] = self.FireworkSystem.Kiku.new({
			Parent = self.Launchers[i],
			Color2 = self.AFirework.Colors.C,
			Color3 = self.AFirework.Colors.Cu,
			ExplodeTime = 1.5,
			ExplodeSpeed = 60,
			Flare_num = 50,
			NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
		})
	end
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Kiku_4_1_" .. i] = self.FireworkSystem.Kiku.new({
			Parent = self.Launchers[i],
			Color2 = Fire_Cracker.Colors[4],
			Color3 = Fire_Cracker.Colors[1],
			ExplodeTime = 1.5,
			ExplodeSpeed = 60,
			Flare_num = 50,
			NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
		})
	end
	-- Kiku Double
	self.fireworks["Kiku_Double_Sr_4_7"] = self.FireworkSystem.Kiku.new({
		Parent = self.Launchers[7],
		NoboriTime = self.beat + 0.5,
		ExplodeTime = 1.5,
		ExplodeSpeed = 60,
		Flare_num = 200,
		Color2 = self.AFirework.Colors.Sr,
		Color3 = self.AFirework.Colors.C,
		Color4 = self.AFirework.Colors.C,
		Color5 = Fire_Cracker.Colors[4],
	})
	self.fireworks["Kiku_Double_Cu_Ba_7"] = self.FireworkSystem.Kiku.new({
		Parent = self.Launchers[7],
		NoboriTime = self.beat + 0.5,
		ExplodeTime = 1.5,
		ExplodeSpeed = 60,
		Flare_num = 200,
		Color2 = self.AFirework.Colors.Cu,
		Color3 = self.AFirework.Colors.C,
		Color4 = self.AFirework.Colors.C,
		Color5 = self.AFirework.Colors.Ba,
	})
	self.fireworks["Kiku_Double_1_4_7"] = self.FireworkSystem.Kiku.new({
		Parent = self.Launchers[7],
		NoboriTime = self.beat + 0.5,
		ExplodeTime = 1.5,
		ExplodeSpeed = 60,
		Flare_num = 200,
		Color2 = Fire_Cracker.Colors[1],
		Color3 = Fire_Cracker.Colors[2],
		Color4 = Fire_Cracker.Colors[3],
		Color5 = Fire_Cracker.Colors[4],
	})
	-- Ring
	for i = 1, self.Launcher_Num, 1 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Ring_" .. key .. "_" .. i] = self.FireworkSystem.Ring.new({
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
			self.fireworks["UFO_" .. key .. "_" .. i] = self.FireworkSystem.UFO.new({
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
	self.fireworks["UFO_Li_C_7"] = self.FireworkSystem.UFO.new({
		Parent = self.Launchers[7],
		Color1 = self.AFirework.Colors.C,
		Color2 = self.AFirework.Colors.Li,
		ExplodeSpeed = NumberRange.new(430, 450),
		ExplodeTime = 4,
		NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
	})
	-- Toranoo
	self.fireworks["Toranoo_fan_4"] = self.FireworkSystem.Toranoo.new({
		Parent = self.Launchers[4],
		Direction = 'x'
	})
	self.fireworks["Toranoo_fan_10"] = self.FireworkSystem.Toranoo.new({
		Parent = self.Launchers[10],
		Direction = 'x'
	})

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

	task.wait(self.beat * 4)
	self.fireworks["Kiku_4_1"]:launch()
	self.fireworks["Kiku_2_4"]:launch()
	self.fireworks["Kiku_1_7"]:launch()
	self.fireworks["Kiku_3_10"]:launch()
	self.fireworks["Kiku_4_13"]:launch()
	task.wait(self.beat * 2)
	self.fireworks["Botan_3_1"]:launch()
	self.fireworks["Botan_4_4"]:launch()
	self.fireworks["Botan_2_7"]:launch()
	self.fireworks["Botan_1_10"]:launch()
	self.fireworks["Botan_2_13"]:launch()
	task.wait(self.beat * 2)
	self.fireworks["Kamuro_2_1"]:launch()
	self.fireworks["Kamuro_4_10"]:launch()
	task.wait(self.beat * 2)
	self.fireworks["Kamuro_1_4"]:launch()
	self.fireworks["Kamuro_3_13"]:launch()

	task.wait(self.beat * 2)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Kiku_" .. math.random(1, 4) .. "_" .. i]:launch()
	end
	task.wait(self.beat * 2)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Botan_" .. math.random(1, 4) .. "_" .. i]:launch()
	end
	task.wait(self.beat * 2)
	self.fireworks["Kamuro_2_1"]:launch()
	self.fireworks["Kamuro_4_10"]:launch()
	task.wait(self.beat)
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Gerb_" .. math.random(1, 4) .. "_" .. i]:launch()
		task.wait(0.1)
	end
	for i = self.Launcher_Num, 1, -1 do
		self.fireworks["Gerb_" .. math.random(1, 4) .. "_" .. i]:launch()
		task.wait(0.1)
	end

	self.fireworks["Kiku_Double_Sr_4_7"]:launchDouble()
	task.wait(self.beat)
	self.fireworks["Toranoo_fan_4"]:fan(7)
	self.fireworks["Toranoo_fan_10"]:fan(7)

	task.wait(self.beat)
	self.fireworks["Ring_1_1"]:launch()
	self.fireworks["UFO_3_13"]:launch()
	task.wait(self.beat)
	self.fireworks["UFO_2_1"]:launch()
	self.fireworks["Ring_4_13"]:launch()
	task.wait(self.beat)
	self.fireworks["UFO_Li_C_7"]:launch()

	task.wait(self.beat * 2)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Kiku_" .. math.random(1, 4) .. "_" .. i]:launch()
	end
	task.wait(self.beat * 2)
	self.fireworks["Kiku_Double_Cu_Ba_7"]:launchDouble()

	task.wait(self.beat)
	task.wait(self.beat)
	self.fireworks["Kiku_K_1"]:launch()
	self.fireworks["Kiku_Ca_10"]:launch()
	task.wait(self.beat)
	for i = 1, self.Launcher_Num, 3 do
		local tmp = math.random(0, 1) == 1 and "K" or "Ca"
		self.fireworks["Gerb_" .. tmp .. "_" .. i]:launch()
	end
	task.wait(self.beat)
	self.fireworks["Kiku_C_4"]:launch()
	self.fireworks["Kiku_Al_13"]:launch()
	task.wait(self.beat)
	for i = 1, self.Launcher_Num, 3 do
		local tmp = math.random(0, 1) == 1 and "C" or "Al"
		self.fireworks["Gerb_" .. tmp .. "_" .. i]:launch()
	end

	task.wait(self.beat)
	self.fireworks["Kiku_Sr_1"]:launch()
	self.fireworks["Kiku_Ca_10"]:launch()
	task.wait(self.beat)
	for i = 1, self.Launcher_Num, 3 do
		local tmp = math.random(0, 1) == 1 and "Sr" or "Ca"
		self.fireworks["Gerb_" .. tmp .. "_" .. i]:launch()
	end

	task.wait(self.beat * 0.5)
	self.fireworks["Botan_1_7_long"]:launch()
	task.wait(self.beat * 0.5)
	self.fireworks["Botan_1_7_big"]:launch()

	task.wait(self.beat)
	task.wait(self.beat * 0.5)
	self.fireworks["Botan_1_1_long"]:launch()
	self.fireworks["Botan_1_7_long"]:launch()
	self.fireworks["Botan_1_13_long"]:launch()
	task.wait(self.beat * 0.5)
	self.fireworks["Botan_1_1_big"]:launch()
	self.fireworks["Botan_1_7_big"]:launch()
	self.fireworks["Botan_1_13_big"]:launch()

	task.wait(self.beat)
	task.wait(self.beat * 0.5)
	self.fireworks["Botan_1_7_long"]:launch()
	task.wait(self.beat * 0.5)
	self.fireworks["Botan_1_7_big"]:launch()
	self.fireworks["Kamuro_2_1"]:launch()
	self.fireworks["Kamuro_2_13"]:launch()

	task.wait(self.beat * 2)

	-- 3 2 1
	task.wait(self.beat)
	self.fireworks["Kiku_Double_1_4_7"]:launchDouble()
	self.fireworks["Kiku_C_1"]:launch()
	self.fireworks["Kiku_C_13"]:launch()
	task.wait(self.beat)
	self.fireworks["Toranoo_fan_4"]:fan(7)
	self.fireworks["Toranoo_fan_10"]:fan(7)
	task.wait(self.beat)

	task.wait(self.beat)
	self.fireworks["Botan_K_1"]:launch()
	self.fireworks["Kiku_Rb_K_4"]:launch()
	self.fireworks["Botan_K_7"]:launch()
	self.fireworks["Kiku_Rb_K_10"]:launch()
	self.fireworks["Botan_K_13"]:launch()
	task.wait(self.beat)
	self.fireworks["Gerb_Rb_1"]:launch()
	self.fireworks["Gerb_K_4"]:launch()
	self.fireworks["Gerb_Rb_7"]:launch()
	self.fireworks["Gerb_K_10"]:launch()
	self.fireworks["Gerb_Rb_13"]:launch()

	task.wait(self.beat)
	self.fireworks["Kiku_Ba_Al_13"]:launch()
	self.fireworks["Botan_Ba_10"]:launch()
	self.fireworks["Kiku_Ba_Al_7"]:launch()
	self.fireworks["Botan_Ba_4"]:launch()
	self.fireworks["Kiku_Ba_Al_1"]:launch()
	task.wait(self.beat)
	self.fireworks["Gerb_Ba_1"]:launch()
	self.fireworks["Gerb_Al_4"]:launch()
	self.fireworks["Gerb_Ba_7"]:launch()
	self.fireworks["Gerb_Al_10"]:launch()
	self.fireworks["Gerb_Ba_13"]:launch()

	task.wait(self.beat)
	self.fireworks["Botan_Cu_1"]:launch()
	self.fireworks["Kiku_C_Cu_4"]:launch()
	self.fireworks["Botan_Cu_7"]:launch()
	self.fireworks["Kiku_C_Cu_10"]:launch()
	self.fireworks["Botan_Cu_13"]:launch()
	task.wait(self.beat)
	self.fireworks["Gerb_C_1"]:launch()
	self.fireworks["Gerb_Cu_4"]:launch()
	self.fireworks["Gerb_C_7"]:launch()
	self.fireworks["Gerb_Cu_10"]:launch()
	self.fireworks["Gerb_C_13"]:launch()

	task.wait(self.beat)
	self.fireworks["Kiku_4_1_13"]:launch()
	self.fireworks["Botan_4_10"]:launch()
	self.fireworks["Kiku_4_1_7"]:launch()
	self.fireworks["Botan_4_4"]:launch()
	self.fireworks["Kiku_4_1_1"]:launch()
	task.wait(self.beat)
	self.fireworks["Gerb_1_1"]:launch()
	self.fireworks["Gerb_4_4"]:launch()
	self.fireworks["Gerb_1_7"]:launch()
	self.fireworks["Gerb_4_10"]:launch()
	self.fireworks["Gerb_1_13"]:launch()

	task.wait(self.beat * 2)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Botan_" .. math.random(1, 4) .. "_" .. i]:launch()
	end
	task.wait(self.beat * 2)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Botan_" .. math.random(1, 4) .. "_" .. i]:launch()
	end
	task.wait(self.beat * 2)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Botan_" .. math.random(1, 4) .. "_" .. i]:launch()
	end

	task.wait(self.beat * 2)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Botan_" .. math.random(1, 4) .. "_" .. i]:launch()
	end

	task.wait(self.beat)

	task.wait(self.beat * 0.5)
	self.fireworks["Botan_1_4_long"]:launch()
	self.fireworks["Botan_1_10_long"]:launch()
	task.wait(self.beat * 0.5)
	self.fireworks["Botan_1_4_big"]:launch()
	self.fireworks["Botan_1_10_big"]:launch()
	self.fireworks["Kamuro_3_1"]:launch()
	self.fireworks["Kamuro_2_7"]:launch()
	self.fireworks["Kamuro_3_13"]:launch()
	task.wait(self.beat)

	task.wait(1)

	self:stop()
end

function Fire_Cracker:stop()
	self.bgm:Stop()
	self.isPlaying = false
end

return Fire_Cracker
