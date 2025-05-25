--Name		: Sound
--Explain	: 花火のサウンド
local Sound = {}

Sound.List = {
	["Fuse"] = "rbxassetid://71438605239854",
	["Launch"] = "rbxassetid://551051176",
	["SmallExplode"] = "rbxassetid://160248302",
	["Explode"] = "rbxassetid://4583102108",
	["Explode_Fizzle"] = "rbxassetid://94899533328756",
	["After"] = "rbxassetid://100817659362842",
	["Fizzle"] = "rbxassetid://160247625",
	["Fountain"] = "rbxassetid://160248368"
}

function Sound.ListenAllSound()
	for key, SoundId in pairs(Sound.List) do
		local new = Instance.new("Sound")
		new.Parent = game:GetService("SoundService")
		new.SoundId = SoundId
		game:GetService("Debris"):AddItem(new, new.TimeLength + 1)
		new:Play()
		print("key: " .. key .. " | SoundId: " .. SoundId .. " | length: " .. new.TimeLength .. "秒")
		task.wait(new.TimeLength + 3)
	end
end

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

	if str == "Fountain" then
		new.Looped = true
	else
		game:GetService("Debris"):AddItem(new, new.TimeLength + 1)
	end

	new:Play()

	return new
end

return Sound
