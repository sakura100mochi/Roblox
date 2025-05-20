--Name		: Chase
--Explain	: モブが、近くのプレイヤーを追いかける AMovementの子クラス
local AMovement = require(script.Parent.AMovement)

local Chase = setmetatable({}, {__index = AMovement})
Chase.__index = Chase

function Chase:_Model()
	return function (TargetPlayer : Player)
		if TargetPlayer == nil then return end
		local TargetCharacter = TargetPlayer.Character
		local TargetHumanoidRootPart = TargetCharacter:WaitForChild("HumanoidRootPart")
		local goal = TargetHumanoidRootPart.Position

		self.Humanoid:MoveTo(goal)

		self:_UpdatePosition()
	end
end

function Chase:_Part()
	return function (TargetPlayer : Player)
		if TargetPlayer == nil then return end
		local TargetCharacter = TargetPlayer.Character
		local TargetHumanoidRootPart = TargetCharacter:WaitForChild("HumanoidRootPart")
		local goal = TargetHumanoidRootPart.Position
		self.Mob.CFrame = CFrame.lookAt(self.Mob.Position, goal)
		self.Mob.Velocity = (goal - self.Mob.Position).Unit * self.WalkSpeed * 3
		self.Mob.CFrame += self.Mob.CFrame.LookVector

		self:_UpdatePosition()
	end
end

--Function Name	: Chase
--Explain		: モブがランダムに歩く
--Arguments| MovementController: (table)
--Return Value	: (table)
function Chase.new(MovementController : table) : table
	local self = AMovement.new(MovementController)
    setmetatable(self, Chase)

	if self.Humanoid then
		self.UpdateFunc = self:_Model()
	else
		self.UpdateFunc = self:_Part()
	end

	return self
end

function Chase:Update(TargetPlayer : Player)
	self.UpdateFunc(TargetPlayer)
end

return Chase
