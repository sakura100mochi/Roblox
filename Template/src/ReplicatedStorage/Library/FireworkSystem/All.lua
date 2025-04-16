--Name		: All
--Explain	: 全種類の花火を発射する
local All = {}

--Function Name	:AutoSystem_type1
--Explain		:全種類のタイプの花火を自動でたくさん打ち上げる
--					2秒に1度、1~3個のランダムな花火を打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function All.AutoSystem_type1(Start_CFrame)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al"}
	while true do
		for i = 1, math.random(1, 3), 1 do
			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local Color2 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ExplodeTime = math.random(150, 300) / 100
			local tmp = math.random(250, 350)
			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
			local Velocity = Vector3.new(math.random(-1, 1), 2, math.random(-1, 1)) * 20
			local ft_table = {
				function()firework.Botan.launch(Start_CFrame, Color1, ExplodeTime, ExplodeSpeed)end,
				function()firework.Ring.launch(Start_CFrame, Color1, ExplodeTime, ExplodeSpeed)end,
				function()firework.UFO.launch(Start_CFrame, Color1, Color2, ExplodeTime, ExplodeSpeed)end,
				function()firework.Kamuro.launch(Start_CFrame, Color1, ExplodeTime)end,
				function()firework.Toranoo.launch(Start_CFrame, Color1, ExplodeTime, Velocity)end
			}
			task.spawn(function()ft_table[math.random(1, #ft_table)]()end)
		end
		task.wait(2)
	end
end

--Function Name	:AutoSystem_type2
--Explain		:全種類のタイプの花火を自動でたくさん打ち上げる
--					2秒に1度、1~3個の花火を、タイプごとに順番に打ち上げる
--Arguments| Start_CFrame	: (CFrame) 花火を打ち上げる場所のCFrame
--Return Value	: none
function All.AutoSystem_type2(Start_CFrame)
	local firework = require(game:GetService("ReplicatedStorage").Shared.Library).firework
	local Colors_Table = {"Li", "Na", "K", "Rb", "Cs", "Ca", "Sr", "Ba", "Cu", "C", "Al"}
	while true do
		for i = 1, math.random(1, 3), 1 do
			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ExplodeTime = math.random(150, 300) / 100
			local tmp = math.random(250, 350)
			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
			task.spawn(function()firework.Botan.launch(Start_CFrame, Color1, ExplodeTime, ExplodeSpeed)end)
		end
		task.wait(2)
		for i = 1, math.random(1, 3), 1 do
			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ExplodeTime = math.random(150, 300) / 100
			local tmp = math.random(250, 350)
			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
			task.spawn(function()firework.Ring.launch(Start_CFrame, Color1, ExplodeTime, ExplodeSpeed)end)
		end
		task.wait(2)
		for i = 1, math.random(1, 3), 1 do
			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local Color2 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ExplodeTime = math.random(150, 300) / 100
			local tmp = math.random(250, 350)
			local ExplodeSpeed = NumberRange.new(tmp, tmp + 20)
			task.spawn(function()firework.UFO.launch(Start_CFrame, Color1, Color2, ExplodeTime, ExplodeSpeed)end)
		end
		task.wait(2)
		for i = 1, math.random(1, 3), 1 do
			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ExplodeTime = math.random(150, 300) / 100

			task.spawn(function()firework.Kamuro.launch(Start_CFrame, Color1, ExplodeTime)end)
		end
		task.wait(2)
		for i = 1, math.random(1, 3), 1 do
			local Color1 = firework.Colors[Colors_Table[math.random(1, #Colors_Table)]]
			local ExplodeTime = math.random(150, 300) / 100
			local Velocity = Vector3.new(math.random(-1, 1), 2, math.random(-1, 1)) * 20

			task.spawn(function()firework.Toranoo.launch(Start_CFrame, Color1, ExplodeTime, Velocity)end)
		end
		task.wait(2)
		task.spawn(function()firework.Toranoo.fan(Start_CFrame)end)
		task.wait(2)
	end
end

return All
