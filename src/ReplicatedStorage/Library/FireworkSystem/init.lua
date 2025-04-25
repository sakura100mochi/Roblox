--Name		: FireworkSystem
--Explain	: 花火
local firework = {}

firework.Sound = require(script.Sound)
firework.Nobori = require(script.Nobori)
firework.Smoke = require(script.Smoke)
firework.All = require(script.All)
firework.Kiku = require(script.Kiku)
firework.Botan = require(script.Botan)
firework.Ring = require(script.Ring)
firework.UFO = require(script.UFO)
firework.Kamuro = require(script.Kamuro)
firework.Toranoo = require(script.Toranoo)
firework.Gerb = require(script.Gerb)
firework.Festival = require(script.Festival)

return firework

--*****Please put part and clickdetector at workspace and put this*****--

-- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- local firework = lib.firework

-- local function onMouseClicked()
-- 	firework.All.AutoSystem_type2(script.Parent.CFrame)
-- end

-- script.Parent.ClickDetector.MouseClick:Connect(onMouseClicked)

--***********************************************************--
