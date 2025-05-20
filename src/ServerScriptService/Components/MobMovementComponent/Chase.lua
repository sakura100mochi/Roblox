--Name		: Chase
--Explain	: モブが、近くのプレイヤーを追いかける
local Chase = {}

function Chase:_Model()
	return function (TargetPlayer : Player)
		if TargetPlayer == nil then return end
		local TargetCharacter = TargetPlayer.Character
		local TargetHumanoidRootPart = TargetCharacter:WaitForChild("HumanoidRootPart")
		local goal = TargetHumanoidRootPart.Position

		self.Humanoid:MoveTo(goal)

		self.Position.Current = self.HumanoidRootPart.Position
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

		self.Position.Current = self.Mob.Position
	end
end

--Function Name	: Chase
--Explain		: モブがランダムに歩く
--Arguments| MovementController: (table)
--Return Value	: (table)
function Chase.new(MovementController : table) : table
	local self = setmetatable({}, {__index = Chase})
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

function Chase:Start()

end

function Chase:Update(TargetPlayer : Player)
	self.UpdateFunc(TargetPlayer)
end

return Chase
