-- game services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- packages --
local Knit = require(ReplicatedStorage.Packages.Knit)
-- settings --
local Settings = ReplicatedStorage.Shared.Settings
local GameSettings = require(Settings.GameSettings)

-- Creating Service --
local TestService = Knit.CreateService({
	Name = "TestService",
	Client = {},
})

function TestService:KnitInit()
	-- print("TestService initialized")
end

function TestService:KnitStart()
	-- print("TestService started")
end

return TestService
