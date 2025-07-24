-- Level 3
-- Top Operator Permissions

local OP = {
	YuiYui_R = {
		UserId = 5526920856,
		Level = 3,
	},
	sozow_tarou = {
		UserId = 5159833312,
		Level = 3,
	}
}

function OP:checkOPLevel(playerName: string, playerUserId: number, necessarylevel: number): boolean
	local player = self[playerName]
	if not player or player.UserId ~= playerUserId then
		return false
	end
	return player.Level >= necessarylevel
end

function OP:addOP(playerName: string, playerUserId: number, targetName: string, targetUserId: number, level: number)
	if self:checkOPLevel(playerName, playerUserId, 3) == false then
		return false
	end
	OP[targetName] = {
		UserId = targetUserId,
		Level = level,
	}
	return true
end

function OP:removeOP(playerName: string, playerUserId: number, targetName: string, targetUserId: number)
	if self:checkOPLevel(playerName, playerUserId, 3) == false then
		return false
	end
	if OP[targetName] and OP[targetName].UserId == targetUserId then
		OP[targetName] = nil
		return true
	end
	return false
end

return OP