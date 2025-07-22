-- explaining the code:
-- 動く床
-- Attribute：
-- 		Speed（number）		：パーツの動く速度。デフォルトは2。値が大きいほど速く動く。
-- 		Direction(vector3)	：パーツの動く方向。デフォルトはVector3.new(0, 0, 1)。
-- 		Distance(number)	：パーツの動く距離。デフォルトは 10 Studs。

-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- Create Component --
local MovePart = Component.new({
	Tag = "MovePart",
	Ancestor = {},
	Extensions = {},
})

-- default function --
function MovePart:Construct()
	print("MovePart constructed")
	self.Speed = self.Instance:GetAttribute("Speed") or 2
	self.Direction = self.Instance:GetAttribute("Direction") or Vector3.new(0, 0, 1)
	self.Distance = self.Instance:GetAttribute("Distance") or 10
end

function MovePart:Start()
	print("MovePart started")
	self.Instance.Anchored = false
	self.Instance.CanCollide = true

	self.Attachment0 = Instance.new("Attachment")
	self.Attachment0.Name = "Attachment0"
	self.Attachment0.Parent = self.Instance
	self.Attachment0.Axis = self.Direction

	self.Part = Instance.new("Part")
	self.Part.Name = "Part"
	self.Part.Size = Vector3.new(1, 1, 1)
	self.Part.CFrame = self.Instance.CFrame + self.Direction * self.Distance
	self.Part.Transparency = 1
	self.Part.Anchored = true
	self.Part.CanCollide = false
	self.Part.Parent = self.Instance

	self.Attachment1 = Instance.new("Attachment")
	self.Attachment1.Name = "Attachment1"
	self.Attachment1.Parent = self.Part
	self.Attachment1.Axis = self.Direction

	self.PrismaticConstraint = Instance.new("PrismaticConstraint")
	self.PrismaticConstraint.Name = "PrismaticConstraint"
	self.PrismaticConstraint.Attachment0 = self.Attachment0
	self.PrismaticConstraint.Attachment1 = self.Attachment1
	self.PrismaticConstraint.Parent = self.Part
	self.PrismaticConstraint.ActuatorType = Enum.ActuatorType.Servo
	self.PrismaticConstraint.ServoMaxForce = math.huge
	self.PrismaticConstraint.Speed = self.Speed

	while true do
		self.PrismaticConstraint.TargetPosition = 0
		task.wait(self.Distance / self.Speed)
		self.PrismaticConstraint.TargetPosition = self.Distance
		task.wait(self.Distance / self.Speed)
	end
end

function MovePart:Stop()
	print("MovePart stopped")
end

return MovePart
