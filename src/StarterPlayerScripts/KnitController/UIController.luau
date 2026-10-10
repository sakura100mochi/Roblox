-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local Knit = require(ReplicatedStorage.Packages.Knit)
-- UI --
local App = require(ReplicatedStorage.Shared.UI["App.story"])

local UIController = Knit.CreateController {
	Name = "UIController",
}

function UIController:KnitInit()
	self.player = game.Players.LocalPlayer
	self.playerGui = self.player:WaitForChild("PlayerGui")
end

function UIController:KnitStart()
	self.cleanup = App(self.playerGui)
	task.wait(5)
	self.cleanup()
end

return UIController
