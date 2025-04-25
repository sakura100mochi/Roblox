--Name		: Change_PlayerSound
--Explain	: Playerの音を変える
local sound = {}

local Default_PlayerSound =
{
	"Climbing",
	"Died",
	"FreeFalling",
	"GettingUp",
	"Jumping",
	"Landing",
	"Running",
	"Splash",
	"Swimming"
}

local function is_Default_PlayerSound(str)
	local i = 1
	while Default_PlayerSound[i] do
		if str == Default_PlayerSound[i] then
			return true
		end
		i = i + 1
	end
	return false
end

local function Check_args(str, HumanoidRootPart, SoundID)
	if str == nil or typeof(str) ~= "string" or is_Default_PlayerSound(str) == false then
		print("Error: (Change_PlayerSound) Invalid argments | str")
		return false
	end

	if HumanoidRootPart == nil or HumanoidRootPart.Parent == nil
		or HumanoidRootPart:FindFirstChild(str) == nil then
		print("Error: (Change_PlayerSound) Invalid argments | HumanoidRootPart")
		return false
	end

	if SoundID == nil then
		print("Error: (Change_PlayerSound) Invalid argments | SoundID")
		return false
	end
end

--Function Name	: Change_PlayerSound
--Explain		: playerの動作の音を変える
--Arguments| str				: (string)どの動作の音を変えるか指定する
--Arguments| HumanoidRootPart	: (HumanoidRootPart)音を変えたい人のHumanoidRootPart
--Arguments| SoundID			: (SoundID)変えたい音のSoundID
--Return Value	: none
function sound.Change_PlayerSound(str, HumanoidRootPart, SoundID)
	if Check_args(str, HumanoidRootPart, SoundID) == false then return end	

	local newSound = HumanoidRootPart:FindFirstChild(str)

	newSound.SoundId = SoundID
end

local materialSounds =
{
	[Enum.Material.Grass] = "rbxassetid://9083822528",
	[Enum.Material.Rock] = "rbxassetid://3084278209",
	[Enum.Material.Wood] = "rbxassetid://6190601470",
	[Enum.Material.SmoothPlastic] = "rbxassetid://720912012",
	[Enum.Material.Sand] = "rbxassetid://9083852561",
	[Enum.Material.Mud] = "rbxassetid://6197673163"
}

local function floor(Humanoid, RunningSound)
	local FloorMaterial = Humanoid.FloorMaterial
	local Sound = materialSounds[FloorMaterial]
	local DefaultSoundId = "rbxasset://sounds/action_footsteps_plastic.mp3"

	if Sound then
		RunningSound.SoundId = Sound
		RunningSound.PlaybackSpeed = 0.9
	else
		RunningSound.SoundId = DefaultSoundId
		RunningSound.PlaybackSpeed = 1
	end
end

--Function Name	: FloorSound
--Explain		: 床の素材によって足音を変更する
--Arguments| character	: (character)音を変更したいプレイヤーのcharacter
--Return Value	: none
function sound.FloorSound(character)
	local Humanoid = character:WaitForChild("Humanoid")
	local HumanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local RunningSound = HumanoidRootPart:FindFirstChild("Running")

	Humanoid:GetPropertyChangedSignal("FloorMaterial"):Connect(function()floor(Humanoid, RunningSound)end)
end

return sound