local BoidsType = require(script.Parent.BoidsType)
type BoidSettings = BoidsType.BoidSettings

local Boid = {}
Boid.__index = Boid

-- Create a new boid
function Boid.new(instance: Instance, settings: BoidSettings): Boid
	local self = setmetatable({}, Boid)

	if instance:IsA("Model") and instance.PrimaryPart then
		self.Part = instance.PrimaryPart
		self.Model = instance
	else
		self.Part = instance
		self.Model = nil
	end

	self.Velocity = Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)).Unit * math.random(settings.MinSpeed, settings.MaxSpeed)
	self.Acceleration = Vector3.new(0, 0, 0)
	self.Settings = settings
	self.Target = nil

	return self
end

-- Main update function for a boid
function Boid:Update(boids: {Boid}, dt: number): ()
	local separation = self:Separate(boids) * self.Settings.SeparationWeight
	local alignment = self:Align(boids) * self.Settings.AlignmentWeight
	local cohesion = self:Cohere(boids) * self.Settings.CohesionWeight
	local bounds = self:StayInBounds() * self.Settings.BoundsWeight
	local wander = self:Wander() * self.Settings.WanderWeight
	local obstacle = self:AvoidObstacles() * self.Settings.ObstacleWeight

	local target = Vector3.new(0, 0, 0)
	if self.Target then
		target = self:Seek(self.Target) * self.Settings.TargetWeight
	end
	
	self.Acceleration = self.Acceleration + separation + alignment + cohesion + bounds + wander + target + obstacle

	self.Velocity = self.Velocity + self.Acceleration * dt

	if self.Velocity.Magnitude > self.Settings.MaxSpeed then
		self.Velocity = self.Velocity.Unit * self.Settings.MaxSpeed
	elseif self.Velocity.Magnitude < self.Settings.MinSpeed then
		self.Velocity = self.Velocity.Unit * self.Settings.MinSpeed
	end

	if self.Part and self.Part.Parent then
		local newPosition = self.Part.Position + self.Velocity * dt
		local newCFrame = CFrame.lookAt(
			newPosition, 
			newPosition + self.Velocity.Unit
		)

		if self.Model then
			self.Model:PivotTo(newCFrame)
		else
			self.Part.CFrame = newCFrame
		end
	end

	self.Acceleration = Vector3.new(0, 0, 0)
end

-- Separation: steer to avoid crowding local boids
function Boid:Separate(boids: {Boid}): Vector3
	local steer = Vector3.new(0, 0, 0)
	local count = 0

	for _, boid in boids do
		if boid ~= self and boid.Part and boid.Part.Parent then
			local distance = (self.Part.Position - boid.Part.Position).Magnitude

			if distance < self.Settings.SeparationRadius and distance > 0 then
				local diff = (self.Part.Position - boid.Part.Position).Unit
				diff = diff / distance
				steer = steer + diff
				count = count + 1
			end
		end
	end

	if count > 0 then
		steer = steer / count
	end

	if steer.Magnitude > 0 then
		steer = steer.Unit * self.Settings.MaxSpeed
		steer = steer - self.Velocity
		if steer.Magnitude > self.Settings.MaxForce then
			steer = steer.Unit * self.Settings.MaxForce
		end
	end

	return steer
end

-- Alignment: steer towards the average heading of local boids
function Boid:Align(boids: {Boid}): Vector3
	local sum = Vector3.new(0, 0, 0)
	local count = 0

	for _, boid in boids do
		if boid ~= self and boid.Part and boid.Part.Parent then
			local distance = (self.Part.Position - boid.Part.Position).Magnitude

			if distance < self.Settings.AlignmentRadius and distance > 0 then
				sum = sum + boid.Velocity
				count = count + 1
			end
		end
	end

	if count > 0 then
		sum = sum / count
		sum = sum.Unit * self.Settings.MaxSpeed

		local steer = sum - self.Velocity
		if steer.Magnitude > self.Settings.MaxForce then
			steer = steer.Unit * self.Settings.MaxForce
		end
		return steer
	else
		return Vector3.new(0, 0, 0)
	end
end

-- Cohesion: steer to move toward the average position of local boids
function Boid:Cohere(boids: {Boid}): Vector3
	local sum = Vector3.new(0, 0, 0)
	local count = 0

	for _, boid in boids do
		if boid ~= self and boid.Part and boid.Part.Parent then
			local distance = (self.Part.Position - boid.Part.Position).Magnitude

			if distance < self.Settings.CohesionRadius and distance > 0 then
				sum = sum + boid.Part.Position
				count = count + 1
			end
		end
	end

	if count > 0 then
		sum = sum / count
		return self:Seek(sum)
	else
		return Vector3.new(0, 0, 0)
	end
end

-- Seek: steer towards a target position
function Boid:Seek(targetPos: Vector3): Vector3
	local desired = targetPos - self.Part.Position

	if desired.Magnitude > 0 then
		desired = desired.Unit * self.Settings.MaxSpeed

		local steer = desired - self.Velocity
		if steer.Magnitude > self.Settings.MaxForce then
			steer = steer.Unit * self.Settings.MaxForce
		end
		return steer
	else
		return Vector3.new(0, 0, 0)
	end
end

-- Stay within bounds
function Boid:StayInBounds(): Vector3
	local steer = Vector3.new(0, 0, 0)
	local halfSize = self.Settings.BoundsSize / 2
	local center = self.Settings.BoundsCenter
	local position = self.Part.Position

	-- X boundaries
	if position.X < center.X - halfSize.X then
		steer = steer + Vector3.new(1, 0, 0)
	elseif position.X > center.X + halfSize.X then
		steer = steer + Vector3.new(-1, 0, 0)
	end

	-- Y boundaries
	if position.Y < center.Y - halfSize.Y then
		steer = steer + Vector3.new(0, 1, 0)
	elseif position.Y > center.Y + halfSize.Y then
		steer = steer + Vector3.new(0, -1, 0)
	end

	-- Z boundaries
	if position.Z < center.Z - halfSize.Z then
		steer = steer + Vector3.new(0, 0, 1)
	elseif position.Z > center.Z + halfSize.Z then
		steer = steer + Vector3.new(0, 0, -1)
	end

	if steer.Magnitude > 0 then
		steer = steer.Unit * self.Settings.MaxSpeed
		steer = steer - self.Velocity
		if steer.Magnitude > self.Settings.MaxForce then
			steer = steer.Unit * self.Settings.MaxForce
		end
	end

	return steer
end

-- Random wandering behavior
function Boid:Wander(): Vector3
	local wanderRadius = 2
	local wanderDistance = 5
	local wanderJitter = 0.5

	local randomVec = Vector3.new(
		math.random() * 2 - 1,
		math.random() * 2 - 1,
		math.random() * 2 - 1
	) * wanderJitter

	local wanderDirection = (self.Velocity.Unit * wanderDistance) +
		(randomVec.Unit * wanderRadius)

	return self:Seek(self.Part.Position + wanderDirection)
end

-- Avoid obstacles using raycasting
function Boid:AvoidObstacles(): Vector3
	local steer = Vector3.new(0, 0, 0)

	local direction = self.Velocity.Unit
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = {self.Model or self.Part}

	local forwardResult = workspace:Raycast(
		self.Part.Position,
		direction * self.Settings.ObstacleRadius,
		raycastParams
	)

	local downResult = workspace:Raycast(
		self.Part.Position,
		Vector3.new(0, -self.Settings.ObstacleRadius, 0),
		raycastParams
	)

	if forwardResult then
		local distanceToObstacle = forwardResult.Distance
		local avoidanceStrength = 1 - (distanceToObstacle / self.Settings.ObstacleRadius)
		local normal = forwardResult.Normal

		local avoidanceForce = normal * self.Settings.MaxSpeed * avoidanceStrength
		steer = steer + avoidanceForce
	end

	if downResult then
		local distanceToFloor = downResult.Distance
		local minHeightAboveGround = 4 

		if distanceToFloor < minHeightAboveGround then
			local upStrength = (1 - (distanceToFloor / minHeightAboveGround)) * self.Settings.MaxSpeed
			steer = steer + Vector3.new(0, upStrength, 0)
		end
	end

	if steer.Magnitude > 0 then
		if steer.Magnitude > self.Settings.MaxForce then
			steer = steer.Unit * self.Settings.MaxForce
		end
	end

	return steer
end

return Boid