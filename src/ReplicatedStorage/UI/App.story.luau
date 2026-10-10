-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local e = React.createElement
-- instances --
local ScreenGui = require(script.Parent.instances.ScreenGui)
local Frame = require(script.Parent.instances.Frame)
local TextLabel = require(script.Parent.instances.TextLabel)

return function(parent: Instance)
	local root = ReactRoblox.createRoot(parent)
	local content = e(Frame, nil, {
		e(TextLabel, {
			TextColor3 = Color3.fromRGB(255, 255, 255),
		})
	})

	if parent:IsA("PlayerGui") then
		root:render(e(ScreenGui, nil, content))
	else
		root:render(content)
	end

	return function()
		root:unmount()
	end
end
