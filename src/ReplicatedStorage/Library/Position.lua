--Name		: Position
--Explain	: 座標に関する関数
local pos = {}

--Function Name	: get_tool
--Explain		: toolの座標を取得する
--Arguments| tool	: (tool)座標を取得したいツール
--Return Value	: (Vector3)toolの座標
function pos.get_tool(tool)
	if tool:FindFirstChild("Handle") == nil then
		print("Error: (Position) can't get tool position")
		return nil
	end
	return tool:FindFirstChild("Handle").Position
end

--Function Name	: set_tool
--Explain		: toolの座標を設定する
--Arguments| tool		: (tool)座標を設定したいツール
--Arguments| position	: (Vector3)ツールを置きたい座標
--Return Value	: none
function pos.set_tool(tool, position)
	if tool:FindFirstChild("Handle") == nil then
		print("Error: (Position) can't get tool position")
		return nil
	end
	tool:FindFirstChild("Handle").Position = position
end

return pos