local wezterm = require("wezterm")
local config = {}

-- Cursor
config.hide_mouse_cursor_when_typing = true

-- Fonts and window
config.font = wezterm.font("RobotoMono Nerd Font")
config.font_size = 11

config.freetype_load_target = "HorizontalLcd"
-- config.freetype_render_target = "Normal"

-- Padding
config.window_padding = {
	left = "0.0cell",
	right = "0.0cell",
	top = "0.0cell",
	bottom = "0.0cell",
}

-- Wayland
config.front_end = "OpenGL"
config.enable_wayland = true

-- Mux server
config.unix_domains = {
	{
		name = "unix",
	},
}

-- Colors
local use_dark_theme = true
-- NOTE: Above line is controlled by ~/.config/sway/dark_theme.sh and ~/.config/sway/light_theme.sh

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	-- return tab_info.active_pane.title, tab_info.tab_index
	return tab_info.tab_index
end

local function tab_theme(
	active_tab_background,
	inactive_tab_background,
	_active_tab_foreground,
	inactive_tab_foreground
)
	wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, _max_width)
		-- local _title, index = tab_title(tab)
		local index = tab_title(tab)
		-- title = wezterm.truncate_right(title, max_width - 2)
		if tab.is_active then
			return {
				{ Background = { Color = inactive_tab_background } },
				{ Foreground = { Color = inactive_tab_foreground } },
				{ Text = " " .. index .. "*" },
				{ Foreground = { Color = inactive_tab_background } },
			}
		else
			return {
				{ Background = { Color = inactive_tab_background } },
				{ Foreground = { Color = inactive_tab_foreground } },
				{ Text = " " .. index .. " " },
			}
		end
	end)

	config.window_frame = {
		font = wezterm.font({ family = "FiraCode Nerd Font", weight = "Regular" }),
		font_size = 11.0,
		active_titlebar_bg = inactive_tab_background,
		inactive_titlebar_bg = inactive_tab_background,
	}
end

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
if use_dark_theme then
	config.colors = {
		foreground = "#ECE1D7",
		background = "#292522",
		cursor_bg = "#ECE1D7",
		cursor_border = "#ECE1D7",
		cursor_fg = "#292522",
		selection_bg = "#403A36",
		selection_fg = "#ECE1D7",
		split = "#403A36",

		ansi = {
			"#34302C",
			"#BD8183",
			"#78997A",
			"#E49B5D",
			"#7F91B2",
			"#B380B0",
			"#7B9695",
			"#C1A78E",
		},
		brights = {
			"#867462",
			"#D47766",
			"#85B695",
			"#EBC06D",
			"#A3A9CE",
			"#CF9BC2",
			"#89B3B6",
			"#ECE1D7",
		},
		tab_bar = {
			inactive_tab_edge = "#403A36",
			background = "#403A36",
		},
	}
	tab_theme("#403A36", "#403A36", "#ECE1D7", "#ECE1D7")
else
	config.colors = {
		foreground = "#54433A",
		background = "#F1F1F1",
		cursor_bg = "#54433A",
		cursor_border = "#54433A",
		cursor_fg = "#F1F1F1",
		selection_bg = "#D9D3CE",
		selection_fg = "#54433A",
		split = "#C1C1C1",
		ansi = {
			"#E9E1DB",
			"#C77B8B",
			"#6E9B72",
			"#BC5C00",
			"#7892BD",
			"#BE79BB",
			"#739797",
			"#7D6658",
		},
		brights = {
			"#A98A78",
			"#BF0021",
			"#3A684A",
			"#A06D00",
			"#465AA4",
			"#904180",
			"#3D6568",
			"#54433A",
		},
		tab_bar = {
			inactive_tab_edge = "#D9D3CE",
			background = "#C1C1C1",
		},
	}

	tab_theme("#C1C1C1", "#C1C1C1", "#54433A", "#54433A")
end
-- config.colors = {
-- 	foreground = "#dadada",
-- 	background = "#1a1a1a",
-- 	cursor_bg = "#bfad9e",
-- 	cursor_border = "#bfad9e",
-- 	cursor_fg = "#1a1a1a",
-- 	selection_bg = "#2d2d2d",
-- 	selection_fg = "#c0af8c",
-- 	ansi = { "#1a1a1a", "#d29393", "#b3b393", "#cbaa89", "#a8a1be", "#b39fb0", "#c0af8c", "#dadada" },
-- 	brights = { "#5b5b5b", "#c95954", "#828040", "#a6794c", "#5a6599", "#9c6995", "#74a39e", "#ffffff" },
-- }
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

-- Scrollback
config.scrollback_lines = 4000

-- Inactive Window Behavior

-- config.inactive_pane_hsb = {
-- 	saturation = 0.93,
-- 	brightness = 0.85,
-- }

config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
}

-- Keymaps
local act = wezterm.action
config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{
		key = "v",
		mods = "ALT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "ALT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "f",
		mods = "ALT",
		action = act.TogglePaneZoomState,
	},
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "e",
		mods = "LEADER",
		action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "P",
		mods = "LEADER|SHIFT",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "N",
		mods = "LEADER|SHIFT",
		action = act.MoveTabRelative(1),
	},
	{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{
		key = "l",
		mods = "ALT",
		action = act.ActivatePaneDirection("Right"),
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
		key = "R",
		mods = "LEADER|SHIFT",
		action = act.RotatePanes("CounterClockwise"),
	},
	{ key = "r", mods = "LEADER", action = act.RotatePanes("Clockwise") },
	{
		key = "d",
		mods = "LEADER",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "d",
		mods = "ALT",
		action = act.CloseCurrentPane({ confirm = false }),
	},
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- {
	-- 	key = "a",
	-- 	mods = "LEADER",
	-- 	action = act.AttachDomain("unix"),
	-- },
	-- {
	-- 	key = "d",
	-- 	mods = "LEADER",
	-- 	action = act.DetachDomain({ DomainName = "unix" }),
	-- },
	{
		key = "<",
		mods = "LEADER|SHIFT",
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
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
	},
	{
		key = "e",
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
for tab_idx = 0, 9 do
	table.insert(config.keys, { key = tostring(tab_idx), mods = "LEADER", action = act.ActivateTab(tab_idx) })
end
return config
