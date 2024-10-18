--Name		: Spawn
--Explain	: モブをスポーンさせる
local spawn = {}

-- ワールド内にスポーンされる最大モブ数
local MAX_SPAWN = 5

local function Check_args(mob, spawnPosition, spawnTime)
	if mob == nil or mob.Parent == nil then
		print("Error: (Spawn) invalid arguments <mob>")
		return false
	elseif mob.Parent ~= game:GetService("ReplicatedStorage") then
		print("Error: (Spawn) invalid arguments <mob> | mob Parent is not ReplicatedStorage")
	end
	local Humanoid = mob:FindFirstChild("Humanoid")
	local HumanoidRootPart = mob:FindFirstChild("HumanoidRootPart")
	if (mob:IsA("Part") or mob:IsA("BasePart")) and mob.Position then
	elseif Humanoid and Humanoid.Health and HumanoidRootPart and HumanoidRootPart.Position then
	else
		print("Error: (Spawn) invalid arguments <mob> | position error")
		return false
	end
	if spawnPosition == nil or typeof(spawnPosition) ~= "Vector3" then
		print("Error: (Spawn) invalid arguments <spawnPosition>")
		return false
	end
	if spawnTime and typeof(spawnTime) ~= "number" then
		print("Error: (Spawn) invalid arguments <spawnTime>")
		return false
	end
	return true
end

local function Make_Folder()
	local newFoler = Instance.new("Folder")
	newFoler.Parent = workspace
	newFoler.Name = "SpawnFolder"

	return newFoler
end

local function SpawnMobNumber(mob, folder)
	local children = folder:GetChildren()
	local num = 0

	for i, child in children do
		if child.Name == mob.Name then
			-- if child:FindFirstChild("Humanoid") and
			-- 	child:FindFirstChild("Humanoid").Health == 0 then
			-- 	child:Destroy()
			-- else
				num = num + 1
			-- end
		end
	end

	return num
end

local function clone_mob(mob, spawnPosition, folder)
	local newMob = mob:Clone()
	newMob.Parent = folder
	if (newMob:IsA("Part") or newMob:IsA("BasePart")) and newMob.Position then
		newMob.Position = spawnPosition
	elseif newMob:FindFirstChild("HumanoidRootPart")
		and newMob:FindFirstChild("HumanoidRootPart").Position then
		newMob:FindFirstChild("HumanoidRootPart").Position = spawnPosition
	end
end

--Function Name	: mobSpawn
--Explain		: モブを一定間隔で特定の位置からスポーンさせる。
--Arguments| mob			: (model or part)スポーンさせたいモブ。Humanoidのあるモブが望ましいが、partでもできる。
--　　　　　　　　　　　　　　　　　　　　　　　　		ReplicatedStorageに配置されているもの。
--Arguments| spawnPosition	: (Vector3)モブをスポーンさせる場所。
--Arguments| spawnTime		: (number)モブをスポーンさせる間隔（秒）指定しなければ、30秒になる。
--Return Value	: none
function spawn.mobSpawn(mob, spawnPosition, spawnTime)
	if Check_args(mob, spawnPosition, spawnTime) == false then return end

	if spawnTime == nil then
		spawnTime = 30
	end
	local folder = Make_Folder()

	while true do
		if SpawnMobNumber(mob, folder) < MAX_SPAWN then
			clone_mob(mob, spawnPosition, folder)
		end
		task.wait(spawnTime)
	end
end

return spawn

--*****example*****--

-- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- local spawn = lib.spawn

-- local mob = game:GetService("ReplicatedStorage").Part
-- local pos = workspace.spawnPart.Position
-- local time = 10


-- spawn.mobSpawn(mob, pos, time)

--*****************--