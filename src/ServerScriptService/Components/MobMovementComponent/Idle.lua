--Name		: Idle
--Explain	: モブが止まっている
local Idle = {}

function Idle:_Model()
	return function ()
		self.WalkTrack:Stop()
		self.IdleTrack:Play()
		task.wait(math.random(self.IdleTimeRange.min, self.IdleTimeRange.max))
		self.IdleTrack:Stop()
		self.WalkTrack:Play()
	end
end

function Idle:_Part()
	return function ()
		task.wait(math.random(self.IdleTimeRange.min, self.IdleTimeRange.max))
	end
end

--Function Name	: Idle
--Explain		: モブが止まっている
--Arguments| MovementController: (table)
--Return Value	: (table)
function Idle.new(MovementController : table) : table
	local self = setmetatable({}, {__index = Idle})
	self.Mob = MovementController.Mob
	self.ClassName = MovementController.ClassName
	self.Humanoid = MovementController.Humanoid
	self.HumanoidRootPart = MovementController.HumanoidRootPart
	self.WalkSpeed = MovementController.WalkSpeed
	self.WanderTimeRange = MovementController.WanderTimeRange
	self.IdleTimeRange = MovementController.IdleTimeRange
	self.Position = MovementController.Position

	if self.Humanoid then
		self.WalkTrack = MovementController.WalkTrack
		self.IdleTrack = MovementController.IdleTrack
		self.UpdateFunc = self:_Model()
	else
		self.UpdateFunc = self:_Part()
	end

	return self
end

function Idle:Start()

end

function Idle:Update()
	self.UpdateFunc()
end

return Idle
