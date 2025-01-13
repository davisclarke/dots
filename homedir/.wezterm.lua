local wezterm = require("wezterm")
local config = {}

-- Fonts and window
config.font = wezterm.font("MesloLGS Nerd Font")
config.font_size = 12
config.freetype_load_target = "HorizontalLcd"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Wayland
config.enable_wayland = true

-- Mux server
config.unix_domains = {
	{
		name = "unix",
	},
}
-- config.default_gui_startup_args = { "connect", "unix" }

-- Colors
config.color_scheme = "Kanagawa (Gogh)"

-- Tab Bar
config.use_fancy_tab_bar = false
config.colors = {
	tab_bar = {
		background = "#292638",
		active_tab = {
			bg_color = "#393648",
			fg_color = "#dcd7ba",
			italic = true,
			-- bold = true,
		},

		inactive_tab = {
			bg_color = "#292638",
			fg_color = "#dcd7ba",
		},
	},
}
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = false

-- Scrollback
config.scrollback_lines = 4000

-- Inactive Window Behavior
config.inactive_pane_hsb = {
	saturation = 0.93,
	brightness = 0.85,
}

-- Keymaps
local act = wezterm.action
config.keys = {
	{
		key = "s",
		mods = "ALT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "ALT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "f",
		mods = "ALT",
		action = act.TogglePaneZoomState,
	},
	{
		key = "C",
		mods = "SHIFT|ALT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "c",
		mods = "ALT",
		action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
	},
	{
		key = "p",
		mods = "ALT",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "ALT",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "P",
		mods = "ALT|SHIFT",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "N",
		mods = "ALT|SHIFT",
		action = act.MoveTabRelative(1),
	},
	{
		key = "h",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:mux_window():active_tab()
			if tab:get_pane_direction("Left") ~= nil then
				window:perform_action(act.ActivatePaneDirection("Left"), pane)
			else
				window:perform_action(act.ActivateTabRelative(-1), pane)
			end
		end),
	},
	{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			local tab = window:mux_window():active_tab()
			if tab:get_pane_direction("Right") ~= nil then
				window:perform_action(act.ActivatePaneDirection("Right"), pane)
			else
				window:perform_action(act.ActivateTabRelative(1), pane)
			end
		end),
	},
	{
		key = "H",
		mods = "ALT|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "J",
		mods = "ALT|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "K",
		mods = "ALT|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "L",
		mods = "ALT|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "r",
		mods = "ALT|SHIFT",
		action = act.RotatePanes("CounterClockwise"),
	},
	{ key = "r", mods = "ALT", action = act.RotatePanes("Clockwise") },
	{
		key = "x",
		mods = "SHIFT|ALT",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "x",
		mods = "ALT",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		key = ",",
		mods = "ALT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "a",
		mods = "ALT",
		action = act.AttachDomain("unix"),
	},
	{
		key = "d",
		mods = "ALT",
		action = act.DetachDomain({ DomainName = "unix" }),
	},
	{
		key = "<",
		mods = "ALT|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for session",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					mux.rename_workspace(window:mux_window():get_workspace(), line)
				end
			end),
		}),
	},
	{
		key = "w",
		mods = "ALT",
		action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
	},
	{
		key = "t",
		mods = "ALT",
		action = act.PaneSelect({
			mode = "SwapWithActive",
		}),
	},
	{
		key = "q",
		mods = "ALT",
		action = act.PaneSelect,
	},
	{
		key = "G",
		mods = "ALT|SHIFT",
		action = act.Search({ Regex = "[a-f0-9]{6,}" }),
	},
	-- {
	-- 	key = "[",
	-- 	mods = "ALT",
	-- 	action = act.ActivateCopyMode,
	-- },
	{
		key = "[",
		mods = "ALT",
		action = act.ActivateCopyMode,
	},
	{
		key = "/",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			window:perform_action(act.Search("CurrentSelectionOrEmptyString"), pane)
			window:perform_action(
				act.Multiple({
					act.CopyMode("ClearPattern"),
					act.CopyMode("ClearSelectionMode"),
					act.CopyMode("MoveToScrollbackBottom"),
				}),
				pane
			)
		end),
	},
}

return config
