--Name		: Festival
--Explain	: 花火大会用にプログラムされた花火
local Festival = {}

Festival.Colors_of_Our_Lives = require(script.Colors_of_Our_Lives)
Festival.Fire_Cracker = require(script.Fire_Cracker)


function Festival.makeFolder(name : string) : Folder
	local folder = Instance.new("Folder")
	folder.Parent = workspace
	folder.Name = name

	return folder
end

function Festival.makeBGM(SoundID : string) : Sound
	local bgm = Instance.new("Sound")
	bgm.Parent = game:GetService("SoundService")
	bgm.SoundId = SoundID
	bgm.Volume = 2

	return bgm
end

function Festival.makeLauncher(folder : Folder, MainLauncher : any, LauncherHalf : number, Direction : string, distance : number) : table
	local Launchers = {}
	for i = -LauncherHalf, LauncherHalf, 1 do
		local launcher = Instance.new("Part")
		launcher.Parent = folder
		launcher.Name = "Launcher"
		if Direction == 'x' then
			launcher.CFrame = CFrame.new(Vector3.new(i * distance, 0, 0)) * MainLauncher.CFrame
		else
			launcher.CFrame = CFrame.new(Vector3.new(0, 0, i * distance)) * MainLauncher.CFrame
		end
		launcher.Transparency = 0
		launcher.Anchored = true
		table.insert(Launchers, launcher)
	end

	return Launchers
end

function Festival.CountDown(self : table)
	if self == nil or self.isPlaying == nil then
		warn("Can't CountDown, self is nil or not playing.")
		return
	end
	task.spawn(function()
		local i = 0
		while self.isPlaying do
			print(i)
			i = i + 1
			task.wait(1)
		end
	end)
end

return Festival
