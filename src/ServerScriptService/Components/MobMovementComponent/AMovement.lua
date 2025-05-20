--Name		: AMovement
--Explain	: Mobの動きを設定するクラスの親クラス
local AMovement = {}
AMovement.__index = AMovement

--Function Name	: new
--Explain		: コンストラクタ　子クラスからのみ呼び出し可能
--Arguments| MovementController	: (table) MovementControllerのtable
--Return Value	: (table) 設定した後のtable
function AMovement.new(MovementController : table) : table
	local self = setmetatable({}, AMovement)
	self.Mob = MovementController.Mob
	self.ClassName = MovementController.ClassName
	self.Humanoid = MovementController.Humanoid
	self.HumanoidRootPart = MovementController.HumanoidRootPart
	self.WalkSpeed = MovementController.WalkSpeed
	self.SearchRange = MovementController.SearchRange
	self.ChaseRange = MovementController.ChaseRange
	self.AttackRange = MovementController.AttackRange
	self.FleeRange = MovementController.FleeRange
	self.WanderTimeRange = MovementController.WanderTimeRange
	self.IdleTimeRange = MovementController.IdleTimeRange
	self.canAttack = MovementController.canAttack
	self.Position = MovementController.Position

	if self.Humanoid then
		self.WalkTrack = MovementController.WalkTrack
		self.IdleTrack = MovementController.IdleTrack
	end

	return self
end

function AMovement:Update()
	error("ERROR: Abstract method — must be implemented in subclass")
end

function AMovement:_UpdatePosition()
	if self.HumanoidRootPart then
		self.Position.Current = self.HumanoidRootPart.Position
	elseif self.ClassName == "Part" then
		self.Position.Current = self.Mob.Position
	end
end

function AMovement:_WaitUntilPlayer(WaitTime : number, checkIsMoving : boolean | nil)
	local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
	local sp = lib.sp
	local IsWaiting = true
	checkIsMoving = checkIsMoving or false
	if checkIsMoving == true and self.Humanoid and self.Humanoid.MoveToFinished then
		self.Humanoid.MoveToFinished:Connect(function()
			IsWaiting = false
		end)
	end
	local timer = 0
	while timer < WaitTime do
		self:_UpdatePosition()
		local TargetPlayer = sp.SearchPlayer(self.Position.Current, self.SearchRange)
		if TargetPlayer then
			break
		end
		if checkIsMoving == true and IsWaiting == false then
			break
		elseif checkIsMoving == true and self.ClassName == "Part" then
			self.Mob.CFrame = self.Mob.CFrame + self.Mob.CFrame.LookVector
		end
		timer = timer + 0.1
		task.wait(0.1)
	end
end

return AMovement
