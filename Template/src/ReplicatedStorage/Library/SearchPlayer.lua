--Name		: SearchPlayer
--Explain	: Playerを探す
local sp = {}

--Function Name	: searchPlayer
--Explain		: positionからsearch_rangeの範囲内にいる一番近くのプレーヤーを返す
--Arguments| position		: (Vector3)座標
--Arguments| search_range	: (Number)検索範囲　例)50
--Return Value	: (Player object) 一番近くにいるPlayerを返す。search_rangeにPlayerがいなかったらnilを返す。
function sp.SearchPlayer(position, search_range)
	local Players = game:GetService("Players")
	local players = Players:GetPlayers()
	local targetPlayer = nil
	local targetDistance = math.huge

	if position == nil or search_range == 0  then
		print("SearchPlayer Error: invalid arguments")
		return nil
	end
	
	for i,player in pairs(players) do
		local character = player.Character
		if character  and character:FindFirstChild("Humanoid") then
			local distance = player:DistanceFromCharacter(position)
			if distance < targetDistance then
				targetPlayer = player
				targetDistance = distance
			end
		end
	end
	if targetDistance > search_range then
		return nil
	end
	return targetPlayer
end

return sp
