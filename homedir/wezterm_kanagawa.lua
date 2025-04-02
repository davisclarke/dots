local kanagawa_lotus_colors = {
	foreground = "#545464",
	background = "#f2ecbc",

	cursor_bg = "#43436c",
	cursor_fg = "#dcd7ba",
	cursor_border = "#43436c",

	selection_fg = "#43436c",
	selection_bg = "#9fb5c9",

	scrollbar_thumb = "#8a8980",
	split = "#8a8980",

	ansi = { "#1F1F28", "#c84053", "#6f894e", "#77713f", "#4d699b", "#b35b79", "#597b75", "#545464" },

	brights = { "#8a8980", "#d7474b", "#6e915f", "#836f4a", "#6693bf", "#624c83", "#5e857a", "#43436c" },
}

local kanagawa_wave_colors = {
	foreground = "#d5cea3",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#1f1f28",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

local zenwritten_colors_light = {
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
-- tab_theme("#BBBBBB", "#BBBBBB", "#353535", "#353535")

local zenwritten_colors_dark = {
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
-- tab_theme("#26262d", "#16161d", "#c8c093")
