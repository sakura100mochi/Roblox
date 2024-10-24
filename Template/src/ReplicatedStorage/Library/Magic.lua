--Name		: Magic
--Explain	: 遠距離魔法
local magic = {}

-- 魔法の射程距離
local MAGIC_DISTANCE = 50

local function Check_args(wizard, effect, sound, damage, range)
	if wizard == nil or wizard.Character == nil 
		or wizard.Character:FindFirstChild("Humanoid") == nil 
		or wizard.Character:FindFirstChild("HumanoidRootPart") == nil then
		print("Error: (Magic) invalid arguments <wizard>")
		return false
	end
	if effect then
		if effect.Parent ~= game:GetService("ReplicatedStorage") then
			print("Error: (Magic) invalid arguments <effect> | effect Parent is not ReplicatedStorage")
			return false
		elseif effect.Position == nil then
			print("Error: (Magic) invalid arguments <effect>")
			return false
		end
	end
	if sound and sound:IsA("Sound") == false then
		print("Error: (Magic) invalid arguments <sound>")
		return false
	end
	if damage and typeof(damage) ~= "number" then
		print("Error: (Magic) invalid arguments <damage>")
		return false
	elseif damage and (damage > 100 or damage < 1) then
		print("Error: (Magic) damage is too large or too small")
		return false
	end
	if range and typeof(range) ~= "number" then
		print("Error: (Magic) invalid arguments <range>")
		return false
	elseif range and (range > 1000 or range < 1) then
		print("Error: (Magic) range is too large or too small")
		return false
	end
	return true
end

local function Make_Effect()
	local effect = Instance.new("Explosion")
	effect.Parent = game:GetService("ReplicatedStorage")
	effect.Name = "Magic_DefaultEffect"
	
	return effect
end

local function Make_Sound()
	local sound = Instance.new("Sound")
	sound.Parent = game:GetService("SoundService")
	sound.Name = "Magic_DefaultSound"
	sound.SoundId = "rbxassetid://5801257793"
	sound.Volume = 0.2

	return sound
end

local function Make_HitBox(effect, range)
	local HitBox = Instance.new("Part")
	HitBox.Parent = effect
	HitBox.Size = Vector3.new(range, 3, range)
	HitBox.CanCollide = false
	HitBox.BrickColor = BrickColor.new("Bright red")
	HitBox.Transparency = 1
	HitBox.Position = effect.Position
	
	return HitBox
end

local function Hit(object, wizard, effect, damage, range)
	local debounce = {}
	if object == nil or object.Parent == nil then return end
	if object.Parent.Name and object.Parent.Name == wizard.Name then return end
	local TargetHumanoid = object.Parent:FindFirstChild("Humanoid")
	local TargetRootPart = object.Parent:FindFirstChild("HumanoidRootPart")
	if TargetHumanoid == nil or TargetRootPart == nil then return end	
	if table.find(debounce, TargetHumanoid) ~= nil then return end
	table.insert(debounce, TargetHumanoid)

	local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
	local calc = lib.calc
	local distance = calc.distance(TargetRootPart.Position, effect.Position)
	if distance <= range then
		TargetHumanoid:TakeDamage(damage)
	end
end

local function Attack(wizard, effect, sound, damage, range)
	local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
	local ray = lib.ray
	local humanoidrootpart = wizard.Character:FindFirstChild("HumanoidRootPart")

	effect.Parent = game.Workspace

	local rayResult = ray.Raycasting(humanoidrootpart.Position, nil, humanoidrootpart.CFrame.LookVector * MAGIC_DISTANCE, {wizard})
	if rayResult == nil then
		local targetPosition = humanoidrootpart.Position + (humanoidrootpart.CFrame.LookVector * MAGIC_DISTANCE)
		effect.Position = targetPosition
	else
		effect.Position = rayResult.Position
	end

	sound:Play()

	local HitBox = Make_HitBox(effect, range)
	HitBox.Touched:Connect(function(object)Hit(object, wizard, effect, damage, range)end)
	game.Debris:AddItem(HitBox, 0.5)
	task.wait(3)

	sound:stop()

	effect.Parent = game:GetService("ReplicatedStorage")
end

--Function Name	: Magic
--Explain		: 遠距離魔法を発射する。wizardの目線の先50マスに障害物があればその地点、なければ50マス先で魔法が発動する
--Arguments| wizard	: (player)魔法を発動する魔法使い
--Arguments| effect	: (effect or model or part)魔法のエフェクト。指定しなければ、爆発になる。
--　　　　　　　　　　　　　　　　　　　　　　　　　　　PositionのPropertyがあり、ReplicatedStorageに配置されているもの。
--Arguments| sound	: (sound)魔法の音。指定しなけれな、爆発音になる。
--Arguments| damage	: (number)魔法で与えるダメージ量。指定しなければ、30になる。
--Arguments| range	: (number)魔法の着弾地点から半径何マス分の敵にダメージを与えるか。指定しなければ、15になる。
--Return Value	: none
function magic.Magic(wizard, effect, sound, damage, range)
	if Check_args(wizard, effect, sound, damage) == false then return end

	if effect == nil then
		effect = Make_Effect()
	end
	if sound == nil then
		sound = Make_Sound()
	end
	if damage == nil then
		damage = 30
	end
	if range == nil then
		range = 15
	end

	Attack(wizard, effect, sound, damage, range)
end

return magic

--*****チャットで発動したい場合は、次のScriptをServerScriptServiceに入れてください。*****--

-- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- local magic = lib.magic
-- local Players = game:GetService("Players")

-- Players.PlayerAdded:Connect(function(player)
-- 	player.Chatted:Connect(function(Message)
-- 		if Message == "Magic" then
-- 			magic.Magic(player, nil, nil, nil, nil)
-- 		end
-- 	end)
-- end)

--******************************************************************************--