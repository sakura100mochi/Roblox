--Name		: Plant
--Explain	: 植物をランダムに植える
local plant = {}
plant.__index = plant

function plant.new(info : table) : table
	local Table = info or {}

	local self = setmetatable({}, plant)
	self.Model = Table.Model or nil
	self.Part = Table.Part or nil
	self.HalfTall = Table.HalfTall or 5
	self.Folder = Table.Folder or workspace
	self.Count = Table.Count or 10
	self.AreaCenter = Table.AreaCenter or Vector3.new(0, 0, 0)
	self.AreaSize = Table.AreaSize or Vector3.new(100, 100, 100)
	self.RaycastLength = Table.RaycastLength or 200
	self.PlaceInstance = Table.PlaceInstance or workspace.Terrain
	self.Material = Table.Material or Enum.Material.Grass
	self.IgnoreList = Table.IgnoreList or {}

	if self.Model == nil and self.Part == nil then
		error("ERROR: Either 'Model' or 'Part' must be provided to plant")
	end

	return self
end

function plant:plants()
	if self.Model == nil and self.Part == nil then
		error("ERROR: No Model or Part to plant")
		return
	end
	local planted = 0
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = self.IgnoreList

	while planted < self.Count do
		local randomX = math.random(self.AreaCenter.X - self.AreaSize.X/2, self.AreaCenter.X + self.AreaSize.X/2)
		local randomZ = math.random(self.AreaCenter.Z - self.AreaSize.Z/2, self.AreaCenter.Z + self.AreaSize.Z/2)
		local position = Vector3.new(randomX, self.AreaCenter.Y + self.AreaSize.Y, randomZ)

		local raycastResult = workspace:Raycast(
			position,
			Vector3.new(0, -self.RaycastLength, 0),
			raycastParams
		)
		if raycastResult and raycastResult.Instance == self.PlaceInstance and raycastResult.Material == self.Material then
			local newPlant = nil
			if self.Model then
				newPlant = self.Model:Clone()
				newPlant:PivotTo(CFrame.new(raycastResult.Position + Vector3.new(0, self.HalfTall, 0)))
			elseif self.Part then
				newPlant = self.Part:Clone()
				newPlant.Position = raycastResult.Position + Vector3.new(0, self.HalfTall, 0)
			end
			newPlant.Parent = self.Folder
			planted = planted + 1
		end
	end
end

return plant
