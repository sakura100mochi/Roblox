-- game services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- packages --
local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddControllers(script)

Knit.Start():andThen(function()
	print("Knit client started")
end):catch(warn)
