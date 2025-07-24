-- game services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
-- packages --
local Knit = require(ReplicatedStorage.Packages.Knit)
-- settings --
local Settings = ReplicatedStorage.Shared.Settings
local GameSettings = require(Settings.GameSettings)

-- Creating Service --
local WeatherService = Knit.CreateService({
	Name = "WeatherService",
	Client = {},
})

-- const variables --
-- local BASE_SIZE = 2048
local BASE_SIZE = 1024
local SNOW_PART_SIZE = 24
local SNOW_PART_HEIGHT = 40

WeatherService.Weather = {
	Sunny = "Sunny",
	Snow = "Snow",
}

function WeatherService:KnitInit()
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

function WeatherService:KnitStart()
	while true do
		if GameSettings["doWeatherCycle"].value == true then
			self:changeWeather()
			task.wait(math.random(1, 10) * 60)
			-- task.wait(math.random(15))
		end
		task.wait()
	end
end

function WeatherService:changeWeather()
	if self.CurrentWeather == "Sunny" then
		self:Snow()
	elseif self.CurrentWeather == "Snow" then
		self:Sunny()
	end
end

function WeatherService:Sunny()
	self.CurrentWeather = WeatherService.Weather.Sunny

	if self.SnowFolder and self.SnowFolder.Parent == workspace then
		self.SnowFolder.Parent = self.WeatherFolder
	end
	self:_CloudsClear()
end

function WeatherService:Snow()
	self.CurrentWeather = WeatherService.Weather.Snow

	self.SnowFolder.Parent = workspace
	self:_makeClouds()
end

-- private functions --
function WeatherService:_makeSnowEffect()
	for i = -BASE_SIZE, BASE_SIZE, SNOW_PART_SIZE do
		for j = -BASE_SIZE, BASE_SIZE, SNOW_PART_SIZE do
			local Snowflake = self.SnowEffect:Clone()
			Snowflake.Position = Vector3.new(i, SNOW_PART_HEIGHT, j)
			Snowflake.Parent = self.SnowFolder
		end
	end
end

function WeatherService:_makeClouds()
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

function WeatherService:_CloudsClear()
	if self.Terrain:FindFirstChild("SnowClouds") then
		local tweenInfo = TweenInfo.new(10, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
		local tween = TweenService:Create(self.Terrain.SnowClouds, tweenInfo, {Cover = 0, Density = 0})
		tween:Play()
		tween.Completed:Wait()
		self.Terrain.SnowClouds:Destroy()
	end
end

return WeatherService
