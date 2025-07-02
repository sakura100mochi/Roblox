-- explaining the code:
-- 回る床

-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- Create Component --
local RotatePart = Component.new({
	Tag = "RotatePart",
	Ancestor = {},
	Extensions = {},
})

-- default function --
function RotatePart:Construct()
	print("RotatePart constructed")
	self.Speed = self.Instance:GetAttribute("Speed") or 1
	self.Axis = self.Instance:GetAttribute("Axis") or Vector3.new(0, 1, 0)
end

function RotatePart:Start()
	print("RotatePart started")
	self.Instance.Anchored = false
	self.Instance.CanCollide = true

	self.Attachment0 = Instance.new("Attachment")
	self.Attachment0.Name = "Attachment0"
	self.Attachment0.Parent = self.Instance
	self.Attachment0.Axis = self.Axis

	self.AnchoredPart = Instance.new("Part")
	self.AnchoredPart.Name = "AnchoredPart"
	self.AnchoredPart.Size = Vector3.new(1, 1, 1)
	self.AnchoredPart.CFrame = self.Instance.CFrame
	self.AnchoredPart.Transparency = 1
	self.AnchoredPart.Anchored = true
	self.AnchoredPart.CanCollide = false
	self.AnchoredPart.Parent = self.Instance

	self.Attachment1 = Instance.new("Attachment")
	self.Attachment1.Name = "Attachment1"
	self.Attachment1.Parent = self.AnchoredPart
	self.Attachment1.Axis = self.Axis

	self.HingeConstraint = Instance.new("HingeConstraint")
	self.HingeConstraint.Name = "HingeConstraint"
	self.HingeConstraint.Attachment0 = self.Attachment0
	self.HingeConstraint.Attachment1 = self.Attachment1
	self.HingeConstraint.Parent = self.Instance
	self.HingeConstraint.ActuatorType = Enum.ActuatorType.Motor
	self.HingeConstraint.AngularVelocity = self.Speed
	self.HingeConstraint.MotorMaxTorque = math.huge
end

function RotatePart:Stop()
	print("RotatePart stopped")
end

return RotatePart
