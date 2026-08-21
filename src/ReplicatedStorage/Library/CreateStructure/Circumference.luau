--Name		: Circumference
--Explain	: 円周を囲むパーツを作成する
local Circumference = {}

--円の半径
Circumference.RADIUS = 30
--円の中心
Circumference.CENTER = Vector3.new(0, 0, 0)
--壁のPositionのY座標
Circumference.WALL_YPOS = 7.5
--壁のサイズ
Circumference.WALL_SIZE = Vector3.new(10, 15, 1)
--壁の色
Circumference.WALL_COLOR = Color3.fromRGB(66, 66, 66)
--壁のマテリアル
Circumference.WALL_MATERIAL = Enum.Material.SmoothPlastic
--壁の名前
Circumference.WALL_NAME = "Wall"

--Function Name	: create
--Explain		: 円周を囲むパーツを作成する
--Arguments		: none
--Return Value	: none
function Circumference.create()
	local wall_count = math.ceil((2 * math.pi * Circumference.RADIUS) / Circumference.WALL_SIZE.X)

	for i = 1, wall_count do
		local angle = (i - 1) / wall_count * math.pi * 2

		local x = math.cos(angle) * Circumference.RADIUS
		local z = math.sin(angle) * Circumference.RADIUS

		local wall = Instance.new("Part")
		wall.Size = Circumference.WALL_SIZE
		wall.Color = Circumference.WALL_COLOR
		wall.Anchored = true
		wall.Name = Circumference.WALL_NAME .. "_" .. i
		wall.Position = Circumference.CENTER + Vector3.new(x, Circumference.WALL_YPOS, z)
		wall.Material = Enum.Material.SmoothPlastic
		wall.CFrame = CFrame.lookAt(
			wall.Position,
			Circumference.CENTER + Vector3.new(0, Circumference.WALL_YPOS, 0)
		)
		wall.Parent = workspace
	end
end

return Circumference

--*****Please put this in a ServerScript*****--

-- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- local createStructure = lib.createStructure

-- createStructure.Circumference.create()

--***********************************************************--
