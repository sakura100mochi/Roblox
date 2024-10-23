--Name		: CombatSystem
--Explain	: 攻撃システム
local combat = {}

--攻撃範囲
local HIT_DISTANCE = 6
--攻撃範囲の可視化
local HITBOX_VISUALIZER = false

local function Make_HitBox(player)
	local humanoidrootpart = player.Character:FindFirstChild("HumanoidRootPart")
	
	local HitBox = Instance.new("Part")
	HitBox.Size =  Vector3.new(3, 3, HIT_DISTANCE)
	HitBox.CanCollide = false
	HitBox.Parent = game.Workspace
	if HITBOX_VISUALIZER then
		HitBox.Transparency = 0.5
		HitBox.BrickColor = BrickColor.new("Really red")
	else
		HitBox.Transparency = 1
	end	
	
	local weld = Instance.new("Weld", HitBox)
	weld.Part0 = humanoidrootpart
	weld.Part1 = HitBox
	weld.C0 = CFrame.new(0, 0, -HIT_DISTANCE/2)
	
	return HitBox
end

local function Hit(object, damage)
	local debounce = {}
	if object == nil or object.Parent == nil then return end
	local TargetHumanoid = object.Parent:FindFirstChild("Humanoid")
	if TargetHumanoid == nil then return end	
	if table.find(debounce, TargetHumanoid) ~= nil then return end
	table.insert(debounce, TargetHumanoid)

	local HitSound = Instance.new("Sound", object)
	HitSound.SoundId = "rbxassetid://9117969892"
	HitSound.RollOffMode = Enum.RollOffMode.InverseTapered
	HitSound.RollOffMaxDistance = 100
	HitSound.Ended:Connect(function() HitSound:Destroy() end)
	HitSound.Volume = 0.3
	HitSound:Play()
	
	TargetHumanoid:TakeDamage(damage)
end

local function Attack(player, damage)
	if player == nil or player.Character == nil or 
		player.Character:FindFirstChild("HumanoidRootPart") == nil then
		print("There are no character and humanoidrootpart.(CombatSyatem)")
		return
	end
	local HitBox = Make_HitBox(player)
	HitBox.Touched:Connect(function(object)Hit(object, damage)end)
	game.Debris:AddItem(HitBox, 0.5)
end

--Function Name	: make_tool
--Explain		: 攻撃用のtoolを作成する。
--Arguments| healer	: (player) 攻撃するPlayer
--Return Value	: (tool) 作成したtool
function combat.make_tool(player)
	local tool = Instance.new("Tool")
	tool.Name = "Punch"
	tool.RequiresHandle = false
	tool.Parent = player.Backpack

	return tool
end

--Function Name	: Make_RemoteEvent
--Explain		: 攻撃用のRemoteEventを作成する。
--Arguments| 	: none
--Return Value	: (event) 作成したevent
function combat.Make_RemoteEvent()
	local event = Instance.new("RemoteEvent")
	event.Parent = game:GetService("ReplicatedStorage")
	event.Name = "CombatEvent"

	return event
end

--Function Name	: CombatSystem
--Explain		: 攻撃システム
--					下のようなScriptとLocalScriptを配置する必要がある。
--Arguments| player	: (player) 攻撃するPlayer
--Arguments| damage	: (number) 一度の攻撃で与える攻撃力
--Return Value	: none
function combat.CombatSystem(player, damage)
	if damage == nil then
		damage = 5
	end

	Attack(player, damage)
end

return combat

--*****Please put this Script at ServerScriptService*****--

--local lib = require(game:GetService("ReplicatedStorage").Library)
--local combat = lib.combat

--local event = combat.Make_RemoteEvent()

--local function FireCombatEvent(player)
--	combat.CombatSystem(player, nil)
--end

--event.OnServerEvent:Connect(FireCombatEvent)

--*******************************************************--


--*****Please put this LocalScript at StarterPlayerScript*****--

--local lib = require(game:GetService("ReplicatedStorage").Library)
--local combat = lib.combat
--local player = game.Players.LocalPlayer

--wait(1)
--local combattool = combat.make_tool(player)

--local event = nil
--for i = 1, 10 do
--	event = game:GetService("ReplicatedStorage"):FindFirstChild("CombatEvent")
--	if event then
--		break
--	end
--	wait(1)
--end
--if event == nil then
--	print("CombatEvent was not found!(CombatScript)")
--	return
--end

--local function onToolActivated()
--	event:FireServer(player)
--end

--combattool.Activated:Connect(onToolActivated)

--***********************************************************--
