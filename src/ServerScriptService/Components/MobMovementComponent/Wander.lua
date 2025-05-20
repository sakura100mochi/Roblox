--Name		: Wander
--Explain	: モブがランダムに歩く
local Wander = {}

-- モブが動き回る範囲
local WANDER_RANGE = 50

local function GetRandomPosition(mob : Model | Part, pos : Vector3) : Vector3
	local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
	local ray = lib.ray

	local randomX = math.random(-WANDER_RANGE, WANDER_RANGE)
	local randomZ = math.random(-WANDER_RANGE, WANDER_RANGE)
	local randomPosition = pos + Vector3.new(randomX, 0, randomZ)
	local groundPosition = ray.GroundPosition(randomPosition, {mob})
	if groundPosition == nil then
		return pos
	end

	return groundPosition
end

function Wander:_Model()
	return function ()
		local goal = GetRandomPosition(self.Mob, self.HumanoidRootPart.Position)
		self.Humanoid:MoveTo(goal)
		self.Humanoid.MoveToFinished:Wait(math.random(self.WanderTimeRange.min, self.WanderTimeRange.max))

		self.Position.Current = self.HumanoidRootPart.Position
	end
end

function Wander:_Part()
	return function ()
		local goal = GetRandomPosition(self.Mob, self.Mob.Position)
		self.Mob.CFrame = CFrame.lookAt(self.Mob.Position, goal)
		self.Mob.Velocity = (goal - self.Mob.Position).Unit * self.WalkSpeed * 3
		self.Mob.CFrame += self.Mob.CFrame.LookVector

		self.Position.Current = self.Mob.Position
	end
end

--Function Name	: Wander
--Explain		: モブがランダムに歩く
--Arguments| MovementController: (table)
--Return Value	: (table)
function Wander.new(MovementController : table) : table
	local self = setmetatable({}, {__index = Wander})
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

function Wander:Start()

end

function Wander:Update()
	self.UpdateFunc()
end

return Wander
