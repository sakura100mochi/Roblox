-- Component --
local Component = require(game:GetService("ReplicatedStorage").Packages.Component)

-- Create Component --
local TestComponent = Component.new({
	Tag = "TestComponent",
	Ancestor = {},
	Extensions = {},
})

function TestComponent:Construct()
	print("TestComponent constructed")
end

function TestComponent:Start()
	print("TestComponent started")
end

function TestComponent:Stop()
	print("TestComponent stopped")
end

return TestComponent
