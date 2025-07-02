-- explaining the code:
-- 乗ると押される床

-- Game Services --
local TweenService = game:GetService("TweenService")

-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- Create Component --
local PushPart = Component.new({
	Tag = "PushPart",
	Ancestor = {},
	Extensions = {},
})

-- default function --
function PushPart:Construct()
	print("PushPart constructed")
	self.Speed = self.Instance:GetAttribute("Speed") or 120
end

function PushPart:Start()
	print("PushPart started")
	self:makeDecal()
	self.Instance.Velocity = self.Instance.CFrame.LookVector * self.Speed
end

function PushPart:Stop()
	print("PushPart stopped")
end

-- original function --
function PushPart:makeDecal()
	local edge = self.Instance.Size.Z % 2 / 2
	local start = -self.Instance.Size.Z / 2 + (edge > 1 and edge or edge + 1)
	local finish = self.Instance.Size.Z / 2 - (edge > 1 and edge or edge + 1)
	for i = start, finish - 2, 2 do
		local DecalPart = Instance.new("Part")
		DecalPart.Name = "DecalPart"
		DecalPart.Size = Vector3.new(4, self.Instance.Size.Y, 2)
		DecalPart.Transparency = 1
		DecalPart.Anchored = true
		DecalPart.CanCollide = false
		DecalPart.CFrame = self.Instance.CFrame - self.Instance.CFrame.LookVector * i
		DecalPart.Parent = self.Instance

		local Decal = Instance.new("Decal")
		Decal.Texture = "http://www.roblox.com/asset/?id=2675648145"
		Decal.Face = Enum.NormalId.Top
		Decal.Parent = DecalPart

		local startCFrame = self.Instance.CFrame - self.Instance.CFrame.LookVector * start
		local distance = (startCFrame.Position - DecalPart.CFrame.Position).Magnitude
		local Tween = TweenService:Create(
			DecalPart,
			TweenInfo.new(distance / 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false),
			{
				Position = startCFrame.Position,
			})
		Tween:Play()
		Tween.Completed:Connect(function()
			local finishCFrame = self.Instance.CFrame - self.Instance.CFrame.LookVector * finish
			DecalPart.CFrame = finishCFrame
			local Maxdistance = (startCFrame.Position - DecalPart.CFrame.Position).Magnitude
			local Loop = TweenService:Create(
				DecalPart,
				TweenInfo.new(Maxdistance / 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false),
				{
					Position = startCFrame.Position,
				})
			Loop:Play()
		end)
	end
end

return PushPart
