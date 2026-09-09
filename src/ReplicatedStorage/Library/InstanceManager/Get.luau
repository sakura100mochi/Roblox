--Name		: get
--Explain	: インスタンスの情報を取得する
local get = {}

--Function Name	: Position
--Explain		: インスタンスのポジションを返す
--Arguments| instance	: (Instance)インスタンス
--Return Value	: (Vector3 | nil) ポジション
function get.Position(instance: Instance): Vector3 | nil
	if instance and instance:IsA("BasePart") then
		return instance.Position
	elseif instance and instance:IsA("Model") then
		return instance:GetPivot().Position
	end
	return nil
end

--Function Name	: Size
--Explain		: インスタンスのサイズを返す
--Arguments| instance	: (Instance)インスタンス
--Return Value	: (Vector3 | nil) サイズ
function get.Size(instance: Instance): Vector3 | nil
	if instance and instance:IsA("BasePart") then
		return instance.Size
	elseif instance and instance:IsA("Model") then
		local _, size = instance:GetBoundingBox()
		return size
	end
	return nil
end

return get
