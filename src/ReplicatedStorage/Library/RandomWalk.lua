--Name		: RandomWalk
--Explain	: ランダムウォーク
local randomwalk = {}

-- モブが動き回る範囲
local WANDERING_RANGE = 50
-- モブが移動する間隔
local MOVE_INTERVAL = 5
-- モブの移動速度
local WALKSPEED = 8

local function GetRandomPosition(mob : Model | Part, pos : Vector3, groundPart : Instance) : Vector3
	local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
	local ray = lib.ray

	local randomX = math.random(-WANDERING_RANGE, WANDERING_RANGE)
	local randomZ = math.random(-WANDERING_RANGE, WANDERING_RANGE)
	local randomPosition = pos + Vector3.new(randomX, 0, randomZ)
	local groundPosition = ray.GroundPosition(randomPosition, {mob}, groundPart)
	if groundPosition == nil then
		return pos
	end

	return groundPosition
end

local function SetAnimation(mob : Model) : (AnimationTrack, AnimationTrack)
	local humanoid = mob:WaitForChild("Humanoid")

	if humanoid:FindFirstChild("Animator") == nil then
		local animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local Walk = Instance.new("Animation")
	Walk.Parent = mob
	Walk.AnimationId = "rbxassetid://180426354"
	local WalkTrack = humanoid:WaitForChild("Animator"):LoadAnimation(Walk)
	WalkTrack.Priority = Enum.AnimationPriority.Idle

	local Idle = Instance.new("Animation")
	Idle.Parent = mob
	Idle.AnimationId = "rbxassetid://180435792"
	local IdleTrack = humanoid:WaitForChild("Animator"):LoadAnimation(Idle)
	IdleTrack.Priority = Enum.AnimationPriority.Idle

	return WalkTrack, IdleTrack
end

local function Wandering_Model(mob : Model, groundPart : Instance)
	local humanoid = mob:WaitForChild("Humanoid")
	local humanoidrootpart = mob:WaitForChild("HumanoidRootPart")
	humanoid.WalkSpeed = WALKSPEED

	local WalkTrack, IdleTrack = SetAnimation(mob)

	while true do
		IdleTrack:Stop()
		WalkTrack:Play()

		local goal = GetRandomPosition(mob, humanoidrootpart.Position, groundPart)
		humanoid:MoveTo(goal)
		humanoid.MoveToFinished:Wait(MOVE_INTERVAL)

		WalkTrack:Stop()
		IdleTrack:Play()
		task.wait(MOVE_INTERVAL)
	end
end

local function Wandering_Part(mob : Part, groundPart : Instance)
	while true do
		local goal = GetRandomPosition(mob, mob.Position, groundPart)
		mob.CFrame = CFrame.lookAt(mob.Position, goal)
		mob.Velocity = (goal - mob.Position).Unit * WALKSPEED * 3
		mob.CFrame += mob.CFrame.LookVector

		task.wait(MOVE_INTERVAL)
	end
end

--Function Name	: Wandering
--Explain		: モブがランダムに歩く
--Arguments| mob		: (Model or Part)動かしたいモブ
--Arguments| groundPart	: (Instance or nil)地面 nilだったらTerrainが地面になる
--Return Value	: none
function randomwalk.Wandering(mob : Model | Part, groundPart : Instance | nil)
	if mob:FindFirstChild("Humanoid") then
		Wandering_Model(mob, groundPart)
	else if mob:IsA("Part") then
		Wandering_Part(mob, groundPart)
	else
		error("[RandomWalk] Invalid Argument")
	end
	end
end

return randomwalk
