--Name		: Attack
--Explain	: モブが近くのプレイヤーを攻撃する AMovementの子クラス
local AMovement = require(script.Parent.AMovement)

local Attack = setmetatable({}, {__index = AMovement})
Attack.__index = Attack

function Attack:TakeDamage(AttackPlayer : Player)
	if AttackPlayer == nil or self.canAttack == false then return end
	self.canAttack = false
	local AttackCharacter = AttackPlayer.Character
	local AttackHumanoid = AttackCharacter:WaitForChild("Humanoid")

	AttackHumanoid:TakeDamage(10)
	task.wait(1)
	self.canAttack = true
end

--Function Name	: Attack
--Explain		: モブが近くのプレイヤーを攻撃する
--Arguments| MovementController: (table)
--Return Value	: (table)
function Attack.new(MovementController : table) : table
	local self = AMovement.new(MovementController)
    setmetatable(self, Attack)

	return self
end

function Attack:Update(AttackPlayer : Player)
	self:TakeDamage(AttackPlayer)
end

return Attack
