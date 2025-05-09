--Name		: Caluculation
--Explain	: 計算
local calc = {}

--Function Name	: distance
--Explain		: 地点A、Bの距離を返す
--Arguments| A	: (Vector3)地点Aの座標
--Arguments| B	: (Vector3)地点Bの座標
--Return Value	: (number) 距離
function calc.distance(A : Vector3, B : Vector3) : number
	local distance = 0

	if A == nil or B == nil then
		print("Caluculation.distance Error: invalid arguments")
		return 0
	end
	distance = math.sqrt((A.X - B.X) ^ 2 + (A.Y - B.Y) ^ 2 + (A.Z - B.Z) ^ 2)
	return distance
end

return calc
