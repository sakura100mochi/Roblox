local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
local magic = lib.magic
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(Message)
		if Message == "Magic" then
			magic.Magic(player, nil, nil, nil, nil)
		end
	end)
end)