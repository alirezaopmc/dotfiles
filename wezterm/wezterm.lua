-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Helper functions
local function is_dark_mode()
	local handle =
		io.popen([[osascript -e 'tell application "System Events" to tell appearance preferences to get dark mode']])
	if handle then
		local result = handle:read("*a")
		handle:close()
		return result:match("true") ~= nil
	end
	return true -- default to dark if detection fails
end

-- Track current theme
local is_dark = is_dark_mode()

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Define Leader Key
config.leader = { key = ";", mods = "CTRL", timeout_milliseconds = 1000 }

-- Set Keys
config.keys = {
	-- <leader>;t => Toggle between dark/light
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			is_dark = not is_dark
			local overrides = window:get_config_overrides() or {}
			overrides.color_scheme = is_dark and "Tokyo Night Storm" or "Tokyo Night Day"
			window:set_config_overrides(overrides)
			-- window:toast_notification("WezTerm", "Theme switched to " .. overrides.color_scheme, nil, 3000)
		end),
	},
	{
		key = ";",
		mods = "LEADER",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
}

-- Font configuration
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 16.0

-- Apply the color scheme
config.color_scheme = "Tokyo Night Storm"

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

-- And finally, return the configuration to wezterm
return config
