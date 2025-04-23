--Name		: Sound
--Explain	: 花火のサウンド
local Sound = {}

Sound.List = {
	["Lauch"] = "rbxassetid://551051176",
	["SmallExplode"] = "rbxassetid://4583102108",
	["Explode"] = "rbxassetid://4583102108",
	["After"] = "rbxassetid://100817659362842",
	["Fizzle"] = "rbxassetid://160247625"
}

function Sound.PlaySound(str)
	local new = Instance.new("Sound")
	new.Parent = game:GetService("SoundService")

	local SoundId = Sound.List[str]
	if SoundId then
		new.SoundId = SoundId
	else
		new:Destroy()
		error("ERROR: Invalid Argument")
	end

	if str == "Explode" then
		new.Volume = 5
	end

	game:GetService("Debris"):AddItem(new, new.TimeLength() + 1)
	new:Play()

	return new
end

return Sound
