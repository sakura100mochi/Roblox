-- explaining the code:
-- 触れたら上がれるブロック

-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- Create Component --
local SmoothUp = Component.new({
	Tag = "SmoothUp",
	Ancestor = {},
	Extensions = {},
})

-- default function --
function SmoothUp:Construct()
	print("SmoothUp constructed")
	self.SpeedY = self.Instance:GetAttribute("SpeedY") or 50
end

function SmoothUp:Start()
	print("SmoothUp started")
	self.Instance.CanCollide = false
	self.Instance.Touched:Connect(function(hitPart) self:onTouched(hitPart) end)
	self.Instance.TouchEnded:Connect(function(hitPart) self:onTouchEnded(hitPart) end)
end

function SmoothUp:Stop()
	print("SmoothUp stopped")
end

-- original function --
function SmoothUp:onTouched(hitPart)
	if not hitPart then return end
	local character = hitPart.Parent
	if not character then return end
	local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then return end
	local LinearVelocity = HumanoidRootPart:FindFirstChild("LinearVelocity")
	if LinearVelocity then return end

	self.LinearVelocity = Instance.new("LinearVelocity")
	self.LinearVelocity.ForceLimitsEnabled = false
	self.LinearVelocity.VectorVelocity = Vector3.new(0, self.SpeedY, 0)
	self.LinearVelocity.Attachment0 = HumanoidRootPart:FindFirstChild("RootAttachment") or Instance.new("Attachment", HumanoidRootPart)
	self.LinearVelocity.Parent = HumanoidRootPart
end

function SmoothUp:onTouchEnded(hitPart)
	if not hitPart then return end
	local character = hitPart.Parent
	if not character then return end
	local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then return end
	local LinearVelocity = HumanoidRootPart:FindFirstChild("LinearVelocity")
	if LinearVelocity then
		LinearVelocity:Destroy()
	end
end

return SmoothUp
