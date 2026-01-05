local RunService = game:GetService("RunService")

local BoidType = require(script.Parent.BoidsType)
local Boid = require(script.Parent.Boid)
type Boid = BoidType.Boid

local BoidSystem = {}
BoidSystem.__index = BoidSystem

-- Add a new boid to the system
function BoidSystem:AddBoid(part: Instance): Boid
	local boid = Boid.new(part, self.Settings)
	table.insert(self.Boids, boid)
	return boid
end

-- Create multiple boids from a template
function BoidSystem:CreateBoids(template: Instance, count: number, parentFolder: Instance?): {Boid}
	local results: {Boid} = {}

	for i = 1, count do
		local newInstance = template:Clone()

		local halfSize = self.Settings.BoundsSize / 2
		local center = self.Settings.BoundsCenter

		local positionVec = Vector3.new(
			center.X + (math.random() * self.Settings.BoundsSize.X - halfSize.X),
			center.Y + (math.random() * self.Settings.BoundsSize.Y - halfSize.Y),
			center.Z + (math.random() * self.Settings.BoundsSize.Z - halfSize.Z)
		)

		if newInstance:IsA("Model") and newInstance.PrimaryPart then
			newInstance:PivotTo(CFrame.new(positionVec))
		else
			newInstance.Position = positionVec
		end

		newInstance.Parent = parentFolder or workspace

		local boid = self:AddBoid(newInstance)
		table.insert(results, boid)
	end

	return results
end

-- Start simulating
function BoidSystem:Start()
	if self.Running then return end

	self.Running = true

	local lastUpdate = tick()

	self.UpdateConnection = RunService.PreRender:Connect(function()
		local now = tick()
		local elapsed = math.min(now - lastUpdate, 0.1)

		if elapsed >= self.Settings.UpdateFrequency then
			lastUpdate = now

			for _, boid in self.Boids do
				if boid.Part and boid.Part.Parent then
					boid:Update(self.Boids, elapsed)
				end
			end
		end
	end)
end

-- Stop simulating
function BoidSystem:Stop()
	if not self.Running then return end

	self.Running = false

	if self.UpdateConnection then
		self.UpdateConnection:Disconnect()
		self.UpdateConnection = nil
	end
end

-- Set a target position for all boids
function BoidSystem:SetTarget(targetPosition)
	for _, boid in self.Boids do
		boid.Target = targetPosition
	end
end

-- Clear all boids
function BoidSystem:Clear()
	self:Stop()

	for _, boid in self.Boids do
		if boid.Part then
			boid.Part:Destroy()
		end
	end

	self.Boids = {}
end

-- Set bounds
function BoidSystem:SetBounds(center, size)
	self.Settings.BoundsCenter = center
	self.Settings.BoundsSize = size
end

-- Update settings
function BoidSystem:UpdateSettings(newSettings)
	for key, value in newSettings do
		self.Settings[key] = value
	end
end

return BoidSystem