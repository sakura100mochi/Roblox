-- include modules --
local Wander = require(script.Parent.Wander)
local Idle = require(script.Parent.Idle)
local Chase = require(script.Parent.Chase)
local Flee = require(script.Parent.Flee)
local Attack = require(script.Parent.Attack)
local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
local sp = lib.sp

-- Name		: MovementController
-- Explain	: モブの動きを制御するクラス
local MovementController = {}

-- モブの移動速度
local WALKSPEED = 8
-- チェイスするプレイヤーをさがす範囲
local CHASE_RANGE = 50
-- プレイヤーに攻撃する範囲
local ATTACK_RANGE = 2
-- プレイヤーから逃げる範囲
local FLEE_RANGE = 20

function MovementController:_SetWalkSpeed()
	if self.Humanoid then
		self.Humanoid.WalkSpeed = self.WalkSpeed
	end
end

function MovementController:_SetAnimation()
	if self.Humanoid == nil then return end
	if self.Humanoid:FindFirstChild("Animator") == nil then
		local animator = Instance.new("Animator")
		animator.Parent = self.Humanoid
	end

	local Walk = Instance.new("Animation")
	Walk.Parent = self.Mob
	Walk.AnimationId = "rbxassetid://180426354"
	local WalkTrack = self.Humanoid:WaitForChild("Animator"):LoadAnimation(Walk)
	WalkTrack.Priority = Enum.AnimationPriority.Idle

	local Idle = Instance.new("Animation")
	Idle.Parent = self.Mob
	Idle.AnimationId = "rbxassetid://180435792"
	local IdleTrack = self.Humanoid:WaitForChild("Animator"):LoadAnimation(Idle)
	IdleTrack.Priority = Enum.AnimationPriority.Idle

	return WalkTrack, IdleTrack
end

function MovementController.new(Mob : Instance)
	local self = setmetatable({}, {__index = MovementController})
	self.Mob = Mob
	self.ClassName = Mob.ClassName
	self.Humanoid = Mob:FindFirstChild("Humanoid")
	self.HumanoidRootPart = Mob:FindFirstChild("HumanoidRootPart")
	self.WalkSpeed = WALKSPEED
	self:_SetWalkSpeed()
	self.SearchRange = FLEE_RANGE
	self.ChaseRange =  CHASE_RANGE
	self.AttackRange = ATTACK_RANGE
	self.FleeRange = FLEE_RANGE
	self.WanderTimeRange = {min = 2, max = 5}
	self.IdleTimeRange =  {min = 2, max = 5}
	self.canAttack = true

	if self.HumanoidRootPart then
		self.WalkTrack, self.IdleTrack = self:_SetAnimation()
		self.Position = { Current = self.HumanoidRootPart.Position }
	elseif self.ClassName == "Part" then
		self.Position = { Current = Mob.Position }
	end

	self.Wander = Wander.new(self)
	self.Idle = Idle.new(self)
	self.Chase = Chase.new(self)
	self.Attack = Attack.new(self)
	self.Flee = Flee.new(self)

	return self
end

function MovementController:Start()
	if self.WalkTrack then
		self.WalkTrack:Play()
	end
	while true do
		-- local TargetPlayer = sp.SearchPlayer(self.Position.Current, self.SearchRange)
		-- if TargetPlayer then
		-- 	self.Chase:Update(TargetPlayer)
		-- 	local AttackPlayer = sp.SearchPlayer(self.Position.Current, self.AttackRange)
		-- 	if AttackPlayer then
		-- 		self.Attack:Update(AttackPlayer)
		-- 	end
		local TargetPlayer = sp.SearchPlayer(self.Position.Current, self.SearchRange)
		if TargetPlayer then
			self.Flee:Update(TargetPlayer)
		else
			self.Idle:Update()
			self.Wander:Update()
		end
		task.wait()
	end
end

return MovementController