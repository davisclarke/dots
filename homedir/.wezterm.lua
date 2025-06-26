local wezterm = require("wezterm")
local config = {}

-- Cursor
config.hide_mouse_cursor_when_typing = true
config.force_reverse_video_cursor = true
-- Fonts and window
config.font = wezterm.font_with_fallback({ "RobotoMono Nerd Font", "FiraCode Nerd Font" })
config.font_size = 11

config.freetype_load_target = "Normal"
config.freetype_render_target = "Normal"

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
	return tab_info.active_pane.title, tab_info.tab_index
	-- return tab_info.tab_index
end
-- local function right_tab_theme(tab_background, tab_foreground) end
local function tab_theme(tab_background, tab_foreground, status_foreground)
	wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, _hover, max_width)
		local title, index = tab_title(tab)
		title = wezterm.truncate_right(title, max_width - 2)
		if tab.is_active then
			return {
				{ Background = { Color = tab_background } },
				{ Foreground = { Color = status_foreground } },
				{ Text = "  " },
				{ Foreground = { Color = tab_foreground } },
				{ Text = index .. " " .. title .. " " },
				{ Foreground = { Color = tab_background } },
			}
		else
			return {

				{ Background = { Color = tab_background } },
				{ Foreground = { Color = status_foreground } },
				{ Text = "  " },
				{ Foreground = { Color = tab_foreground } },
				{ Text = index .. " " .. title .. " " },
				{ Foreground = { Color = tab_background } },
			}
		end
	end)

	config.window_frame = {
		font = wezterm.font({ family = "RobotoMono Nerd Font", weight = "Regular" }),
		font_size = 12.0,
		active_titlebar_bg = tab_background,
		inactive_titlebar_bg = tab_background,
	}

	wezterm.on("update-right-status", function(window, _)
		local cells = {}
		local date = wezterm.strftime(" %H:%M, %b %-d")
		table.insert(cells, date)

		-- An entry for each battery (typically 0 or 1 battery)
		for _, b in ipairs(wezterm.battery_info()) do
			table.insert(cells, string.format("󰁹 %.0f%%", b.state_of_charge * 100))
		end

		-- The elements to be formatted
		local elements = {}

		-- Translate a cell into elements
		local function push(text)
			table.insert(elements, { Foreground = { Color = tab_foreground } })
			table.insert(elements, { Background = { Color = tab_background } })
			table.insert(elements, { Text = " " .. text .. " " })
		end

		while #cells > 0 do
			local cell = table.remove(cells, 1)
			push(cell)
		end

		window:set_right_status(wezterm.format(elements))
	end)
end

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
if use_dark_theme then
	config.colors = {
		foreground = "#e8e8d3", --Muted fg/bg
		background = "#101010",
		cursor_fg = "#151515",
		cursor_bg = "#e8e8d3",
		cursor_border = "#e8e8d3",
		selection_fg = "#151515",
		selection_bg = "#888888",
		compose_cursor = "#e8e8d3",
		visual_bell = "#40000a",
		split = "#99ad6a",

		ansi = {
			"#101010",
			"#cf6a4c",
			"#99ad6a",
			"#ffb964",
			"#8fbfdc",
			"#c6b6ee",
			"#668799",
			"#d4d4d4",
		},
		brights = {
			"#404040",
			"#B05050",
			"#99ad6a",
			"#dad085",
			"#8197bf",
			"#c6b6ee",
			"#2B5B77",
			"#c7c7c7",
		},
		tab_bar = {
			inactive_tab_edge = "#252525",
			background = "#99ad6a",
		},
	}
	tab_theme("#99ad6a", "#101010", "#101010")
else
	config.colors = {
		foreground = "#252525",
		background = "#f9f9f9",
		cursor_fg = "#f5e6d3",
		cursor_bg = "#252525",
		cursor_border = "#252525",
		selection_fg = "#f5e6d3",
		selection_bg = "#686868",
		compose_cursor = "#252525",
		visual_bell = "#ffe5ea",
		split = "#C1C1C1",
		ansi = {
			"#f5f5f5",
			"#954d3b",
			"#386014",
			"#876820",
			"#234291",
			"#6a4abd",
			"#2B5B77",
			"#444444",
		},
		brights = {
			"#404040",
			"#a02020",
			"#457039",
			"#a66a10",
			"#2952a3",
			"#540063",
			"#3a596a",
			"#787878",
		},
		tab_bar = {
			inactive_tab_edge = "#C1C1C1",
			background = "#C1C1C1",
		},
	}
	tab_theme("#C1C1C1", "#252525", "#234291")
end

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
			action = wezterm.action_callback(function(window, _, line)
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
			action = wezterm.action_callback(function(window, _, line)
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
