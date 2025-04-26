--Name		: Festival
--Explain	: 花火大会用にプログラムされた花火
local Festival = {}

local LAUNCHER_NUM = 24
local LAUNCHER_HALF = 12

local function makeFolder()
	local folder = Instance.new("Folder")
	folder.Parent = workspace
	folder.Name = "Akagawa_31st_2024"

	return folder
end

local function makeLauncher(folder, MainLauncher, Direction)
	local Launchers = {}
	for i = -LAUNCHER_HALF, LAUNCHER_HALF, 1 do
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

local function newFireworks(Launchers)
	local firework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)
	local AFirework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem.AFirework)
	local fireworks = {}
	for i = 1, LAUNCHER_NUM, 1 do
		fireworks["Gerb_Mg_" .. i] = firework.Gerb.new({Parent = Launchers[i], Start_CFrame = Launchers[i].CFrame, Color1 = AFirework.Colors.Mg})
		fireworks["Gerb_Sr_" .. i] = firework.Gerb.new({Parent = Launchers[i], Start_CFrame = Launchers[i].CFrame, Color1 = AFirework.Colors.Sr})
		fireworks["Gerb_Cu_" .. i] = firework.Gerb.new({Parent = Launchers[i], Start_CFrame = Launchers[i].CFrame, Color1 = AFirework.Colors.Cu})
		fireworks["Kiku_Normal_" .. i] = firework.Kiku.new({Parent = Launchers[i], Start_CFrame = Launchers[i].CFrame, ExplodeTime = 1.5, NoboriTime = math.random(25, 35) / 10})
	end
	fireworks["Toranoo_fan_7"] = firework.Toranoo.new({Parent = Launchers[7], Start_CFrame = Launchers[7].CFrame, ExplodeSpeed = 40, Direction = 'z'})
	fireworks["Toranoo_fan_18"] = firework.Toranoo.new({Parent = Launchers[18], Start_CFrame = Launchers[18].CFrame, ExplodeSpeed = 40, Direction = 'z'})
	fireworks["Gerb_Al_7"] = firework.Gerb.new({Parent = Launchers[7], Start_CFrame = Launchers[7].CFrame, Color1 = AFirework.Colors.Al})
	fireworks["Gerb_Al_18"] = firework.Gerb.new({Parent = Launchers[18], Start_CFrame = Launchers[18].CFrame, Color1 = AFirework.Colors.Al})
	fireworks["Kiku_double_12"] = firework.Kiku.new({Parent = Launchers[12], Start_CFrame = Launchers[12].CFrame, 
				Color2 = AFirework.Colors.Sr, Color3 = AFirework.Colors.C, Color4 = AFirework.Colors.C, Color5 = Color3.new(0.180392, 0.290196, 1), NoboriTime = 5})

	return fireworks
end

-- Launchers 1 2 3 4 5 6 | 7 8 9 10 11 12 ||| 13 14 15 16 17 18 | 19 20 21 22 23 24

function Festival.Akagawa_31st_2024_Opening(MainLauncher)
	local firework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)

	local folder = makeFolder()
	local Launchers = makeLauncher(folder, MainLauncher, 'z')
	local fireworks = newFireworks(Launchers)
	-- for i = 1, LAUNCHER_HALF, 1 do
	-- 	task.spawn(function()fireworks["Gerb_Mg_" .. LAUNCHER_HALF + i]:launch()end)
	-- 	task.spawn(function()fireworks["Gerb_Mg_" .. LAUNCHER_HALF + 1 - i]:launch()end)
	-- 	task.wait(1 / LAUNCHER_HALF)
	-- end
	-- for i = 1, LAUNCHER_HALF, 1 do
	-- 	task.spawn(function()fireworks["Gerb_Sr_" .. LAUNCHER_HALF + i]:launch()end)
	-- 	task.spawn(function()fireworks["Gerb_Sr_" .. LAUNCHER_HALF + 1 - i]:launch()end)
	-- 	task.wait(1 / LAUNCHER_HALF)
	-- end
	-- for i = 1, LAUNCHER_HALF, 1 do
	-- 	task.spawn(function()fireworks["Gerb_Cu_" .. LAUNCHER_HALF + i]:launch()end)
	-- 	task.spawn(function()fireworks["Gerb_Cu_" .. LAUNCHER_HALF + 1 - i]:launch()end)
	-- 	task.wait(1 / LAUNCHER_HALF)
	-- end

	-- task.spawn(function()fireworks["Kiku_Normal_1"]:launch()end)
	-- task.spawn(function()fireworks["Kiku_Normal_24"]:launch()end)
	-- task.spawn(function()fireworks["Kiku_Normal_7"]:launch()end)
	-- task.spawn(function()fireworks["Kiku_Normal_18"]:launch()end)
	-- for i = 1, LAUNCHER_HALF, LAUNCHER_HALF do
	-- 	task.spawn(function()fireworks["Kiku_Normal_" .. LAUNCHER_HALF + i]:launch()end)
	-- 	task.spawn(function()fireworks["Kiku_Normal_" .. LAUNCHER_HALF + 1 - i]:launch()end)
	-- 	task.wait(0.1)
	-- end

	-- task.spawn(function()fireworks["Toranoo_fan_7"]:fan()end)
	-- task.spawn(function()fireworks["Toranoo_fan_18"]:fan()end)

	-- task.spawn(function()fireworks["Gerb_Al_7"]:fan()end)
	-- task.spawn(function()fireworks["Gerb_Al_18"]:fan()end)

	-- task.wait(1)
	task.spawn(function()fireworks["Kiku_double_12"]:launchDouble()end)
end

return Festival
