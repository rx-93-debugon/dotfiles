local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font({ family = "UDEV Gothic NFLG", harfbuzz_features = { "calt=0", "clig=0", "liga=0" } })
config.font_size = 16.0
config.line_height = 0.9
config.line_height = 0.9
config.color_scheme = "tokyonight"
config.window_background_opacity = 0.9

return config
