local wezterm = require("wezterm")
local config = {}

-- Cursor
config.hide_mouse_cursor_when_typing = true

-- Fonts and window
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 12

config.freetype_load_target = "HorizontalLcd"
config.freetype_render_target = "Light"

-- Padding
config.window_padding = {
	left = "0.0cell",
	right = "0.0cell",
	top = "0.0cell",
	bottom = "0.0cell",
}

-- Wayland
config.enable_wayland = true

config.animation_fps = 1

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
	return tab_info.tab_index
end

local function tab_theme(active_tab_background, inactive_tab_background, active_tab_foreground, inactive_tab_foreground)
	wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, _max_width)
		local title = tab_title(tab)
		if tab.is_active then
			return {
				{ Background = { Color = active_tab_background } },
				{ Foreground = { Color = active_tab_foreground } },
				{ Text = "*" .. title .. " " },
				{ Foreground = { Color = inactive_tab_background } },
			}
		else
			return {
				{ Background = { Color = inactive_tab_background } },
				{ Foreground = { Color = inactive_tab_foreground } },
				{ Text = "" .. title .. " " },
			}
		end
	end)

	config.window_frame = {
		font = wezterm.font({ family = "FiraCode Nerd Font", weight = "Regular" }),
		font_size = 12.0,
		active_titlebar_bg = inactive_tab_background,
		inactive_titlebar_bg = inactive_tab_background,
	}
end

config.use_fancy_tab_bar = false
-- config.tab_bar_at_bottom = true
if use_dark_theme then
	config.colors = {
		foreground = "#BBBBBB",
		background = "#191919",
		cursor_fg = "#191919",
		cursor_bg = "#C9C9C9",
		cursor_border = "#191919",
		selection_fg = "#BBBBBB",
		selection_bg = "#404040",
		ansi = { "#191919", "#DE6E7C", "#819B69", "#B77E64", "#6099C0", "#B279A7", "#66A5AD", "#BBBBBB" },
		-- Replace #3D3839
		brights = { "#8E8E8E", "#E8838F", "#8BAE68", "#D68C67", "#61ABDA", "#CF86C1", "#65B8C1", "#8E8E8E" },
		split = "#303030",
		tab_bar = {
			inactive_tab_edge = "#888F94",
			background = "#303030",
		},
	}
	-- config.colors = kanagawa_wave_colors
	-- tab_theme("#26262d", "#16161d", "#c8c093")
	tab_theme("#303030", "#303030", "#BBBBBB", "#BBBBBB")
	config.color_scheme = "zenbones_dark"
else
	config.colors = {
		foreground = "#353535",
		background = "#EEEEEE",
		cursor_fg = "#EEEEEE",
		cursor_bg = "#353535",
		cursor_border = "#EEEEEE",
		selection_fg = "#353535",
		selection_bg = "#D7D7D7",
		split = "#BBBBBB",
		ansi = { "#EEEEEE", "#A8334C", "#4F6C31", "#944927", "#286486", "#88507D", "#3B8992", "#353535" },
		-- replace C6C3C3
		brights = { "#5c5c5c", "#94253E", "#3F5A22", "#803D1C", "#1D5573", "#7B3B70", "#2B747C", "#5C5C5C" },
		tab_bar = {
			inactive_tab_edge = "#888F94",
			background = "#BBBBBB",
		},
	}
	-- config.color_scheme = "zenbones"
	tab_theme("#BBBBBB", "#BBBBBB", "#353535", "#353535")
end
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false

-- Scrollback
config.scrollback_lines = 4000

-- Inactive Window Behavior

config.inactive_pane_hsb = {
	saturation = 0.93,
	brightness = 0.85,
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
	{
		key = "h",
		mods = "ALT",
		action = act.ActivatePaneDirection("Left"),
	},
	-- {
	-- 	key = "h",
	-- 	mods = "ALT",
	-- 	action = wezterm.action_callback(function(window, pane)
	-- 		local tab = window:mux_window():active_tab()
	-- 		if tab:get_pane_direction("Left") ~= nil then
	-- 			window:perform_action(act.ActivatePaneDirection("Left"), pane)
	-- 		else
	-- 			window:perform_action(act.ActivateTabRelative(-1), pane)
	-- 		end
	-- 	end),
	-- },
	{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{
		key = "l",
		mods = "ALT",
		action = act.ActivatePaneDirection("Right"),
	},
	-- {
	-- 	key = "l",
	-- 	mods = "ALT",
	-- 	action = wezterm.action_callback(function(window, pane)
	-- 		local tab = window:mux_window():active_tab()
	-- 		if tab:get_pane_direction("Right") ~= nil then
	-- 			window:perform_action(act.ActivatePaneDirection("Right"), pane)
	-- 		else
	-- 			window:perform_action(act.ActivateTabRelative(1), pane)
	-- 		end
	-- 	end),
	-- },
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
		action = act.CloseCurrentTab({ confirm = true }),
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
	{
		key = "a",
		mods = "LEADER",
		action = act.AttachDomain("unix"),
	},
	{
		key = "d",
		mods = "LEADER",
		action = act.DetachDomain({ DomainName = "unix" }),
	},
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
