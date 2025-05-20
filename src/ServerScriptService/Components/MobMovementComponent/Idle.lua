--Name		: Idle
--Explain	: モブが止まっている AMovementの子クラス
local AMovement = require(script.Parent.AMovement)

local Idle = setmetatable({}, {__index = AMovement})
Idle.__index = Idle

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
	local self = AMovement.new(MovementController)
    setmetatable(self, Idle)

	if self.Humanoid then
		self.UpdateFunc = self:_Model()
	else
		self.UpdateFunc = self:_Part()
	end

	return self
end

function Idle:Update()
	self.UpdateFunc()
end

return Idle
