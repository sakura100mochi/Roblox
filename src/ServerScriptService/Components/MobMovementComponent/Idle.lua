--Name		: Idle
--Explain	: モブが止まっている
local Idle = {}

local function SetAnimation(Mob : Model, Humanoid : Humanoid) : AnimationTrack
	if Humanoid:FindFirstChild("Animator") == nil then
		local animator = Instance.new("Animator")
		animator.Parent = Humanoid
	end

	local Idle = Instance.new("Animation")
	Idle.Parent = Mob
	Idle.AnimationId = "rbxassetid://180435792"
	local IdleTrack = Humanoid:WaitForChild("Animator"):LoadAnimation(Idle)
	IdleTrack.Priority = Enum.AnimationPriority.Idle

	return IdleTrack
end

function Idle:_Model()
	return function ()
		self.IdleTrack:Play()
		task.wait(math.random(self.IdleTimeRange.min, self.IdleTimeRange.max))
		self.IdleTrack:Stop()
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

	if self.Humanoid then
		self.IdleTrack = SetAnimation(self.Mob, self.Humanoid)
		self.Update = self:_Model()
	else
		self.Update = self:_Part()
	end

	return self
end

function Idle:Start()

end

function Idle:Update()
	self.Update()
end

return Idle
