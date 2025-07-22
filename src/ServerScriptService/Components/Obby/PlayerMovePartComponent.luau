-- explaining the code:
-- 乗ったプレイヤーが動くパーツ
-- Attribute：
-- 		Speed（number）	：プレイヤーが動く速度。デフォルトは10。　値が大きいほど速く動く。0以下は不可。
-- 		Color（Color3）	：テクスチャの色。デフォルトは白色。

-- Game Services --
local TweenService = game:GetService("TweenService")

-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- Create Component --
local PlayerMovePart = Component.new({
	Tag = "PlayerMovePart",
	Ancestor = {},
	Extensions = {},
})

-- default function --
function PlayerMovePart:Construct()
	print("PlayerMovePart constructed")
	self.Speed = self.Instance:GetAttribute("Speed") or 10
	self.Color = self.Instance:GetAttribute("Color") or Color3.new(1, 1, 1)
end

function PlayerMovePart:Start()
	print("PlayerMovePart started")
	if self:checkArgs() == false then
		warn("[PlayerMovePart component] has invalid arguments.")
	end
	self.Instance.Velocity = self.Instance.CFrame.LookVector * self.Speed
	self:makeTexture()
end

function PlayerMovePart:Stop()
	print("PlayerMovePart stopped")
end

-- original function --
function PlayerMovePart:checkArgs()
	-- type check
	if type(self.Speed) ~= "number" or typeof(self.Color) ~= "Color3" then
		return false
	end
	-- value check
	if self.Speed <= 0 then
		return false
	end
	return true
end

function PlayerMovePart:makeTexture()
	self.Texture = Instance.new("Texture")
	self.Texture.Parent = self.Instance
	self.Texture.Name = "ArrowTexture"
	self.Texture.Texture = "http://www.roblox.com/asset/?id=2675648145"
	self.Texture.Face = Enum.NormalId.Top
	self.Texture.Color3 = self.Color
	self.Texture.StudsPerTileU = 4
	self.Texture.StudsPerTileV = 2
	self.Texture.OffsetStudsU = -(self.Instance.Size.X - 4) / 2

	self.Tween = TweenService:Create(
		self.Texture,
		TweenInfo.new(2 / self.Speed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false),
		{OffsetStudsV = -2}
	)
	self.Tween:Play()
end

return PlayerMovePart
