local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
local firework = lib.firework
local Players = game:GetService("Players")
local fireworks = nil

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(Message)
		if Message == "setup" then
			fireworks = firework.Festival.Akagawa_31st_2024_Opening.setup(workspace.Launcher)
		elseif Message == "launch" then
			firework.Festival.Akagawa_31st_2024_Opening.launch(fireworks)
		elseif Message == "all1" then
			firework.All.AutoSystem_type1(workspace.Launcher)
		elseif Message == "all2" then
			firework.All.AutoSystem_type2(workspace.Launcher)
		elseif Message == "gerb" then
			local gerb = firework.Gerb.new({Parent = workspace.Launcher})
			gerb:launch()
		elseif Message == "sound" then
			firework.Sound.ListenAllSound()
		end
	end)
end)
