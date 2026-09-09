-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local Component = require(ReplicatedStorage.Packages.Component)
-- Modules --
local getPlatform = require(script.getPlatform)
local getCheckpoints = require(script.getCheckpoints)

local MovingPlatform = Component.new({
	Tag = "MovingPlatform",
	Ancestors = {workspace},
})

MovingPlatform.SPEED_ATTRIBUTE = "speed"
MovingPlatform.DEFAULT_SPEED = 10
MovingPlatform.ANGULAR_SPEED_ATTRIBUTE = "angularSpeed"
MovingPlatform.DEFAULT_ANGULAR_SPEED = 1
MovingPlatform.DELAY_ATTRIBUTE = "delay"
MovingPlatform.DEFAULT_DELAY = 3
MovingPlatform.RESPONSIVENESS = 50

function MovingPlatform:Construct()
	self.platform = getPlatform(self.Instance)
	self.checkpoints = getCheckpoints(self.Instance)

	local speed = self.Instance:GetAttribute(self.SPEED_ATTRIBUTE) or self.DEFAULT_SPEED
	local angularSpeed = self.Instance:GetAttribute(self.ANGULAR_SPEED_ATTRIBUTE) or self.DEFAULT_ANGULAR_SPEED

	local attachment = Instance.new("Attachment")
	attachment.Name = "MovingPlatformAttachment"
	attachment.Parent = self.platform

	-- Create an AlignPosition to use for moving the platform around
	self.alignPosition = Instance.new("AlignPosition")
	self.alignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
	self.alignPosition.Attachment0 = attachment
	self.alignPosition.MaxForce = math.huge
	self.alignPosition.MaxVelocity = speed
	self.alignPosition.Responsiveness = self.RESPONSIVENESS
	self.alignPosition.Parent = self.platform

	-- Create an AlignOrientation to use for rotating the platform
	self.alignOrientation = Instance.new("AlignOrientation")
	self.alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	self.alignOrientation.Attachment0 = attachment
	self.alignOrientation.MaxTorque = math.huge
	self.alignOrientation.MaxAngularVelocity = angularSpeed
	self.alignOrientation.Responsiveness = self.RESPONSIVENESS
	self.alignOrientation.Parent = self.platform

	self.checkpointIndex = 1
	self.connections = {}

	-- Update the constraints when the attributes are changed
	table.insert(
		self.connections,
		self.Instance:GetAttributeChangedSignal(self.SPEED_ATTRIBUTE):Connect(function()
			local speed = self.Instance:GetAttribute(self.SPEED_ATTRIBUTE)
			self.alignPosition.MaxVelocity = speed
		end)
	)

	table.insert(
		self.connections,
		self.Instance:GetAttributeChangedSignal(self.ANGULAR_SPEED_ATTRIBUTE):Connect(function()
			local angularSpeed = self.Instance:GetAttribute(self.ANGULAR_SPEED_ATTRIBUTE)
			self.alignOrientation.MaxAngularVelocity = angularSpeed
		end)
	)

	-- Move the platform to the first checkpoint
	local checkpoint = self.checkpoints[self.checkpointIndex]
	self.platform.CFrame = checkpoint.CFrame
	self.alignPosition.Position = checkpoint.Position
	self.alignOrientation.CFrame = checkpoint.CFrame
end

function MovingPlatform:Move()
	-- Find the next checkpoint, looping back to the first once we reach the end
	local nextCheckpointIndex = self.checkpointIndex + 1
	if nextCheckpointIndex > #self.checkpoints then
		nextCheckpointIndex = 1
	end
	self.checkpointIndex = nextCheckpointIndex

	-- Calculate the time needed to reach the next checkpoint
	local checkpoint = self.checkpoints[nextCheckpointIndex]
	local distance = (self.platform.Position - checkpoint.Position).Magnitude
	local timeToNextCheckpoint = distance / self.alignPosition.MaxVelocity

	-- Move to the next checkpoint
	self.alignPosition.Position = checkpoint.Position
	self.alignOrientation.CFrame = checkpoint.CFrame

	-- Wait for the time it takes to reach the checkpoint + the delay at each checkpoint before moving on
	-- We'll save this task so we can cancel it later if we need to stop the checkpoint moving
	local delayTime = self.Instance:GetAttribute(self.DELAY_ATTRIBUTE) or self.DEFAULT_DELAY
	self.moveTask = task.delay(timeToNextCheckpoint + delayTime, self.Move, self)
end

function MovingPlatform:StopMove()
	-- If we have a current move task, cancel it so it doesn't loop forever
	if self.moveTask then
		task.cancel(self.moveTask)
		self.moveTask = nil
	end
end

function MovingPlatform:Stop()
	self:StopMove()
	for _, connection in self.connections do
		connection:Disconnect()
	end
	table.clear(self.connections)
end

function MovingPlatform:Start()
	self:Move()
end

return MovingPlatform
