-- explaining the code:
-- 触れたらパーツが徐々になくなる
-- Attribute：
--		Speed（number）		：フェードアウトする速度。デフォルトは0.1。　値が小さいほど速くフェードアウトする。
--		ResetTime（number）	：フェードアウトが完了した後、パーツを元に戻すまでの時間。デフォルトは1秒。

-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- Create Component --
local FadePart = Component.new({
	Tag = "FadePart",
	Ancestor = {},
	Extensions = {},
})

-- default function --
function FadePart:Construct()
	print("FadePart constructed")
	self.Speed = self.Instance:GetAttribute("Speed") or 0.1
	self.ResetTime = self.Instance:GetAttribute("ResetTime") or 1
end

function FadePart:Start()
	print("FadePart started")
	self.Instance.Touched:Connect(function(hitPart) self:onTouched(hitPart) end)
end

function FadePart:Stop()
	print("FadePart stopped")
end

-- original function --
function FadePart:onTouched(hitPart)
	if not hitPart then return end
	local character = hitPart.Parent
	if not character then return end
	local Humanoid = character:FindFirstChild("Humanoid")
	if not Humanoid then return end

	while true do
		if self.Instance.Transparency >= 1 then
			task.wait(self.ResetTime)
			self.Instance.CanCollide = true
			self.Instance.Transparency = 0
			break
		elseif self.Instance.Transparency >= 0.5 then
			self.Instance.CanCollide = false
		end
		self.Instance.Transparency = self.Instance.Transparency + 0.1
		task.wait(self.Speed)
	end
end

return FadePart
