local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

return {
	color_scheme = "Catppuccin Frappe",

	font = wezterm.font_with_fallback({
		{ family = "FiraCode Nerd Font", weight = "Medium" },
		"Noto Emoji",
		"SF Pro",
	}),

	adjust_window_size_when_changing_font_size = false,
	-- line_height = 1.4,
	font_size = 13,

	show_new_tab_button_in_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,

	cursor_blink_rate = 0,
	default_cursor_style = "SteadyBar",

	-- removes title bar
	window_decorations = "RESIZE",
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	window_background_opacity = 0.9,
	macos_window_background_blur = 20,

	debug_key_events = false,
	use_ime = true,
	use_dead_keys = false,
	scrollback_lines = 5000,

	window_close_confirmation = "NeverPrompt",

	-- make both left and right alt behave in the same, normal, way
	-- wezfurlong.org/wezterm/config/keyboard-concepts.html?highlight=right%20option#macos-left-and-right-option-key
	send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,

	keys = {
		{ key = "Enter", mods = "CMD", action = act.ActivateCopyMode },
		{ key = "l", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
		{ key = "h", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = false }) },
		{ key = "q", mods = "CMD", action = act.QuitApplication },
	},

	-- -- https://github.com/wez/wezterm/issues/119#issuecomment-1206593847
	-- mouse_bindings = {
	-- 	{
	-- 		event = { Up = { streak = 1, button = "Left" } },
	-- 		mods = "NONE",
	-- 		action = wezterm.action.CompleteSelection("PrimarySelection"),
	-- 	},
	--
	-- 	{
	-- 		event = { Up = { streak = 1, button = "Left" } },
	-- 		mods = "CMD",
	-- 		action = wezterm.action.OpenLinkAtMouseCursor,
	-- 	},
	--
	-- 	{
	-- 		event = { Down = { streak = 1, button = "Left" } },
	-- 		mods = "CTRL",
	-- 		action = wezterm.action.Nop,
	-- 	},
	-- },
}
