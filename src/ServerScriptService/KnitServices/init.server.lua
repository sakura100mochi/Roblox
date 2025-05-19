-- knit --
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

for _, child in ipairs(script:GetDescendants()) do
	if child:IsA("ModuleScript") and child.Name:match("Service$") then
		require(child)
		print("Loaded service: " .. child.Name)
	end
end

Knit.Start():andThen(function()
	print("Knit started")
end):catch(warn)
