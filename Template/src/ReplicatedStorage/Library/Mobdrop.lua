--Name		: Mobdrop
--Explain	: モブドロップ
local drop = {}

local function Check_args(mob, dropItem)
	if mob == nil or mob:FindFirstChild("Humanoid") == nil
		or mob:FindFirstChild("HumanoidRootPart") == nil
		or mob:FindFirstChild("Humanoid").Health == nil then
		print("Error: (Mobdrop) invalid arguments <mob>")
		return false
	end
	if dropItem == nil then
		print("Error: (Mobdrop) invalid arguments <dropItem>")
		return false
	elseif dropItem.Parent ~= game:GetService("ReplicatedStorage") then
		print("Error: (Mobdrop) invalid arguments <dropItem> | dropItem Parent is not ReplicatedStorage")
		return false
	end
	local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
	local pos = lib.pos
	if dropItem:IsA("Tool") and pos.get_tool(dropItem)  then
	elseif dropItem:IsA("Tool") == false and dropItem.Position then
	else
		print("Error: (Mobdrop) invalid arguments <dropItem>")
		return false
	end
	return true
end

local function Item_drop(mob, dropItem)
	local Position = mob:FindFirstChild("HumanoidRootPart").Position

	local itemFolder = workspace:FindFirstChild("DropItem")
	if itemFolder == nil then
		itemFolder = Instance.new("Folder")
		itemFolder.Parent = workspace
		itemFolder.Name = "DropItem"
	end

	local newitem = dropItem:Clone()
	newitem.Parent = itemFolder
	local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
	local pos = lib.pos
	if dropItem:IsA("Tool") and pos.get_tool(dropItem) then
		pos.set_tool(dropItem, Position)
	elseif dropItem:IsA("Tool") == false and dropItem.Position then
		dropItem.Position = Position
	end
end

--Function Name	: Mobdrop
--Explain		: モブが死んだ時にアイテムをドロップする
--Arguments| mob		: (model)アイテムをドロップさせたいモブ。Humanoidが必要。
--Arguments| dropItem	: (model or part)ドロップするアイテム。
--　　　　　　　　　　　　　　　　　　　　　　　　PositionのPropertyがあり、ReplicatedStorageに配置されているもの。
--Return Value	: none
function drop.Mobdrop(mob, dropItem)
	if Check_args(mob, dropItem) == false then return end

	local Humanoid = mob:FindFirstChild("Humanoid")
	while true do
		if Humanoid.Health == 0 then
			Item_drop(mob, dropItem)
			break
		end
		task.wait(1)
	end
end

return drop

--*****example*****--

-- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- local drop = lib.drop

-- local mob = script.Parent
-- local item = game:GetService("ReplicatedStorage").Part

-- drop.Mobdrop(mob, item)

--*****************--