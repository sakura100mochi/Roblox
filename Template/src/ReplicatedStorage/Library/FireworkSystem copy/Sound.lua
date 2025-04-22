--Name		: Sound
--Explain	: 花火のサウンド
local Sound = {}

function Sound.makeSound(str)
	local new = Instance.new("Sound")
	new.Parent = game:GetService("SoundService")

	if str == "Launch" then
		new.SoundId = "rbxassetid://551051176"
	elseif str == "SmallExplode" then
		new.SoundId = "rbxassetid://4583102108"
	elseif str == "Explode" then
		new.SoundId = "rbxassetid://4583102108"
		new.Volume = 5
	elseif str == "After" then
		new.SoundId = "rbxassetid://100817659362842"
	elseif str == "Fizzle" then
		new.SoundId = "rbxassetid://160247625"
	end

	return new
end

return Sound
