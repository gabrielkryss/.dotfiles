local wezterm = require("wezterm")

local config = {}

-- 🖥️ OS-Specific Shell Configuration
if wezterm.target_triple:find("windows") then
	config.default_prog = { "pwsh.exe", "-NoLogo" }
end

-- 🧭 UI Preferences
-- Disable title bar at startup
config.window_decorations = "NONE" -- hides title bar but keeps resizable border
config.enable_tab_bar = false
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 15.0

-- Colorschemes
local catppuccin_mocha_blue_odded = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
catppuccin_mocha_blue_odded.background = "#000B17"
config.color_schemes = {
	["catppuccin_mocha_blue_odded"] = catppuccin_mocha_blue_odded,
}

config.color_scheme = "catppuccin_mocha_blue_odded"

-- 🌈 Transparency Settings
config.window_background_opacity = 0.77
config.macos_window_background_blur = 20

-- 🧠 Toggle opacity and tab bar with key bindings
config.keys = {
	-- Toggle Transparency
	{
		key = "T",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			local overrides = window:get_config_overrides() or {}
			overrides.window_background_opacity = overrides.window_background_opacity == 1.0 and 0.77 or 1.0
			window:set_config_overrides(overrides)
		end),
	},

	-- Toggle Tab Bar
	{
		key = "B",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			local overrides = window:get_config_overrides() or {}
			overrides.enable_tab_bar = overrides.enable_tab_bar == false and true or false
			window:set_config_overrides(overrides)
		end),
	},

	-- {
	-- 	key = "=",
	-- 	mods = "CTRL",
	-- 	action = wezterm.action.IncreaseFontSize,
	-- },
	-- {
	-- 	key = "-",
	-- 	mods = "CTRL",
	-- 	action = wezterm.action.DecreaseFontSize,
	-- },
	-- {
	-- 	key = "0",
	-- 	mods = "CTRL",
	-- 	action = wezterm.action.ResetFontSize,
	-- },
}

return config
