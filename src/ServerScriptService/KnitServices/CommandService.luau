-- game services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
-- packages --
local Knit = require(ReplicatedStorage.Packages.Knit)
-- settings --
local Settings = ReplicatedStorage.Shared.Settings
local GameSettings = require(Settings.GameSettings)
local OP = require(Settings.OP)

-- Creating Service --
local CommandService = Knit.CreateService({
	Name = "CommandService",
	Client = {},
})

function CommandService:KnitInit()
	self.WeatherService = Knit.GetService("WeatherService")
end

function CommandService:KnitStart()
	Players.PlayerAdded:Connect(function(player)
		player.Chatted:Connect(function(Message)
			if string.find(Message, "/gamerule") and OP:checkOPLevel(player.Name, player.UserId, 3) then
				local result = string.split(Message, " ")
				self:_ChangeGameRule(result)
			elseif string.find(Message, "/weather") and OP:checkOPLevel(player.Name, player.UserId, 2) then
				local result = string.split(Message, " ")
				self:_changeWeather(result)
			end
		end)
	end)
end

-- private functions --
function CommandService:_ChangeGameRule(Message)
	if not Message or #Message < 3 then return end
	if GameSettings[Message[2]] == nil then return end
	if GameSettings:checkType(GameSettings[Message[2]].type, Message[3]) == false then return end

	GameSettings[Message[2]].value = Message[3]
	print("Game rule changed: " .. Message[2] .. " = " .. tostring(GameSettings[Message[2]].value))
end

function CommandService:_changeWeather(Message)
	if not Message or #Message < 2 then return end
	if string.lower(Message[2]) == string.lower("Sunny") then
		self.WeatherService:Sunny()
	elseif string.lower(Message[2]) == string.lower("Snow") then
		self.WeatherService:Snow()
	end
end

return CommandService
