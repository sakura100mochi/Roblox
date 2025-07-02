-- explaining the code:
-- 触れたらダメージを受けるパーツ

-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- Create Component --
local KillBlock = Component.new({
	Tag = "KillBlock",
	Ancestor = {},
	Extensions = {},
})

-- default function --
function KillBlock:Construct()
	print("KillBlock constructed")
	self.Damege = self.Instance:GetAttribute("Damege") or 10
	self.CoolTime = self.Instance:GetAttribute("CoolTime") or 1
	self.CoolTimeFlag = {}
end

function KillBlock:Start()
	print("KillBlock started")
	self.Instance.Touched:Connect(function(hitPart) self:onTouched(hitPart) end)
end

function KillBlock:Stop()
	print("KillBlock stopped")
end

-- original function --
function KillBlock:onTouched(hitPart)
	if not hitPart then return end
	local character = hitPart.Parent
	if not character then return end
	local player = game.Players:GetPlayerFromCharacter(character)
	if not player then return end
	if self.CoolTimeFlag[player.UserId] and self.CoolTimeFlag[player.UserId] == true then return end
	local Humanoid = character:FindFirstChild("Humanoid")
	if not Humanoid then return end

	self.CoolTimeFlag[player.UserId] = true
	Humanoid.Health = Humanoid.Health - self.Damege
	task.delay(self.CoolTime, function()
		self.CoolTimeFlag[player.UserId] = false
	end)
end

return KillBlock
