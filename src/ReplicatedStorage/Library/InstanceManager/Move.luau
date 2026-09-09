--Name		: move
--Explain	: インスタンスを移動させる
local move = {}

--Function Name	: Teleport
--Explain		: インスタンスを一瞬で移動させる
--Arguments| target		: (Instance)ターゲットインスタンス
--Arguments| position	: (Vector3)ターゲットインスタンスを移動させる場所
--Return Value	: (boolean) 成功か失敗か
function move.Teleport(target: Instance, position: Vector3): boolean
	if target and position and typeof(position) == "Vector3" then
		if target:IsA("BasePart") then
			target.Position = position
			return true
		elseif target:IsA("Model") then
			target:PivotTo(CFrame.new(position))
			return true
		end
	end
	return false
end

return move
