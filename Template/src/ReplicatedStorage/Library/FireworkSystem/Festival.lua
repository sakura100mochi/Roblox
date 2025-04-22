--Name		: Festival
--Explain	: 花火大会用にプログラムされた花火
local Festival = {}

local function makeFolder()
	local folder = Instance.new("Folder")
	folder.Parent = workspace
	folder.Name = "Akagawa_31st_2024"

	return folder
end

local function makeLauncher(folder)
	local Launchers = {}
	for i = -12, 12, 1 do
		local launcher = Instance.new("Part")
		launcher.Parent = folder
		launcher.Name = "Launcher"
		launcher.CFrame = CFrame.new(Vector3.new(i * 15, 0, 0))
		launcher.Transparency = 0
		launcher.Anchored = true
		table.insert(Launchers, launcher)
	end

	return Launchers
end

-- Launchers 1 2 3 4 5 6 | 7 8 9 10 11 12 ||| 13 14 15 16 17 18 | 19 20 21 22 23 24

function Festival.Akagawa_31st_2024_Opening()
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	local folder = makeFolder()
	local Launchers = makeLauncher(folder)
	for i = 1, 12, 1 do
		task.spawn(function()firework.Gerb.launch(Launchers[12 + i], ColorSequence.new(firework.Colors.Mg))end)
		task.spawn(function()firework.Gerb.launch(Launchers[13 - i], ColorSequence.new(firework.Colors.Mg))end)
		task.wait(1 / 12)
	end
	for i = 1, 12, 1 do
		task.spawn(function()firework.Gerb.launch(Launchers[12 + i], ColorSequence.new(firework.Colors.Sr))end)
		task.spawn(function()firework.Gerb.launch(Launchers[13 - i], ColorSequence.new(firework.Colors.Sr))end)
		task.wait(1 / 12)
	end
	for i = 1, 12, 1 do
		task.spawn(function()firework.Gerb.launch(Launchers[12 + i], ColorSequence.new(firework.Colors.Cu))end)
		task.spawn(function()firework.Gerb.launch(Launchers[13 - i], ColorSequence.new(firework.Colors.Cu))end)
		task.wait(1 / 12)
	end

	firework.Kiku.FLARE_NUM = 90
	for i = 1, 24, 2 do
		task.spawn(function()firework.Kiku.launch(Launchers[i].CFrame, nil, 1.5, 40, math.random(18, 23) / 10)end)
	end

	task.spawn(function()firework.Toranoo.fan(Launchers[7].CFrame, 80)end)
	task.spawn(function()firework.Toranoo.fan(Launchers[18].CFrame, 80)end)

	task.spawn(function()firework.Gerb.fan(Launchers[7], ColorSequence.new(firework.Colors.Al))end)
	task.spawn(function()firework.Gerb.fan(Launchers[18], ColorSequence.new(firework.Colors.Al))end)
end

return Festival
