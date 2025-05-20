--Name		: Wander
--Explain	: モブがランダムに歩く AMovementの子クラス
local AMovement = require(script.Parent.AMovement)

local Wander = setmetatable({}, {__index = AMovement})
Wander.__index = Wander

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
		self:_WaitUntilPlayer(math.random(self.WanderTimeRange.min, self.WanderTimeRange.max), true)
	end
end

function Wander:_Part()
	return function ()
		local goal = GetRandomPosition(self.Mob, self.Mob.Position)
		self.Mob.CFrame = CFrame.lookAt(self.Mob.Position, goal)

		self:_WaitUntilPlayer(math.random(self.WanderTimeRange.min, self.WanderTimeRange.max), true)
	end
end

--Function Name	: Wander
--Explain		: モブがランダムに歩く
--Arguments| MovementController: (table)
--Return Value	: (table)
function Wander.new(MovementController : table) : table
	local self = AMovement.new(MovementController)
	setmetatable(self, Wander)

	if self.Humanoid then
		self.UpdateFunc = self:_Model()
	else
		self.UpdateFunc = self:_Part()
	end

	return self
end

function Wander:Update()
	self.UpdateFunc()
end

return Wander
