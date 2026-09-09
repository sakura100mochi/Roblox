--[[
	getCheckpoints - A utility function to get all the checkpoints for a moving platform and
	ensure they are all in order.
--]]

local function getCheckpoints(platformContainer: Instance): { BasePart }
	local checkpointsFolder = platformContainer:FindFirstChild("Checkpoints")
	assert(checkpointsFolder, `No Checkpoints in {platformContainer:GetFullName()}`)

	-- Make sure all the checkpoints exist
	local checkpoints = {}
	local numCheckpoints = #checkpointsFolder:GetChildren()
	if numCheckpoints < 2 then
		error(checkpointsFolder, `Checkpoints need at least 2 points`)
	end
	for i = 1, numCheckpoints do
		local checkpoint = checkpointsFolder:FindFirstChild(`Checkpoint{i}`)
		assert(checkpoint, `{platformContainer:GetFullName()} missing checkpoint: Checkpoint{i}`)
		if not checkpoint:IsA("BasePart") or checkpoint.Anchored == false then
			error(checkpoint, `Checkpoint{i} must be a BasePart and anchored.`)
		end
		table.insert(checkpoints, checkpoint)
	end

	return checkpoints
end

return getCheckpoints
