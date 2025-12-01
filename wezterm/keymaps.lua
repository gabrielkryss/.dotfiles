local wezterm = require("wezterm")
local act = wezterm.action
local my_schemes = require("colorscheme")

local M = {}

-- Collect all scheme names into a sorted list
local scheme_names = {}
for name, _ in pairs(my_schemes) do
	table.insert(scheme_names, name)
end
table.sort(scheme_names)

local current_scheme_index = 1

function M.apply_to_config(config)
	-- config.disable_default_key_bindings = true

	config.keys = {
		-- Toggle Transparency
		{
			key = "F11",
			mods = "",
			action = wezterm.action_callback(function(window, pane)
				local overrides = window:get_config_overrides() or {}
				overrides.window_background_opacity = (overrides.window_background_opacity == 1.0) and 0.77 or 1.0
				window:set_config_overrides(overrides)
			end),
		},

		-- Toggle Acrylic
		{
			key = "F10",
			mods = "",
			action = wezterm.action_callback(function(window, pane)
				local overrides = window:get_config_overrides() or {}
				local current = overrides.win32_system_backdrop or "Auto"

				-- Define mode sequence
				local modes = {
					"Auto",
					"Acrylic",
					"Mica",
					"Tabbed",
				}

				-- Find next mode index
				local next_index = 1
				for i, mode in ipairs(modes) do
					if mode == current then
						next_index = (i % #modes) + 1
						break
					end
				end

				-- Optional: define actions per mode (like a switch-case)
				local mode_actions = {
					["Auto"] = function()
						overrides.window_background_opacity = 0.77
					end,
					["Acrylic"] = function()
						overrides.window_background_opacity = 0
					end,
					["Mica"] = function()
						overrides.window_background_opacity = 0
					end,
					["Tabbed"] = function()
						overrides.window_background_opacity = 0
					end,
				}

				-- Apply the next mode
				local next_mode = modes[next_index]
				overrides.win32_system_backdrop = next_mode

				-- Execute corresponding action
				if mode_actions[next_mode] then
					mode_actions[next_mode]()
				end

				window:set_config_overrides(overrides)
			end),
		},

		-- Toggle Tab Bar
		{
			key = "F12",
			mods = "",
			action = wezterm.action_callback(function(window, pane)
				local overrides = window:get_config_overrides() or {}
				overrides.enable_tab_bar = not overrides.enable_tab_bar
				window:set_config_overrides(overrides)
			end),
		},

		-- Cycle through color schemes
		{
			key = "F9",
			mods = "",
			action = wezterm.action_callback(function(window, pane)
				current_scheme_index = current_scheme_index + 1
				if current_scheme_index > #scheme_names then
					current_scheme_index = 1
				end
				local scheme = scheme_names[current_scheme_index]
				-- Apply the scheme
				local overrides = window:get_config_overrides() or {}
				overrides.color_scheme = scheme
				window:set_config_overrides(overrides)
				-- Print the scheme name (toast notification), but hard to see with glazewm
				window:toast_notification("WezTerm", "Colorscheme: " .. scheme, nil, 4000)
				-- Or if you prefer logging: use debug overly ctrl+shift+l (default)
				wezterm.log_info("Switched to colorscheme: " .. scheme)
			end),
		},

		-- Cycle backward (Shift+F9)
		{
			key = "F9",
			mods = "SHIFT",
			action = wezterm.action_callback(function(window, pane)
				current_scheme_index = current_scheme_index - 1
				if current_scheme_index < 1 then
					current_scheme_index = #scheme_names
				end
				local scheme = scheme_names[current_scheme_index]
				local overrides = window:get_config_overrides() or {}
				overrides.color_scheme = scheme
				window:set_config_overrides(overrides)
				-- Print the scheme name (toast notification), but hard to see with glazewm
				window:toast_notification("WezTerm", "Colorscheme: " .. scheme, nil, 4000)
				-- Or if you prefer logging: use debug overly ctrl+shift+l (default)
				wezterm.log_info("Switched to colorscheme: " .. scheme)
			end),
		},

		-- Vertical split (new pane below)
		{ key = '"', mods = "CTRL|SHIFT|ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		-- { -- Doesn't work
		-- 	key = "|",
		-- 	mods = "CTRL|SHIFT|ALT",
		-- 	action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		-- },
		-- Horizontal split (new pane right)
		{
			key = "%",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- { -- Doesn't work
		-- 	key = "-",
		-- 	mods = "CTRL|SHIFT|ALT",
		-- 	action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		-- },

		-- -- Pane navigation (Ctrl+Alt, avoids conflict with Neovim)
		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
		-- -- Arrow-key pane navigation (Alt + Arrow)
		{ key = "LeftArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "UpArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "DownArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },

		-- Tab cycling (browser-like ergonomics)
		{ key = "Tab", mods = "CTRL", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

		-- Optional mnemonic fallback (brackets = left/right)
		{ key = "[", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "]", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "h", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "l", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },

		-- Toggle Fullscreen, this disables transparency and acrylic effects
		-- { key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },

		-- Font Resize
		{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
		{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

		-- Panes
		-- { key = "|", mods = "CTRL|SHIFT|ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		-- { key = "-", mods = "CTRL|SHIFT|ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		-- { key = "LeftArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
		-- { key = "RightArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
		-- { key = "UpArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
		-- { key = "DownArrow", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
		-- { key = "Z", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },
		-- { key = "W", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },

		-- Config reload
		-- { key = "R", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },
	}

	-- Optional: Workspace switching (Ghostty-style session emulation)
	-- config.key_tables = {
	-- 	switch_workspace = {
	-- 		{ key = "1", action = act.SwitchToWorkspace("dev") },
	-- 		{ key = "2", action = act.SwitchToWorkspace("sysadmin") },
	-- 		{ key = "3", action = act.SwitchToWorkspace("writing") },
	-- 	},
	-- }
end

return M
