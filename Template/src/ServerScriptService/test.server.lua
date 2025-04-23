local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
local AFirework = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"].AFirework)
local Botan = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"].Botan)
local Kamuro = require(game.ReplicatedStorage.Shared.Library["FireworkSystem copy"].Kamuro)

-- local botan = Botan.new({Color1 = AFirework.Colors.K, Color2 = AFirework.Colors.Rb})
-- botan:launch()
-- botan:AutoSystem()

local Kamuro = Kamuro.new({Color1 = AFirework.Colors.K})
Kamuro:AutoSystem()
