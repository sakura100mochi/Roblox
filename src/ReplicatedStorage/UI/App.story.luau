-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local e = React.createElement
-- UI --
local Instances = require(script.Parent.Instances)

return function(parent: Instance)
	local root = ReactRoblox.createRoot(parent)
	local content = e(Instances.Frame, nil, {
		e(Instances.TextLabel, {
			TextColor3 = Color3.fromRGB(255, 255, 255),
		})
	})

	if parent:IsA("PlayerGui") then
		root:render(e(Instances.ScreenGui, nil, content))
	else
		root:render(content)
	end

	return function()
		root:unmount()
	end
end
