local BoidType = require(script.Parent.BoidsType)
local BoidSystem = require(script.Parent.BoidSystem)
type BoidSystem = BoidType.BoidSystem

local Boids = {}

-- Constants
local DEFAULT_SETTINGS: BoidSettings = {
	SeparationRadius = 5,      -- How far to keep from other boids
	AlignmentRadius = 10,      -- How far to consider neighbors for alignment
	CohesionRadius = 15,       -- How far to consider neighbors for cohesion
	BoundsCenter = Vector3.new(0, 0, 0),  -- Center of the bounding area
	BoundsSize = Vector3.new(50, 25, 50), -- Size of the bounding area
	MaxSpeed = 10,             -- Maximum movement speed
	MinSpeed = 5,              -- Minimum movement speed
	MaxForce = 1,              -- Maximum steering force
	SeparationWeight = 1.5,    -- How strongly to avoid others
	AlignmentWeight = 1,     -- How strongly to align with others
	CohesionWeight = 1,      -- How strongly to move toward the center
	BoundsWeight = 2,        -- How strongly to stay within bounds
	TargetWeight = 0.5,        -- How strongly to move toward a target (if any)
	WanderWeight = 1.5,        -- How strongly to wander randomly
	ObstacleWeight = 5,      -- How strongly to avoid obstacles
	ObstacleRadius = 15,       -- Distance to check for obstacles
	UpdateFrequency = 1/60     -- How often to update positions
}

function Boids.new(settings: {[string]: any}?): BoidSystem
	local self = setmetatable({}, BoidSystem)

	self.Boids = {}
	self.Settings = settings or {}

	for key, value in DEFAULT_SETTINGS do
		if self.Settings[key] == nil then
			self.Settings[key] = value
		end
	end

	self.Running = false
	self.UpdateConnection = nil

	return self
end

return Boids