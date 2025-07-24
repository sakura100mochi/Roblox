--Name		: Weather
--Explain	: 天候
local weather = {}

-- game services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
-- settings --
local Settings = ReplicatedStorage.Shared.Settings
local GameSettings = require(Settings.GameSettings)

-- const variables --
-- local BASE_SIZE = 2048
local BASE_SIZE = 1024
local SNOW_PART_SIZE = 24
local SNOW_PART_HEIGHT = 40

weather.Weather = {
	Sunny = "Sunny",
	Snow = "Snow",
}

function weather:new()
	-- constants --
	self.Terrain = workspace:FindFirstChild("Terrain")
	self.AssetsFolder = ReplicatedStorage:FindFirstChild("Assets")
	self.WeatherFolder = self.AssetsFolder:FindFirstChild("Weather")
	self.SnowFolder = self.WeatherFolder and self.WeatherFolder:FindFirstChild("Snow")
	self.SnowEffect = self.SnowFolder and self.SnowFolder:FindFirstChild("Snowflakes")

	-- variables --
	self.CurrentWeather = "Sunny"

	self:_makeSnowEffect()
end

function weather:Start()
	while true do
		if GameSettings["doWeatherCycle"].value == true then
			self:changeWeather()
			task.wait(math.random(1, 10) * 60)
		end
		task.wait()
	end
end

function weather:changeWeather()
	if self.CurrentWeather == "Sunny" then
		self:Snow()
	elseif self.CurrentWeather == "Snow" then
		self:Sunny()
	end
end

function weather:Sunny()
	self.CurrentWeather = weather.Weather.Sunny

	if self.SnowFolder and self.SnowFolder.Parent == workspace then
		self.SnowFolder.Parent = self.WeatherFolder
	end
	self:_CloudsClear()
end

function weather:Snow()
	self.CurrentWeather = weather.Weather.Snow

	self.SnowFolder.Parent = workspace
	self:_makeClouds()
end

-- private functions --
function weather:_makeSnowEffect()
	for i = -BASE_SIZE, BASE_SIZE, SNOW_PART_SIZE do
		for j = -BASE_SIZE, BASE_SIZE, SNOW_PART_SIZE do
			local Snowflake = self.SnowEffect:Clone()
			Snowflake.Position = Vector3.new(i, SNOW_PART_HEIGHT, j)
			Snowflake.Parent = self.SnowFolder
		end
	end
end

function weather:_makeClouds()
	local Clouds = Instance.new("Clouds")
	Clouds.Name = "SnowClouds"
	Clouds.Parent = self.Terrain
	Clouds.Cover = 0
	Clouds.Density = 0

	local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
	local tween = TweenService:Create(Clouds, tweenInfo, {Cover = 1, Density = 0.6})
	tween:Play()
	tween.Completed:Wait()
end

function weather:_CloudsClear()
	if self.Terrain:FindFirstChild("SnowClouds") then
		local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local tween = TweenService:Create(self.Terrain.SnowClouds, tweenInfo, {Cover = 0, Density = 0})
		tween:Play()
		tween.Completed:Wait()
		self.Terrain.SnowClouds:Destroy()
	end
end

return weather

--*****このScriptをServerScriptServiceに入れてください。*****--

-- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- local weather = lib.weather

-- weather:new()
-- weather:Start()

--********************************************************--
