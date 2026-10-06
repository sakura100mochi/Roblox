--Name		: move
--Explain	: インスタンスを移動させる
local move = {}

--Function Name	: Teleport
--Explain		: インスタンスを一瞬で移動させる
--Arguments| target		: (Instance)ターゲットインスタンス
--Arguments| position	: (Vector3 | CFrame)ターゲットインスタンスを移動させる場所
--Return Value	: (boolean) 成功か失敗か
function move.Teleport(target: Instance, position: (Vector3 | CFrame)): boolean
	if target and position then
		if target:IsA("BasePart") then
			if typeof(position) == "Vector3" then
				target.Position = position
			elseif typeof(position) == "CFrame" then
				target.CFrame = position
			end
			return true
		elseif target:IsA("Model") then
			local cFrame = position
			if typeof(cFrame) == "Vector3" then
				cFrame = CFrame.new(position)
			end
			target:PivotTo(cFrame)
			return true
		end
	end
	return false
end

return move
