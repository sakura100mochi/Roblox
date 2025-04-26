local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
local firework = lib.firework
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(Message)
		if Message == "run" then
			firework.Festival.Akagawa_31st_2024_Opening(workspace.Launcher)
		end
	end)
end)
