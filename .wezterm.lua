-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Disable the tab bar
config.enable_tab_bar = false
config.cell_width = 0.83
config.line_height = 0.9

config.window_decorations = "NONE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- config.disable_default_key_bindings = true

config.window_background_opacity = 0.85
config.font_size = 23

-- and finally, return the configuration to wezterm
return config
