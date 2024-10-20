--Name		: Class
--Explain	: 設計図
local class = {}

local classPrototype = {
	Name = "class",
	Color = BrickColor.random(),
	Size = Vector3.new(4, 4, 4),
	Position = Vector3.new(0, 0, 0),
	Description = "Default"
}

class.__index = class

--Function Name	: new
--Explain		: Tableの値を設定する。値がない場合はPrototypeで指定されているデフォルト値にする
--Arguments| Table	: (table)
--Return Value	: (table) 設定した後のtable
function class.new(Table)
	local newTable = setmetatable(Table or {}, class)
	newTable.Name = newTable.Name or classPrototype.Name
	newTable.Color = newTable.Color or classPrototype.Color
	newTable.Size = newTable.Size or classPrototype.Size
	newTable.Position = newTable.Position or classPrototype.Position
	newTable.Description = newTable.Description or classPrototype.Description

	return newTable
end

--Function Name	: create
--Explain		: Tableで指定された値にのっとってPartを生成する。
--Arguments| Table	: (table)
--Return Value	: (table) 生成されたPart
function class.create(Table)
	local newPart = Instance.new("Part")
	newPart.Parent = workspace
	newPart.Name = Table.Name
	newPart.BrickColor = Table.Color
	newPart.Size = Table.Size
	newPart.Position = Table.Position

	return newPart
end

return class