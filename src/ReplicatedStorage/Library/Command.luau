--Name		: Command
--Explain	: コマンド
local command = {}

-- game services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
-- settings --
local Settings = ReplicatedStorage.Shared.Settings
local GameSettings = require(Settings.GameSettings)
local OP = require(Settings.OP)

--Function Name	: SetUp
--Explain		: chatでコマンドを受け付けるようにする
--Return Value	: none
function command:SetUp()
	local lib = require(ReplicatedStorage.Shared.Library)
	self.weather = lib.weather

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
function command:_ChangeGameRule(Message)
	if not Message or #Message < 3 then return end
	if GameSettings[Message[2]] == nil then return end
	if GameSettings:checkType(GameSettings[Message[2]].type, Message[3]) == false then return end

	GameSettings[Message[2]].value = Message[3]
	print("Game rule changed: " .. Message[2] .. " = " .. tostring(GameSettings[Message[2]].value))
end

function command:_changeWeather(Message)
	if not Message or #Message < 2 then return end
	if string.lower(Message[2]) == string.lower("Sunny") then
		self.weather:Sunny()
	elseif string.lower(Message[2]) == string.lower("Snow") then
		self.weather:Snow()
	end
end

return command

--*****このScriptをServerScriptServiceに入れてください。*****--

-- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- local command = lib.command

-- command:SetUp()

--********************************************************--
