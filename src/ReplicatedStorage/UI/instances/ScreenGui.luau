-- Game Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Packages --
local React = require(ReplicatedStorage.Packages.React)
local e = React.createElement
-- UI --
local UI_Utils = require(script.Parent.Parent.UI_Utils)

export type ScreenGuiProps = {
	-- https://create.roblox.com/docs/en-us/reference/engine/enums/SafeAreaCompatibility
	-- None: 0
	-- FullscreenExtension: 1
	SafeAreaCompatibility: Enum.SafeAreaCompatibility?,
	-- https://create.roblox.com/docs/ja-jp/reference/engine/enums/ScreenInsets
	-- None: 0
	-- DeviceSafeInsets: 1
	-- CoreUISafeInsets: 2
	-- TopbarSafeInsets: 3
	ScreenInsets: Enum.ScreenInsets?,
	Enabled: boolean?,
	Name: string?,
	ResetOnSpawn: boolean?,
	AutoLocalize: boolean?,
	children: React.ReactNode?,
}

local defaultProps = {
	SafeAreaCompatibility = Enum.SafeAreaCompatibility.FullscreenExtension,
	ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets,
	Enabled = true,
	Name = "ScreenGui",
	ResetOnSpawn = false,
	AutoLocalize = true,
	children = nil,
}

return function(props: ScreenGuiProps?): createElementFn
	local resolved = UI_Utils.ResolveProps(props, defaultProps)

	return e("ScreenGui", {
		SafeAreaCompatibility = resolved.SafeAreaCompatibility,
		ScreenInsets = resolved.ScreenInsets,
		Enabled = resolved.Enabled,
		Name = resolved.Name,
		ResetOnSpawn = resolved.ResetOnSpawn,
		AutoLocalize = resolved.AutoLocalize,
	}, props and props.children)
end
