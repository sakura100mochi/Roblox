--Name		: Flee
--Explain	: モブが、近くのプレイヤーから逃げる　AMovementの子クラス
local AMovement = require(script.Parent.AMovement)

local Flee = setmetatable({}, {__index = AMovement})
Flee.__index = Flee

function Flee:_Model()
	return function (TargetPlayer : Player)
		if TargetPlayer == nil then return end
		local TargetCharacter = TargetPlayer.Character
		local TargetHumanoidRootPart = TargetCharacter:WaitForChild("HumanoidRootPart")
		local PlayerPos = TargetHumanoidRootPart.Position
		local FleeDir = (self.Position.Current - PlayerPos).Unit
		local goal = self.Position.Current + FleeDir * self.FleeRange

		self.Humanoid:MoveTo(goal)

		self:_UpdatePosition()
	end
end

function Flee:_Part()
	return function (TargetPlayer : Player)
		if TargetPlayer == nil then return end
		local TargetCharacter = TargetPlayer.Character
		local TargetHumanoidRootPart = TargetCharacter:WaitForChild("HumanoidRootPart")
		local PlayerPos = TargetHumanoidRootPart.Position
		local FleeDir = (self.Position.Current - PlayerPos).Unit
		local goal = self.Position.Current + FleeDir * self.FleeRange
		self.Mob.CFrame = CFrame.lookAt(self.Mob.Position, goal)
		self.Mob.CFrame = self.Mob.CFrame + self.Mob.CFrame.LookVector

		self:_UpdatePosition()
		task.wait(0.1)
	end
end

--Function Name	: Flee
--Explain		: モブが、近くのプレイヤーから逃げる
--Arguments| MovementController: (table)
--Return Value	: (table)
function Flee.new(MovementController : table) : table
	local self = AMovement.new(MovementController)
    setmetatable(self, Flee)

	if self.Humanoid then
		self.UpdateFunc = self:_Model()
	else
		self.UpdateFunc = self:_Part()
	end

	return self
end

function Flee:Update(TargetPlayer : Player)
	self.UpdateFunc(TargetPlayer)
end

return Flee
