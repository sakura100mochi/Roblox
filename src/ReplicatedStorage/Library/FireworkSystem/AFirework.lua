--Name		: AFirework
--Explain	: 基本の花火の設計図　親クラス　抽象クラス
local AFirework = {}
AFirework.__index = AFirework

AFirework.Colors = {
	["Li"] = Color3.fromHex("#ff2167"),
	["Na"] = Color3.fromHex("#ff5601"),
	["K"] = Color3.fromHex("#ff4ed6"),
	["Rb"] = Color3.fromHex("#6011b9"),
	["Cs"] = Color3.fromHex("#8952ff"),
	["Ca"] = Color3.fromHex("#ff8000"),
	["Sr"] = Color3.fromHex("#ff2600"),
	["Ba"] = Color3.fromHex("#a4fdff"),
	["Cu"] = Color3.fromHex("#4bbc58"),
	["C"] = Color3.fromHex("#ec8b46"),
	["Al"] = Color3.fromHex("#b2c4d1"),
	["Mg"] = Color3.fromHex("f5f5f4")
}

local function makeStorage() : Folder
	local StorageFolder = game.ReplicatedStorage:FindFirstChild("FireworkSystemStorage")
	if StorageFolder == nil then
		StorageFolder = Instance.new("Folder")
		StorageFolder.Parent = game.ReplicatedStorage
		StorageFolder.Name = "FireworkSystemStorage"
	end

	return StorageFolder
end

--Function Name	: new
--Explain		: コンストラクタ　子クラスからのみ呼び出し可能
--Arguments| Table	: (table)Tableの値を設定する。値がない場合はデフォルト値にする
--Return Value	: (table) 設定した後のtable
function AFirework.new(Origin : table, Table : table) : table
	if Origin == nil then
		error("ERROR: Abstract class 'AFirework' cannot be instantiated")
	end

	Table = Table or {}

	local self = setmetatable({}, AFirework)
	self.Type = Table.Type or Origin.Type or "AFirework"
	self.Parent = Table.Parent or Origin.Parent or workspace
	self.Start_CFrame = Table.Start_CFrame or Origin.Start_CFrame or CFrame.new(Vector3.new(0, 0, 0))
	self.Color1 = Table.Color1 or Origin.Color1 or AFirework.Colors.C
	self.Color2 = Table.Color2 or Origin.Color2 or nil
	self.Color3 = Table.Color3 or Origin.Color3 or nil
	self.Color4 = Table.Color4 or Origin.Color4 or nil
	self.Color5 = Table.Color5 or Origin.Color5 or nil
	self.NoboriTime = Table.NoboriTime or Origin.NoboriTime or math.random(15, 30) / 10
	self.ExplodeTime = Table.ExplodeTime or Origin.ExplodeTime or 1
	self.ExplodeSpeed = Table.ExplodeSpeed or Origin.ExplodeSpeed or NumberRange.new(300, 320)
	self.Storage = Table.Storage or Origin.Storage or makeStorage()

	return self
end

function AFirework:launch()
	error("ERROR: Abstract method — must be implemented in subclass")
end

function AFirework:launchRandom()
	error("ERROR: Abstract method — must be implemented in subclass")
end

function AFirework:AutoSystem()
	error("ERROR: Abstract method — must be implemented in subclass")
end

return AFirework
