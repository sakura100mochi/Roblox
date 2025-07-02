-- explaining the code:
-- ロープにぶら下がってぶらぶらするパーツ

-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- Create Component --
local RopeSwingPart = Component.new({
	Tag = "RopeSwingPart",
	Ancestor = {},
	Extensions = {},
})

-- default function --
function RopeSwingPart:Construct()
	print("RopeSwingPart constructed")
	self.Height = self.Instance:GetAttribute("Height") or 10
	self.Color = self.Instance:GetAttribute("Color") or Color3.new(0.133333, 0.219607, 0.313725)
	self.Size = self.Instance:GetAttribute("Size") or Vector3.new(0.5, 0.5, 0.5)
end

function RopeSwingPart:Start()
	print("RopeSwingPart started")
	self.Instance.Anchored = false
	self.Instance.CanCollide = true

	self.Part = Instance.new("Part")
	self.Part.Name = "RopeSwingPart"
	self.Part.Size = self.Size
	self.Part.Color = self.Color
	self.Part.CFrame = self.Instance.CFrame + Vector3.new(0, self.Height, 0)
	self.Part.Transparency = 0
	self.Part.Anchored = true
	self.Part.CanCollide = true
	self.Part.Parent = self.Instance

	self.Attachment0 = Instance.new("Attachment")
	self.Attachment0.Name = "Attachment0"
	self.Attachment0.Parent = self.Part

	for i = 0, 3 do
		local Attachment1 = Instance.new("Attachment")
		Attachment1.Name = "Attachment1"
		Attachment1.Parent = self.Instance
		Attachment1.Position = Vector3.new(self.Instance.Size.X / 2, self.Instance.Size.Y / 2, self.Instance.Size.Z / 2)
		if i == 1 then
			Attachment1.Position = Vector3.new(-self.Instance.Size.X / 2, self.Instance.Size.Y / 2, self.Instance.Size.Z / 2)
		elseif i == 2 then
			Attachment1.Position = Vector3.new(self.Instance.Size.X / 2, self.Instance.Size.Y / 2, -self.Instance.Size.Z / 2)
		elseif i == 3 then
			Attachment1.Position = Vector3.new(-self.Instance.Size.X / 2, self.Instance.Size.Y / 2, -self.Instance.Size.Z / 2)
		end

		local RopeConstraint = Instance.new("RopeConstraint")
		RopeConstraint.Name = "RopeConstraint"
		RopeConstraint.Attachment0 = self.Attachment0
		RopeConstraint.Attachment1 = Attachment1
		RopeConstraint.Length = self.Height
		RopeConstraint.Visible = true
		RopeConstraint.Parent = self.Part
	end
end

function RopeSwingPart:Stop()
	print("RopeSwingPart stopped")
end

return RopeSwingPart
