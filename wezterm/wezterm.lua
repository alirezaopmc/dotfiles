-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Load the external color scheme
config.color_schemes = {
	["tokyonight_night"] = wezterm.color.load_scheme(os.getenv("HOME") .. "/.config/wezterm/tokyonight_night.toml"),
}

-- Font configuration
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 16.0

-- Apply the color scheme
config.color_scheme = "tokyonight_night"

-- Set initial background opacity (1.0 = opaque, 0.0 = fully transparent)
config.window_background_opacity = 0.8

-- Define the opacity levels
local opacity_levels = {
	opaque = 1.0,
	translucent = 0.8,
}

-- Event handler to toggle opacity
wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity or overrides.window_background_opacity == opacity_levels.opaque then
		overrides.window_background_opacity = opacity_levels.translucent
	else
		overrides.window_background_opacity = opacity_levels.opaque
	end
	window:set_config_overrides(overrides)
end)

-- Keybinding for 'CMD+;'
config.keys = {
	{
		key = ";",
		mods = "CMD",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
}

-- And finally, return the configuration to wezterm
return config
