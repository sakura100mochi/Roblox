-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- include modules --
local MovementController = require(script.MovementController)

-- Create Component --
local MobMovement = Component.new({
	Tag = "MobMovement",
	Ancestor = { workspace },
	Extensions = {},
})

function MobMovement:Construct()
	self.MovementController = MovementController.new(self.Instance)
end

function MobMovement:Start()
	self.MovementController:Start()
end

function MobMovement:Stop()
	print("MobMovement stopped")
end

return MobMovement
