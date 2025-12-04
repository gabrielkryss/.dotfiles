local wezterm = require("wezterm")
local color_schemes = dofile(wezterm.home_dir .. "/.config/wezterm/colorscheme.lua")

local config = wezterm.config_builder()

-- 🖥️ OS-Specific Shell Configuration
if wezterm.target_triple:find("windows") then
	config.default_prog = { "pwsh.exe", "-NoLogo", "-ExecutionPolicy", "RemoteSigned" }
end

-- 🧭 UI Preferences
-- Disable title bar at startup
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE" -- hides title bar but keeps resizable border
-- config.window_decorations = "NONE"
-- config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.use_fancy_tab_bar = true
config.tab_max_width = 999
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.initial_rows = 30
config.initial_cols = 110
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 17.0
config.adjust_window_size_when_changing_font_size = false
-- Cursor
config.default_cursor_style = "BlinkingBlock"
-- Animation frame rate
config.animation_fps = 144
-- Cursor blink animation easing
config.cursor_blink_ease_in = "EaseOut"
config.cursor_blink_ease_out = "EaseOut"
-- Cursor blink rate in milliseconds
config.cursor_blink_rate = 650
-- Graphics
config.front_end = "WebGpu" -- "WebGpu" or OpenGL or "Software"

-- Colorschemes
local selected_colorscheme = "Everforest Custom"
-- local selected_colorscheme = "Everforest Dark (Gogh)"
-- local selected_colorscheme = "Everforest Dark (Gogh) Blue Modded"
-- local selected_colorscheme = "Catppuccin Mocha"
-- local selected_colorscheme = "Catppuccin Mocha Blue Modded"
-- local selected_colorscheme = "Gruvbox Material (Gogh)"
-- local selected_colorscheme = "Gruvbox Material (Gogh) Black Modded"
-- local selected_colorscheme = "rose-pine-moon"
-- local selected_colorscheme = "rose-pine-moon Black Modded"
config.color_schemes = color_schemes
config.color_scheme = selected_colorscheme
-- Set Command Palete Colors based on selected theme
config.command_palette_bg_color = color_schemes[selected_colorscheme].background
config.command_palette_fg_color = color_schemes[selected_colorscheme].foreground

-- 🌈 Transparency Settings
config.window_background_opacity = 0.77
config.win32_system_backdrop = "Auto" -- options: "Auto", "Disable", "Acrylic", "Mica", "Tabbed"
config.macos_window_background_blur = 0
-- config.kde_window_background_blur = true

-- 🧠 Toggle opacity and tab bar with key bindings
require("keymaps").apply_to_config(config)

-- Tab Bar Appearance
config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 12.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = color_schemes[selected_colorscheme].background,

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = color_schemes[selected_colorscheme].selection_bg
		or color_schemes[selected_colorscheme].background,
}

-- config.colors = {
-- 	tab_bar = {
-- 		background = color_schemes[selected_colorscheme].background,
-- 		active_tab = {
-- 			bg_color = color_schemes[selected_colorscheme].cursor_bg
-- 				or color_schemes[selected_colorscheme].selection_bg,
-- 			fg_color = color_schemes[selected_colorscheme].cursor_fg or color_schemes[selected_colorscheme].foreground,
-- 			intensity = "Bold",
-- 			underline = "None",
-- 			italic = false,
-- 			strikethrough = false,
-- 		},
-- 		inactive_tab = {
-- 			bg_color = color_schemes[selected_colorscheme].background,
-- 			fg_color = color_schemes[selected_colorscheme].foreground,
-- 		},
-- 		inactive_tab_hover = {
-- 			bg_color = color_schemes[selected_colorscheme].selection_bg or "#444444",
-- 			fg_color = color_schemes[selected_colorscheme].selection_fg or "#ffffff",
-- 			italic = true,
-- 		},
-- 		new_tab = {
-- 			bg_color = color_schemes[selected_colorscheme].background,
-- 			fg_color = color_schemes[selected_colorscheme].foreground,
-- 		},
-- 		new_tab_hover = {
-- 			bg_color = color_schemes[selected_colorscheme].selection_bg or "#444444",
-- 			fg_color = color_schemes[selected_colorscheme].selection_fg or "#ffffff",
-- 			italic = true,
-- 		},
-- 		inactive_tab_edge = color_schemes[selected_colorscheme].selection_bg or "#575757",
-- 	},
-- }

local function build_title(tab)
	local index = tab.tab_index + 1
	local pane = tab.active_pane

	local shell = pane.foreground_process_name:match("([^/\\]+)$") or "shell"
	local user = os.getenv("USERNAME") or os.getenv("USER") or "user"
	local host = pane.user_vars.HOST or os.getenv("COMPUTERNAME") or "host"
	local cwd = pane.current_working_dir and pane.current_working_dir.file_path or "~"
	cwd = cwd:gsub("^.*[/\\]", "")

	return string.format("%d: %s@%s:%s", index, shell, user, cwd)
end

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- -- Otherwise, use the title from the active pane
	-- -- in that tab
	-- return tab_info.active_pane.title

	local index = tab_info.tab_index + 1
	local pane = tab_info.active_pane

	local shell = pane.foreground_process_name:match("([^/\\]+)$") or "shell"
	local user = os.getenv("USERNAME") or os.getenv("USER") or "user"
	local host = pane.user_vars.HOST or os.getenv("COMPUTERNAME") or "host"
	local cwd = pane.current_working_dir and pane.current_working_dir.file_path or "~"
	cwd = cwd:gsub("^.*[/\\]", "")

	return string.format("%d: %s@%s:%s", index, shell, user, cwd)
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local scheme = color_schemes[selected_colorscheme]

	-- Safe fallbacks if some fields are missing
	local edge_background = scheme.tab_bar and scheme.tab_bar.background or scheme.background or "#222222"
	local background = scheme.background or scheme.cursor_bg or scheme.background
	local foreground = scheme.foreground or scheme.cursor_fg or scheme.foreground

	if tab.is_active then
		background = scheme.selection_bg or scheme.cursor_bg or scheme.background
		foreground = scheme.selection_fg or scheme.cursor_fg or scheme.foreground
	elseif hover then
		background = scheme.selection_bg or scheme.cursor_bg or scheme.background
		foreground = scheme.selection_fg or scheme.cursor_fg or scheme.foreground
	end

	local edge_foreground = background

	local title = tab_title(tab)
	title = wezterm.truncate_right(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

return config
