--Name		: InstanceManager
--Explain	: インスタンスマネージャー
local instanceManager = {}

instanceManager.get = require(script.Get)
instanceManager.move = require(script.Move)

return instanceManager