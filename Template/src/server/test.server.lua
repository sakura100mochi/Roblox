local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
local spawn = lib.spawn

local mob = game:GetService("ReplicatedStorage").Part
local pos = workspace.spawnPart.Position
local time = 5


spawn.mobSpawn(mob, pos, time)
