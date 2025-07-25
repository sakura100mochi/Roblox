-- explaining the code:
-- テレポート
-- テレポート先の対象パーツ：タグがついてるパーツの子パーツ（名前は"Part"）。
--						子パーツがなければ、"SpawnLocation"が対象パーツに。
-- 						対象パーツがなければ何もしない。
-- テレポートのタイミング：触れた時、またはProximityPrompt
-- Attribute：
-- 		isTouchVersion（boolean）：Trueなら触れた時、falseならProximityPrompt。デフォルトはTrue。
-- 		HoldDuration（number）	：ProximityPromptのHoldDuration。デフォルトは0。
--		ActionText (string): ProximityPromptのActionText。デフォルトは"Teleport"。

-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- Create Component --
local Teleport = Component.new({
	Tag = "Teleport",
	Ancestor = {},
	Extensions = {},
})

function Teleport:Construct()
	self.TargetPart = self.Instance:FindFirstChild("TeleportTargetPart")
	if not self.TargetPart then
		self.TargetPart = workspace:FindFirstChild("SpawnLocation")
	end
	self.isTouchVersion = self.Instance:GetAttribute("isTouchVersion")
	if self.isTouchVersion == nil then
		self.isTouchVersion = true
	end
	self.HoldDuration = self.Instance:GetAttribute("HoldDuration") or 0
	self.ActionText = self.Instance:GetAttribute("ActionText") or "Teleport"
end

function Teleport:Start()
	if self.isTouchVersion == true and self.TargetPart then
		self.Instance.Touched:Connect(function(hitPart)
			local character = hitPart.Parent
			self:TeleportToTargetPart(character)
		end)
	elseif self.isTouchVersion == false and self.TargetPart then
		self:makeProximityPrompt()
		self.ProximityPrompt.Triggered:Connect(function(player)
			local character = player.Character
			self:TeleportToTargetPart(character)
		end)
	end
end

function Teleport:Stop()
end

-- original function --
function Teleport:makeProximityPrompt()
	self.ProximityPrompt = Instance.new("ProximityPrompt")
	self.ProximityPrompt.ActionText = self.ActionText
	self.ProximityPrompt.Parent = self.Instance
	self.ProximityPrompt.HoldDuration = self.HoldDuration
end

function Teleport:TeleportToTargetPart(character)
	if character and character:FindFirstChild("HumanoidRootPart") then
		local HumanoidRootPart = character.HumanoidRootPart
		HumanoidRootPart.CFrame = self.TargetPart.CFrame + Vector3.new(0, 5, 0)
	end
end

return Teleport
