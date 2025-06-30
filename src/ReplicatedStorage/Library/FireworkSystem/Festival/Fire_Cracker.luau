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
	self.launchThread = nil
	self.clock = 19

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
		self.fireworks["Botan_C_" .. i .. "_long"] = self.FireworkSystem.Botan.new({
			Parent = self.Launchers[i],
			Color1 = self.AFirework.Colors.C,
			NoboriTime = self.beat + self.beat * 0.5,
		})
		self.fireworks["Botan_C_" .. i .. "_longlong"] = self.FireworkSystem.Botan.new({
			Parent = self.Launchers[i],
			Color1 = self.AFirework.Colors.C,
			NoboriTime = self.beat + self.beat,
		})
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
			self.fireworks["Kamuro_" .. index .. "_" .. i .. "_small"] = self.FireworkSystem.Kamuro.new({
				Parent = self.Launchers[i],
				Color1 = color,
				ExplodeTime = 1.5,
				Flare_num = 50,
				NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
			})
		end
		self.fireworks["Kamuro_C_Gold_" .. i] = self.FireworkSystem.Kamuro.new({
			Parent = self.Launchers[i],
			Color1 = self.AFirework.Colors.C,
			Color2 = Color3.fromRGB(215, 200, 111),
			ExplodeTime = 3,
			Flare_num = 50,
			NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
		})
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
	for i = 1, self.Launcher_Num, 1 do
		self.fireworks["Kiku_C_" .. i .. "_Big"] = self.FireworkSystem.Kiku.new({
			Parent = self.Launchers[i],
			ExplodeTime = 1.5,
			ExplodeSpeed = 80,
			NoboriTime = self.beat + self.beat * 0.5,
		})
		self.fireworks["Kiku_" .. i] = self.FireworkSystem.Kiku.new({
			Parent = self.Launchers[i],
			ExplodeTime = 1.5,
			ExplodeSpeed = 60,
			Flare_num = 50,
			NoboriTime = math.random((self.beat - 0.5) * 100, (self.beat + 0.5) * 100) / 100
		})
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
	self.fireworks["Kiku_Double_Al_Mg_7"] = self.FireworkSystem.Kiku.new({
		Parent = self.Launchers[7],
		NoboriTime = self.beat + 0.5,
		ExplodeTime = 1.5,
		ExplodeSpeed = 60,
		Flare_num = 200,
		Color2 = self.AFirework.Colors.Al,
		Color3 = self.AFirework.Colors.C,
		Color4 = self.AFirework.Colors.C,
		Color5 = self.AFirework.Colors.Mg,
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
	self.fireworks["UFO_4_1_7"] = self.FireworkSystem.UFO.new({
		Parent = self.Launchers[7],
		Color1 = Fire_Cracker.Colors[1],
		Color2 = Fire_Cracker.Colors[4],
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
	for i = 1, self.Launcher_Num, 3 do
		for key, color in pairs(self.AFirework.Colors) do
			self.fireworks["Toranoo_Right_" .. key .. "_" .. i] = self.FireworkSystem.Toranoo.new({
				Parent = self.Launchers[i],
				Color1 = color,
				Velocity = Vector3.new(-0.5000,	0.8660, 0) * 2,
			})
			self.fireworks["Toranoo_Left_" .. key .. "_" .. i] = self.FireworkSystem.Toranoo.new({
				Parent = self.Launchers[i],
				Color1 = color,
				Velocity = Vector3.new(0.5000, 0.8660, 0) * 2,
			})
		end
		for index, color in ipairs(Fire_Cracker.Colors) do
			self.fireworks["Toranoo_Right_" .. index .. "_" .. i] = self.FireworkSystem.Toranoo.new({
				Parent = self.Launchers[i],
				Color1 = color,
				Velocity = Vector3.new(-0.5000,	0.8660, 0) * 2,
			})
			self.fireworks["Toranoo_Left_" .. index .. "_" .. i] = self.FireworkSystem.Toranoo.new({
				Parent = self.Launchers[i],
				Color1 = color,
				Velocity = Vector3.new(0.5000, 0.8660, 0) * 2,
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
	if self.isPlaying == true then
		warn("Festival is already playing.")
		return
	end

	self.launchThread = coroutine.create(function()

	game.Lighting.ClockTime = self.clock
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
	self.fireworks["Botan_1_1"]:launch()
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
	self.fireworks["Kamuro_2_1_small"]:launch()
	self.fireworks["Kamuro_2_13_small"]:launch()

	task.wait(self.beat * 2)

	-- 3 2 1
	task.wait(0.9)
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

	self.fireworks["Kiku_Double_Al_Mg_7"]:launchDouble()
	task.wait(self.beat)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Toranoo_Right_Al_" .. i]:launch()
	end
	task.wait(self.beat)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Toranoo_Left_Al_" .. i]:launch()
	end
	self.fireworks["UFO_4_1_7"]:launch()
	task.wait(self.beat * 0.5)
	self.fireworks["Botan_3_1"]:launch()
	self.fireworks["Botan_3_13"]:launch()
	task.wait(self.beat * 0.1)
	self.fireworks["Botan_2_4"]:launch()
	task.wait(self.beat * 0.1)
	self.fireworks["Botan_1_10"]:launch()
	task.wait(self.beat * 0.1)
	self.fireworks["Botan_1_1"]:launch()
	task.wait(self.beat * 0.1)
	self.fireworks["Botan_2_10"]:launch()
	task.wait(self.beat * 0.1)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Toranoo_Right_Al_" .. i]:launch()
	end
	task.wait(self.beat * 0.5)
	self.fireworks["Kiku_C_7_Big"]:launch()
	task.wait(self.beat * 0.5)
	for i = 1, self.Launcher_Num, 3 do
		self.fireworks["Toranoo_Left_Al_" .. i]:launch()
	end

	self.fireworks["Kiku_1"]:launch()
	self.fireworks["Botan_C_4"]:launch()
	self.fireworks["Botan_C_10"]:launch()
	self.fireworks["Kiku_13"]:launch()
	self.fireworks["Botan_C_7_longlong"]:launch()
	task.wait(self.beat * 0.5)
	self.fireworks["Botan_C_2_long"]:launch()
	self.fireworks["Botan_C_5_long"]:launch()
	self.fireworks["Botan_C_9_long"]:launch()
	self.fireworks["Botan_C_12_long"]:launch()
	task.wait(self.beat * 0.5)
	self.fireworks["Botan_C_1"]:launch()
	self.fireworks["Botan_C_4"]:launch()
	self.fireworks["Botan_C_6"]:launch()
	self.fireworks["Botan_C_8"]:launch()
	self.fireworks["Botan_C_10"]:launch()
	self.fireworks["Botan_C_13"]:launch()
	for i = 1, self.Launcher_Num, 1 do
		if i % 2 == 0 then
			self.fireworks["Gerb_Al_" .. i]:launch()
		else
			self.fireworks["Gerb_C_" .. i]:launch()
		end
		task.wait(0.1)
	end
	task.wait(self.beat - 1.3)
	self.fireworks["Kamuro_C_Gold_1"]:launch()
	self.fireworks["Botan_C_4"]:launch()
	self.fireworks["Kiku_7"]:launch()
	self.fireworks["Botan_C_10"]:launch()
	self.fireworks["Kamuro_C_Gold_13"]:launch()
	self.fireworks["Botan_C_7_longlong"]:launch()
	for i = self.Launcher_Num, 1, -1 do
		if i % 2 == 0 then
			self.fireworks["Gerb_Al_" .. i]:launch()
		else
			self.fireworks["Gerb_C_" .. i]:launch()
		end
		if i * 0.1 == self.beat * 0.5 then
			self.fireworks["Botan_C_2_long"]:launch()
			self.fireworks["Botan_C_5_long"]:launch()
			self.fireworks["Botan_C_9_long"]:launch()
			self.fireworks["Botan_C_12_long"]:launch()
		end
		task.wait(0.1)
	end

	self.fireworks["Botan_C_1"]:launch()
	self.fireworks["Botan_C_4"]:launch()
	task.wait(0.1)
	self.fireworks["Botan_C_6"]:launch()
	task.wait(0.1)
	self.fireworks["Botan_C_8"]:launch()
	task.wait(0.1)
	self.fireworks["Botan_C_10"]:launch()
	task.wait(0.1)
	self.fireworks["Botan_C_13"]:launch()
	for i = 1, self.Launcher_Num, 1 do
		if i % 2 == 0 then
			self.fireworks["Gerb_Al_" .. i]:launch()
		else
			self.fireworks["Gerb_C_" .. i]:launch()
		end
		task.wait(0.1)
	end
	self.fireworks["Botan_C_1"]:launch()
	self.fireworks["Botan_C_4"]:launch()
	task.wait(0.1)
	self.fireworks["Botan_C_6"]:launch()
	task.wait(0.1)
	self.fireworks["Botan_C_8"]:launch()
	task.wait(0.1)
	self.fireworks["Botan_C_10"]:launch()
	task.wait(0.1)
	self.fireworks["Botan_C_13"]:launch()
	for i = self.Launcher_Num, 1, -1 do
		if i % 2 == 0 then
			self.fireworks["Gerb_Al_" .. i]:launch()
		else
			self.fireworks["Gerb_C_" .. i]:launch()
		end
		task.wait(0.1)
	end
	task.wait(self.beat - 1.3)

	self.fireworks["Botan_1_4_long"]:launch()
	self.fireworks["Botan_1_10_long"]:launch()
	task.wait(self.beat * 0.5)
	self.fireworks["Botan_1_4_big"]:launch()
	self.fireworks["Botan_1_10_big"]:launch()
	self.fireworks["Kamuro_3_1_small"]:launch()
	self.fireworks["Kamuro_2_7_small"]:launch()
	self.fireworks["Kamuro_3_13_small"]:launch()
	task.wait(self.beat)

	self:stop()
	end)
	coroutine.resume(self.launchThread)
end

function Fire_Cracker:stop()
	self.bgm:Stop()
	self.isPlaying = false
	if self.launchThread and coroutine.status(self.launchThread) == "suspended" then
		coroutine.close(self.launchThread)
		self.launchThread = nil
	end
end

return Fire_Cracker
