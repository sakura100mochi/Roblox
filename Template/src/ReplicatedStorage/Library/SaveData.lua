-- Name		: SaveData
-- Explain	 : ゲームが終了してもプレイヤーのデータが消えないように保存する
local save = {}

local function Loading_HideStats(player, hidedatanames)
	local DataStoreService = game:GetService("DataStoreService")
	local HideDataStore = DataStoreService:GetDataStore("HideDataStore")

	local hidestats = Instance.new("Folder")
	hidestats.Name = "hidestats"
	hidestats.Parent = player

	local nums = {}
	for i, name in ipairs(hidedatanames) do
		local stat = Instance.new("IntValue")
		stat.Name = name
		stat.Value = 0
		stat.Parent = hidestats
		nums[i] = stat
	end

	local playerid = "Player_Hide_" .. player.UserId
	local success, playerData = pcall(function()
		return HideDataStore:GetAsync(playerid)
	end)
		
	if success and playerData then
		for i, name in ipairs(hidedatanames) do
			if playerData[name] ~= nil then
				nums[i].Value = playerData[name]
			end
		end
	else if success then
		for i, name in ipairs(hidedatanames) do
				nums[i].Value = 0
		end
	else
		warn("Failed to load data for player: " .. player.Name)
	end
	end
end

local function Loading(player, datanames, hidedatanames)
	local DataStoreService = game:GetService("DataStoreService")
	local DataStore = DataStoreService:GetDataStore("DataStore")

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local nums = {}
	for i, name in ipairs(datanames) do
		local stat = Instance.new("IntValue")
		stat.Name = name
		stat.Value = 0
		stat.Parent = leaderstats
		nums[i] = stat
	end

	local playerid = "Player_" .. player.UserId
	local success, playerData = pcall(function()
		return DataStore:GetAsync(playerid)
	end)
		
	if success and playerData then
		for i, name in ipairs(datanames) do
			if playerData[name] ~= nil then
				nums[i].Value = playerData[name]
			end
		end
	else
		warn("Failed to load data for player: " .. player.Name)
	end

	if hidedatanames then
		Loading_HideStats(player, hidedatanames)
	end
end

local function Saving_HideStats(player)
	local hidestats = player:FindFirstChild("hidestats")
	if hidestats == nil then
		return
	end

	local DataStoreService = game:GetService("DataStoreService")
	local HideDataStore = DataStoreService:GetDataStore("HideDataStore")

	local datavalues = {}
	for _, child in pairs(hidestats:GetChildren()) do
		datavalues[child.Name] = child.Value
	end


	local playerid = "Player_Hide_" .. player.UserId
	local success, err = pcall(function()
		HideDataStore:SetAsync(playerid, datavalues)
	end)
		
	if not success then
		warn("Failed to save data for player: " .. player.Name .. ". Error: " .. err)
	end
end

local function Saving(player)
	local DataStoreService = game:GetService("DataStoreService")
	local DataStore = DataStoreService:GetDataStore("DataStore")

	local datavalues = {}
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		for _, child in pairs(leaderstats:GetChildren()) do
			datavalues[child.Name] = child.Value
		end
	end

	local playerid = "Player_" .. player.UserId
	local success, err = pcall(function()
		DataStore:SetAsync(playerid, datavalues)
	end)
		
	if not success then
		warn("Failed to save data for player: " .. player.Name .. ". Error: " .. err)
	end

	Saving_HideStats(player)
end

--Function Name	: LoadData
--Explain		: 保存されていたデータを読みこむ。データがなければ、新しく作成する。
--Arguments| datanames		: (table) leaderstatsの名前の一覧
--Arguments| hidedatanames	: (table) leaderstatsには表示したくないが、保存したいデータの一覧
--Return Value	: none
function save.LoadData(datanames, hidedatanames)
	game.Players.PlayerAdded:Connect(function(player) Loading(player, datanames, hidedatanames) end)
end

--Function Name	: SaveData
--Explain		: データをセーブする
--Arguments| healer	: none
--Return Value	: none
function save.SaveData()
	game.Players.PlayerRemoving:Connect(function(player) Saving(player) end)

	game:BindToClose(function()
		for _, player in pairs(game.Players:GetPlayers()) do
			Saving(player)
		end
	end)
end

return save

--*****Please put this Script at ServerScriptService*****--

-- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- local save = lib.save

-- local datanames = {"Mileage"}
-- local hidedatanames = {"Tree", "Stone"}

-- save.LoadData(datanames, hidedatanames)

--*******************************************************--



--*****Please put this Script at ServerScriptService*****--

-- local lib = require(game:GetService("ReplicatedStorage").Shared.Library)
-- local save = lib.save

-- save.SaveData()

--*******************************************************--
