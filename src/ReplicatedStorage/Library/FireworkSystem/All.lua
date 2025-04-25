--Name		: All
--Explain	: 全種類の花火を発射する
local All = {}

--Function Name	:AutoSystem_type1
--Explain		:全種類のタイプの花火を自動でたくさん打ち上げる
--					2秒に1度、1~3個のランダムな花火を打ち上げる
--Arguments| Launcher	: (Part) 花火を打ち上げる発射台のパーツ
--Return Value	: none
function All.AutoSystem_type1(Launcher)
	local firework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)
	while true do
		for i = 1, math.random(1, 3), 1 do
			local ft_table = {
				firework.Botan.new({Parent = Launcher, Start_CFrame = Launcher.CFrame}),
				firework.Ring.new({Parent = Launcher, Start_CFrame = Launcher.CFrame}),
				firework.UFO.new({Parent = Launcher, Start_CFrame = Launcher.CFrame}),
				firework.Kamuro.new({Parent = Launcher, Start_CFrame = Launcher.CFrame}),
				firework.Toranoo.new({Parent = Launcher, Start_CFrame = Launcher.CFrame}),
				firework.Kiku.new({Parent = Launcher, Start_CFrame = Launcher.CFrame}),
				firework.Gerb.new({Parent = Launcher, Start_CFrame = Launcher.CFrame})
			}
			task.spawn(function()ft_table[math.random(1, #ft_table)]:launchRandom()end)
		end
		task.wait(2)
	end
end

--Function Name	:AutoSystem_type2
--Explain		:全種類のタイプの花火を自動でたくさん打ち上げる
--					2秒に1度、1個の花火を、タイプごとに順番に打ち上げる
--Arguments| Launcher	: (Part) 花火を打ち上げる発射台のパーツ
--Return Value	: none
function All.AutoSystem_type2(Launcher)
	local firework = require(game.ReplicatedStorage.Shared.Library.FireworkSystem)
	local Botan = firework.Botan.new({Parent = Launcher, Start_CFrame = Launcher.CFrame})
	local Ring = firework.Ring.new({Parent = Launcher, Start_CFrame = Launcher.CFrame})
	local UFO = firework.UFO.new({Parent = Launcher, Start_CFrame = Launcher.CFrame})
	local Kamuro = firework.Kamuro.new({Parent = Launcher, Start_CFrame = Launcher.CFrame})
	local Toranoo = firework.Toranoo.new({Parent = Launcher, Start_CFrame = Launcher.CFrame})
	local Kiku = firework.Kiku.new({Parent = Launcher, Start_CFrame = Launcher.CFrame})
	local Gerb = firework.Gerb.new({Parent = Launcher, Start_CFrame = Launcher.CFrame})

	while true do
		task.spawn(function()Botan:launchRandom()end)
		task.wait(2)
		task.spawn(function()Ring:launchRandom()end)
		task.wait(2)
		task.spawn(function()UFO:launchRandom()end)
		task.wait(2)
		task.spawn(function()Kamuro:launchRandom()end)
		task.wait(2)
		task.spawn(function()Toranoo:launchRandom()end)
		task.wait(2)
		task.spawn(function()Toranoo:fan()end)
		task.wait(2)
		task.spawn(function()Kiku:launchRandom()end)
		task.wait(2)
		task.spawn(function()Gerb:launchRandom()end)
		task.wait(2)
		task.spawn(function()Gerb:fan()end)
		task.wait(2)
	end
end

return All
