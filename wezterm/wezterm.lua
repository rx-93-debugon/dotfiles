local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("UDEV Gothic NFLG")
config.font_size = 16.0
config.line_height = 0.9
config.line_height = 0.9
config.color_scheme = "tokyonight"
config.window_background_opacity = 0.9

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	{
		key = "!",
		mods = "LEADER | SHIFT",
		action = wezterm.action_callback(function(win, pane)
			local tab, window = pane:move_to_new_window()
		end),
	},
}
return config
