--Name		: Model_Weld
--Explain	: モデルの中のパーツをくっつける
local weld = {}

local function getTouchingParts(part)
	local connection = part.Touched:Connect(function() end)
	local results = part:GetTouchingParts()
	connection:Disconnect()
	return results
end

local function Parts_Weld(part, touchingParts)
	for _,obj in pairs(touchingParts) do
		local weld = Instance.new("WeldConstraint")
		weld.Parent = obj
		weld.Part0 = part
		weld.Part1 = obj
	end
end

--Function Name	: Model_Weld
--Explain		: 浮いているモデルをくっつける
--Arguments| model	: (Model object)くっつけたいモデル
--Return Value	: none
function weld.Model_Weld(model)
	local descendants = model:GetDescendants()
	local range = 10
	
	for _, obj in pairs(descendants) do
		if obj:IsA("Part") then
			obj.Size = obj.Size + Vector3.new(range,range,range)
			wait(0.1)
			Parts_Weld(obj,obj:GetTouchingParts())
			obj.Size = obj.Size + Vector3.new(-range,-range,-range)
		end
	end
end

return weld
