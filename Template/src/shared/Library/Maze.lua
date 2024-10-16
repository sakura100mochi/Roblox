--Name		: Maze
--Explain	: 迷路
local maze = {}

local MapSize = 70
local WallSize = 2
local RoadSize = 5

local function goal_touched(object)
	local humanoid = object.Parent:FindFirstChild("Humanoid")
	if humanoid then
		print('goal')
	end
end

local function init_folder()
	local folder = Instance.new("Folder")
	folder.Parent = game.Workspace
	folder.Name = "Maze"
	return folder
end

local function init_startpart()
	local start = workspace.SpawnLocation
	start.Size = Vector3.new(RoadSize, 1, RoadSize)
	return start
end

local function init_goalpart(folder)
	local goal = Instance.new("Part")
	goal.Parent = folder
	goal.Name = "Goal"
	goal.Size = Vector3.new(RoadSize, 0.5, RoadSize)
	goal.BrickColor = BrickColor.new("Bright red")
	goal.Anchored = true
	
	goal.Touched:Connect(goal_touched)
	return goal
end

local function init_wallpart(folder)
	local wall = Instance.new("Part")
	wall.Parent = folder
	wall.Name = "Wall"
	wall.Size = Vector3.new(WallSize,10,WallSize)
	wall.Position = Vector3.new(0, 5, 0)
	wall.Anchored = true
	return wall
end

local function clone_wall(vector, wall, folder)
	local clonedPart = wall:Clone()
	clonedPart.Position = wall.Position + vector
	clonedPart.Parent = folder
end

local function make_wall(x, y, dir, wall)
	local i = 0
	while i < RoadSize + WallSize do
		if dir == 0 then
			clone_wall(Vector3.new(x + i, 0, y), wall)
		elseif dir == 1 then
			clone_wall(Vector3.new(x, 0, y + i), wall)
		elseif dir == 2 then
			clone_wall(Vector3.new(x - i, 0, y), wall)
		elseif dir == 3 then
			clone_wall(Vector3.new(x, 0, y - i), wall)
		end
		i += WallSize
	end
end

local function init_wall(wall)
	local x = 0
	while x <= MapSize do
		local y = 0
		while y <= MapSize do
			if x == 0 or x == MapSize or y == 0 or y == MapSize then
				clone_wall(Vector3.new(x, 0, y), wall)
			end
			y += WallSize
		end
		x += WallSize
	end
end

local function make_maze (wall)
	local x = WallSize + RoadSize
	while x < MapSize do
		local y = WallSize + RoadSize
		while y < MapSize do
			clone_wall(Vector3.new(x, 0, y), wall)
			local rand = math.random(0,3)
			make_wall(x, y, rand, wall)
			y += WallSize + RoadSize
		end
		x += WallSize + RoadSize
	end
end

local function make_start_goal(start, goal)
	local start_x = math.random(WallSize, MapSize - WallSize)
	local start_y = math.random(WallSize, MapSize - WallSize)
	start_x += ((WallSize / 2) + (RoadSize / 2)) - (start_x % (WallSize + RoadSize))
	start_y += ((WallSize / 2) + (RoadSize / 2)) - (start_y % (WallSize + RoadSize))
	start.Position = Vector3.new(start_x, 0.5, start_y)
	while true do
		local goal_x = math.random(WallSize, MapSize - WallSize)
		local goal_y = math.random(WallSize, MapSize - WallSize)
		goal_x += ((WallSize / 2) + (RoadSize / 2)) - (goal_x % (WallSize + RoadSize))
		goal_y += ((WallSize / 2) + (RoadSize / 2)) - (goal_y % (WallSize + RoadSize))
		if goal_x ~= start_x and goal_y ~= start_y then
			goal.Position = Vector3.new(goal_x, 0, goal_y)
			break
		end
	end
end

--Function Name	: Maze
--Explain		: 迷路をつくる
--Arguments| mapsize	: (number)マップのサイズ。なかったら70で作られる。
--Return Value	: none
function maze.Maze(mapsize)
	if mapsize then
		MapSize = mapsize
	end
	local folder = init_folder()
	local start = init_startpart()
	local goal = init_goalpart(folder)
	local wall = init_wallpart(folder)
	init_wall(wall)
	make_maze(wall)
	make_start_goal(start, goal)
end

return maze
