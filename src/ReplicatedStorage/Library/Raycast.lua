--Name		: Raycast
--Explain	: Raycasting
local ray = {}

--Function Name	: Raycasting
--Explain		: https://create.roblox.com/docs/workspace/raycasting
--Arguments| rayOrigin		: (Vector3)Rayを発射する元
--Arguments| rayDestination	: (Vector3)Rayを発射する目的地
--Arguments| rayDirection	: (Vector3)Rayを発射する方向
--Arguments| ignoreList		: (Table of objects)Rayがあたる物体に含めないもの
--Return Value	: (RaycastResult)raycastResult
function ray.Raycasting(rayOrigin : Vector3, rayDestination : Vector3, rayDirection : Vector3, ignoreList : table | Object) : RaycastResult
	local raycastResult = nil

	if rayOrigin == nil or (rayDestination == nil and rayDirection == nil) then
		print("Raycasting Error: invalid arguments")
		return nil
	end

	if rayDirection == nil then
		rayDirection = rayDestination - rayOrigin
	end

	if rayDestination == nil then
		rayDestination = rayOrigin + rayDirection
	end

	if ignoreList ~= nil then
		local raycastParams = RaycastParams.new()
		raycastParams.FilterDescendantsInstances = ignoreList
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
	else
		raycastResult = workspace:Raycast(rayOrigin, rayDirection)
	end

	return raycastResult
end

--Function Name	: GroundPosition
--Explain		: 地面の位置を返す
--Arguments| position		: (Vector3)地面の位置を調べたい座標
--Arguments| ignoreList		: (Table of objects)Rayがあたる物体に含めないもの
--Return Value	: (Vector3 or nil)positionの地面の位置の座標。positionの高さ-50~50に地面がなかったらnilを返す。
function ray.GroundPosition(position : Vector3, ignoreList : table | Object) : Vector3 | nil
	local rayOrigin = position + Vector3.new(0, 50, 0)
	local rayDirection = Vector3.new(0, -100, 0)
	local raycastResult = ray.Raycasting(rayOrigin, nil, rayDirection, ignoreList)

	for i = 0, 10 do
		if raycastResult == nil then
			return nil
		elseif raycastResult.Instance:IsA("Terrain") == false and raycastResult.Instance.Name ~= "Baseplate" then
			raycastResult = ray.Raycasting(raycastResult.Position, nil, rayDirection, ignoreList)
		else
			return raycastResult.Position
		end
	end
	return nil
end

--Function Name	: CheckObstacles
--Explain		: rayOriginからrayDestiationにRayを発射して、ぶつかった地点の座標を返す。
--					ぶつからなかったら、rayDestiationを返す。
--Arguments| rayOrigin		: (Vector3)Rayを発射する元
--Arguments| rayDestination	: (Vector3)Rayを発射する目的地
--Arguments| ignoreList		: (Table of objects)Rayがあたる物体に含めないもの
--Return Value	: (Vector3) ぶつかった地点の座標またはrayDestiationの座標
function ray.CheckObstacles(rayOrigin : Vector3, rayDestiation : Vector3, ignoreList : table | Object) : Vector3
	local raycastResult = ray.Raycasting(rayOrigin, rayDestiation, nil, ignoreList)

	if raycastResult == nil then
		return rayDestiation
	end
	return raycastResult.Position
end

return ray
