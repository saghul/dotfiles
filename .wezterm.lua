local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font 'SauceCodePro Nerd Font Mono'
config.font_size = 16.0

config.color_scheme = 'Dracula (Official)'

config.window_decorations = "RESIZE"

config.audible_bell = "Disabled"

return config

