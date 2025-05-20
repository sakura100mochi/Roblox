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
	self.WanderTimeRange = MovementController.WanderTimeRange
	self.IdleTimeRange = MovementController.IdleTimeRange
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

return AMovement
