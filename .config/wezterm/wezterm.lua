local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
  {
    family = "IosevkaTerm Nerd Font Mono",
    weight = "Light",
  },
  "Noto Color Emoji",
})
config.font_rules = {
  {
    italic = true,
    font = wezterm.font_with_fallback({
      {
        family = "IosevkaTerm Nerd Font Mono",
        weight = "Light",
        style = "Italic",
      },
    }),
  },
  {
    intensity = "Bold",
    font = wezterm.font_with_fallback({
      {
        family = "IosevkaTerm Nerd Font Mono",
        weight = "Regular",
      },
    }),
  },
  {
    italic = true,
    intensity = "Bold",
    font = wezterm.font_with_fallback({
      {
        family = "IosevkaTerm Nerd Font Mono",
        weight = "Regular",
        style = "Italic",
      },
    }),
  },
}

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
config.font_size = 18

return config
