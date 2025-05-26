local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
local firework = lib.firework
local Players = game:GetService("Players")
local fireworks = firework.Festival.Colors_of_Our_Lives.new(workspace.Launcher)

Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(Message)
		if Message == "setup" then
			fireworks = firework.Festival.Colors_of_Our_Lives.new(workspace.Launcher)
		elseif Message == "launch" then
			fireworks:launch()
		elseif Message == "stop" then
			fireworks:stop()
		elseif Message == "all1" then
			firework.All.AutoSystem_type1(workspace.Launcher)
		elseif Message == "all2" then
			firework.All.AutoSystem_type2(workspace.Launcher)
		elseif Message == "kamuro" then
			local kamuro = firework.Kamuro.new({Parent = workspace.Launcher})
			kamuro:launch()
		elseif Message == "gerb" then
			local gerb = firework.Gerb.new({Parent = workspace.Launcher})
			gerb:AutoSystem()
		elseif Message == "sound" then
			firework.Sound.ListenAllSound()
		end
	end)
end)
