-- include modules --
local Wander = require(script.Parent.Wander)
local Chase = require(script.Parent.Chase)
local Idle = require(script.Parent.Idle)
-- local Flee = require(script.Parent.Flee)
-- local Attack = require(script.Parent.Attack)
-- local Patrol = require(script.Parent.Patrol)

-- Name		: MovementController
-- Explain	: モブの動きを制御するクラス
local MovementController = {}

-- モブの移動速度
local WALKSPEED = 8

function MovementController:_SetWalkSpeed()
	if self.Humanoid then
		self.Humanoid.WalkSpeed = self.WalkSpeed
	end
end

function MovementController.new(Mob : Instance)
	local self = setmetatable({}, {__index = MovementController})
	self.Mob = Mob
	self.ClassName = Mob.ClassName
	self.Humanoid = Mob:FindFirstChild("Humanoid")
	self.HumanoidRootPart = Mob:FindFirstChild("HumanoidRootPart")
	self.WalkSpeed = WALKSPEED
	self.WanderTimeRange = {min = 2, max = 5}
	self.IdleTimeRange =  {min = 2, max = 5}

	self.Wander = Wander.new(self)
	self.Idle = Idle.new(self)
	-- self.Chase = Chase.new(self)

	return self
end

function MovementController:Start()
	self:_SetWalkSpeed()
	while true do
		self.Wander:Update()
		self.Idle:Update()
	end
end

return MovementController