--Name		: HealSystem
--Explain	: 回復システム
local heal = {}

--回復する時間。
local HEAL_TIME = 7

local function HealingEffect(healer)
	local effect = game:GetService("ReplicatedStorage").Skill_Cleric.Heal_effect
	
	effect.HumanoidRootPart.Bottom.Parent = healer.Character.HumanoidRootPart
	effect.HumanoidRootPart.Top.Parent = healer.Character.HumanoidRootPart
end

local function finish_Heal(healer)
	local effect = game:GetService("ReplicatedStorage").Skill_Cleric.Heal_effect

	healer.Character.HumanoidRootPart.Bottom.Parent = effect.HumanoidRootPart
	healer.Character.HumanoidRootPart.Top.Parent = effect.HumanoidRootPart
end

local function Heal(healer, amount)
	if healer.Character == nil or healer.Character:FindFirstChild("HumanoidRootPart") == nil 
		or healer.Character:FindFirstChild("Humanoid") == nil then
		print("There are no character and humanoidrootpart and humanoid.(HealSystem)")
		return
	end
	if game:GetService("ReplicatedStorage"):FindFirstChild("Skill_Cleric") == nil or
		game:GetService("ReplicatedStorage"):FindFirstChild("Skill_Cleric"):FindFirstChild("Heal_effect") == nil then
		print("There are no Heal effects.(HealSystem)")
		return
	end

	print(healer.Name, " is Healing")
	HealingEffect(healer)
	local humanoid = healer.Character:FindFirstChild("Humanoid")
	for i = 1, HEAL_TIME do
		humanoid.Health = math.min(humanoid.MaxHealth, humanoid.Health + amount)
		task.wait(1)
	end
	finish_Heal(healer)
end

--Function Name	: make_tool
--Explain		: 回復用のtoolを作成する。
--Arguments| healer	: (player) 回復するPlayer
--Return Value	: (tool) 作成したtool
function heal.make_tool(healer)
	local tool = Instance.new("Tool")
	tool.Name = "Healing Item"
	tool.RequiresHandle = false
	tool.TextureId = "rbxassetid://527172247"
	tool.Parent = healer.Backpack

	return tool
end

--Function Name	: HealSystem
--Explain		: 自分自身の体力を回復する。
--					下のようなスクリプトをLocalScriptに配置する必要がある。
--Arguments| healer	: (player) 回復するPlayer
--Arguments| amount	: (number) 一秒間に回復する量
--Return Value	: none
function heal.HealSystem(healer, amount)
	if  amount == nil then
		amount = 5
	end
	
	Heal(healer, amount)
end

return heal

--*****Please put this LocalScript at StarterPlayerScript*****--

--local lib = require(game:GetService("ReplicatedStorage").Library)
--local heal = lib.heal
--local player = game.Players.LocalPlayer

--wait(1)
--local tool = heal.make_tool(player)

--local function onToolActivated()
--	heal.HealSystem(player, nil)
--end

--tool.Activated:Connect(onToolActivated)

--***********************************************************--