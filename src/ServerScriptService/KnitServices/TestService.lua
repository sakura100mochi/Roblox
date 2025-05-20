-- knit --
local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

-- Creating Service --
local TestService = Knit.CreateService({
	Name = "TestService",
	Client = {},
})

function TestService:KnitInit()
	print("TestService initialized")
end

function TestService:KnitStart()
	print("TestService started")
end

return TestService
