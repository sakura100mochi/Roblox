local GameSettings = {
	doWeatherCycle = {
		type = "boolean",
		value = false
	},
	doDaylightCycle = {
		type = "boolean",
		value = false
	},
}

function GameSettings:checkType(type: string, value: string): boolean
	if type == "boolean" then
		return value == "true" or value == "false"
	end
	return false
end

return GameSettings