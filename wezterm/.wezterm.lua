local wezterm = require 'wezterm'

local config = {}

-- 🖥️ OS-Specific Shell Configuration
if wezterm.target_triple:find("windows") then
  config.default_prog = { "pwsh.exe", "-NoLogo" }
end

config.window_decorations = "RESIZE"

-- 🌈 Transparency Settings
config.window_background_opacity = 0.77 
config.macos_window_background_blur = 20 

-- 🧠 Toggle opacity and tab bar with key bindings
config.keys = {
  -- Toggle Transparency
  {
    key = 'T',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      overrides.window_background_opacity =
        overrides.window_background_opacity == 1.0 and 0.77 or 1.0
      window:set_config_overrides(overrides)
    end),
  },

  -- Toggle Tab Bar
  {
    key = 'B',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      overrides.enable_tab_bar =
        overrides.enable_tab_bar == false and true or false
      window:set_config_overrides(overrides)
    end),
  },

  -- Toggle Title bar
  {
    key = 'F12',
    mods = '',
    action = wezterm.action_callback(function(window, pane)
        local overrides = window:get_config_overrides() or {}
        local current = overrides.window_decorations or "TITLE|RESIZE"

        overrides.window_decorations =
        current == "TITLE|RESIZE" and "RESIZE" or "TITLE|RESIZE"

        window:set_config_overrides(overrides)
    end),
  },
}

-- 🧭 UI Preferences
config.enable_tab_bar = false

return config