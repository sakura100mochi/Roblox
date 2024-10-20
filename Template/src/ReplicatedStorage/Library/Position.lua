local pos = {}

function pos.get_tool(tool)
	if tool:FindFirstChild("Handle") == nil then
		print("Error: (Position) can't get tool position")
		return nil
	end
	return tool:FindFirstChild("Handle").Position
end

function pos.set_tool(tool, position)
	if tool:FindFirstChild("Handle") == nil then
		print("Error: (Position) can't get tool position")
		return nil
	end
	tool:FindFirstChild("Handle").Position = position
end

return pos