--Name		: FireworkSystem
--Explain	: 花火
local firework = {}

firework.Colors = {
	["Li"] = Color3.fromHex("#ff2167"),
	["Na"] = Color3.fromHex("#ff5601"),
	["K"] = Color3.fromHex("#ff4ed6"),
	["Rb"] = Color3.fromHex("#6011b9"),
	["Cs"] = Color3.fromHex("#8952ff"),
	["Ca"] = Color3.fromHex("#ff8000"),
	["Sr"] = Color3.fromHex("#ff2600"),
	["Ba"] = Color3.fromHex("#a4fdff"),
	["Cu"] = Color3.fromHex("#4bbc58"),
	["C"] = Color3.fromHex("#ec8b46"),
	["Al"] = Color3.fromHex("#b2c4d1")
}

firework.Sound = require(script.Sound)
firework.Nobori = require(script.Nobori)
firework.All = require(script.All)
firework.Kiku = require(script.Kiku)
firework.Botan = require(script.Botan)
firework.Ring = require(script.Ring)
firework.UFO = require(script.UFO)
firework.Kamuro = require(script.Kamuro)
firework.Toranoo = require(script.Toranoo)
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
