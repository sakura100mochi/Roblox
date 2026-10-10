-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local e = React.createElement
-- UI --
local Instances = require(script.Parent.Instances)
local Menu = require(script.Parent.Features.Menu)

return function(parent: Instance)
	local root = ReactRoblox.createRoot(parent)
	local content = e(Menu, nil)

	if parent:IsA("PlayerGui") then
		root:render(e(Instances.ScreenGui, nil, content))
	else
		root:render(content)
	end

	return function()
		root:unmount()
	end
end
