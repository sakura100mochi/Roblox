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

function Festival.Akagawa_31st_2024_Opening()
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework

	local folder = makeFolder()
	local Launchers = makeLauncher(folder)
	for i = 1, 12, 1 do
		task.spawn(function()firework.Gerb.launch(Launchers[12 + i], firework.Colors.Al)end)
		task.spawn(function()firework.Gerb.launch(Launchers[13 - i], firework.Colors.Al)end)
		task.wait(1 / 12)
	end
	for i = 1, 12, 1 do
		task.spawn(function()firework.Gerb.launch(Launchers[12 + i], firework.Colors.Sr)end)
		task.spawn(function()firework.Gerb.launch(Launchers[13 - i], firework.Colors.Sr)end)
		task.wait(1 / 12)
	end
	for i = 1, 12, 1 do
		task.spawn(function()firework.Gerb.launch(Launchers[12 + i], firework.Colors.Cu)end)
		task.spawn(function()firework.Gerb.launch(Launchers[13 - i], firework.Colors.Cu)end)
		task.wait(1 / 12)
	end

end

return Festival
