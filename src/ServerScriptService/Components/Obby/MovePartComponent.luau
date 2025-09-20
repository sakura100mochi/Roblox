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
	self.Speed = self.Instance:GetAttribute("Speed") or 2
	self.Direction = self.Instance:GetAttribute("Direction") or Vector3.new(0, 0, 1)
	self.Distance = self.Instance:GetAttribute("Distance") or 10
	self.WaitTime = self.Instance:GetAttribute("WaitTime") or 0
end

function MovePart:Start()
	while true do
		self:_move(self.Instance, self.Speed, self.Distance, self.Direction)
		task.wait(self.WaitTime)
		self:_move(self.Instance, self.Speed, -self.Distance, self.Direction)
		task.wait(self.WaitTime)
	end
end

function MovePart:_move(movePart: Part, speed: number, destination: number, direction: Vector3)
	movePart.Anchored = false
	movePart.CanCollide = true

	local Attachment0 = Instance.new("Attachment")
	Attachment0.Name = "Attachment0"
	Attachment0.Parent = movePart
	Attachment0.Axis = direction

	local Part = Instance.new("Part")
	Part.Name = "Part"
	Part.Size = Vector3.new(1, 1, 1)
	Part.Transparency = 1
	Part.Anchored = true
	Part.CanCollide = false
	Part.Parent = movePart
	Part.CFrame = movePart.CFrame + direction * destination

	local Attachment1 = Instance.new("Attachment")
	Attachment1.Name = "Attachment1"
	Attachment1.Parent = Part
	Attachment1.Axis = direction

	local PrismaticConstraint = Instance.new("PrismaticConstraint")
	PrismaticConstraint.Name = "PrismaticConstraint"
	PrismaticConstraint.Attachment0 = Attachment0
	PrismaticConstraint.Attachment1 = Attachment1
	PrismaticConstraint.Parent = Part
	PrismaticConstraint.ActuatorType = Enum.ActuatorType.Servo
	PrismaticConstraint.ServoMaxForce = math.huge
	PrismaticConstraint.Speed = speed
	PrismaticConstraint.TargetPosition = 0

	local distance = math.abs(destination)
	local time = 0
	repeat
		task.wait(1)
		time = time + 1
		if distance / speed + 3 <= time then
			break
		end
	until PrismaticConstraint.CurrentPosition <= 1 and PrismaticConstraint.CurrentPosition >= -1

	PrismaticConstraint:Destroy()
	Attachment1:Destroy()
	Part:Destroy()
	Attachment0:Destroy()
end

function MovePart:Stop()
	print("MovePart stopped")
end

return MovePart
