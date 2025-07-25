# pyright: reportMissingImports=false
import os
from datetime import datetime
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.utils import color_as_int
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_title,
)

# Battery Path (for Linux)
bat_path = "/sys/class/power_supply/BAT0"

# GLOBAL STATE!
timer_id = None
right_status_length = -1
has_battery = os.path.isdir(
    bat_path
)  # Enable battery icon only if the above path exists, only check on first load


opts = get_options()


CLOCK = "\uf017 %H:%M "
clock_fg = as_rgb(color_as_int(opts.foreground))
clock_bg = as_rgb(color_as_int(opts.tab_bar_background))

DATE = "  %Y-%m-%d "
date_fg = as_rgb(color_as_int(opts.foreground))
date_bg = as_rgb(color_as_int(opts.tab_bar_background))

# Requires nerdfont: https://www.nerdfonts.com
RIGHT_MARGIN = 0
REFRESH_TIME = 5


# def _draw_icon(screen: Screen, index: int) -> int:
#     if index != 1:
#         return 0
#     fg, bg = screen.cursor.fg, screen.cursor.bg
#     screen.cursor.fg = icon_fg
#     screen.cursor.bg = icon_bg
#     screen.draw(ICON)
#     screen.cursor.fg = icon_bg
#     screen.cursor.bg = bg
#     screen.draw(" ")
#     screen.cursor.fg = fg
#     screen.cursor.x = len(ICON) + len(" ")
#     return screen.cursor.x


UNPLUGGED_ICONS = {
    10: "󰁺",
    20: "󰁻",
    30: "󰁼",
    40: "󰁽",
    50: "󰁾",
    60: "󰁿",
    70: "󰂀",
    80: "󰂁",
    90: "󰂂",
    100: "󰁹",
}
PLUGGED_ICONS = {
    10: "󰢜 ",
    20: "󰂆 ",
    30: "󰂇 ",
    40: "󰂈 ",
    50: "󰢝 ",
    60: "󰂉 ",
    70: "󰢞 ",
    80: "󰂊 ",
    90: "󰂋 ",
    100: "󰂅 ",
}
ERROR_ICON = "󰂑"

UNPLUGGED_COLORS = {
    15: as_rgb(color_as_int(opts.color1)),
    16: as_rgb(color_as_int(opts.color3)),
    80: as_rgb(color_as_int(opts.color3)),
    100: as_rgb(color_as_int(opts.color2)),
}
PLUGGED_COLORS = {
    15: as_rgb(color_as_int(opts.color1)),
    16: as_rgb(color_as_int(opts.color6)),
    80: as_rgb(color_as_int(opts.color6)),
    100: as_rgb(color_as_int(opts.color2)),
}


bat_fg = as_rgb(color_as_int(opts.foreground))
bat_bg = as_rgb(color_as_int(opts.tab_bar_background))


def _get_closest(dictionary, value):
    keys = dictionary.keys()

    def min_distance(x):
        return abs(x - value)

    closestIdx = min(keys, key=min_distance)
    return dictionary[closestIdx]


def get_battery_cell():
    try:
        with open(os.path.join(bat_path, "status"), "r") as f:
            status = f.read()
        with open(os.path.join(bat_path, "capacity"), "r") as f:
            percent = int(f.read())
        if status == "Discharging\n":
            # bat_bg = _get_closest(UNPLUGGED_COLORS, percent)
            icon = _get_closest(UNPLUGGED_ICONS, percent)
        elif status == "Not charging\n":
            # bat_bg = _get_closest(UNPLUGGED_COLORS, percent)
            icon = _get_closest(PLUGGED_ICONS, percent)
        else:
            # bat_bg = _get_closest(PLUGGED_COLORS, percent)
            icon = _get_closest(PLUGGED_ICONS, percent)
    except FileNotFoundError:
        percent = 0
        # bat_bg = _get_closest(UNPLUGGED_COLORS, percent)
        icon = ERROR_ICON

    battery_str = " %s %02i%%" % (icon, percent)
    bat_cell = (battery_str, bat_fg, bat_bg)
    return bat_cell


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    if screen.cursor.x >= screen.columns - right_status_length:
        return screen.cursor.x
    tab_bg = screen.cursor.bg
    tab_fg = screen.cursor.fg
    default_bg = as_rgb(int(draw_data.default_bg))
    # if extra_data.next_tab:
    #     next_tab_bg = as_rgb(draw_data.tab_bg(extra_data.next_tab))
    # else:
    #     next_tab_bg = default_bg

    # screen.draw(" ")
    screen.cursor.bg = tab_bg
    draw_title(draw_data, screen, tab, index)
    prev_fg = screen.cursor.fg
    if tab_bg == tab_fg:
        screen.cursor.fg = default_bg
    # screen.draw(" " + " ")
    screen.cursor.fg = prev_fg
    end = screen.cursor.x
    return end


def _draw_right_status(screen: Screen, is_last: bool, cells: list) -> int:
    if not is_last:
        return 0
    draw_attributed_string(Formatter.reset, screen)
    screen.cursor.x = screen.columns - right_status_length
    screen.cursor.fg = 0
    for status, color_fg, color_bg in cells:
        screen.cursor.fg = color_bg
        screen.draw(" ")
        screen.cursor.fg = color_fg
        screen.cursor.bg = color_bg
        screen.draw(status)
    screen.cursor.bg = 0
    return screen.cursor.x


def _cell_length(cells):
    right_status_length = RIGHT_MARGIN
    for cell in cells:
        right_status_length += len(str(cell[0])) + len(str(" "))
    return right_status_length


def _redraw_tab_bar(_):
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id
    global right_status_length
    global has_battery
    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME, True)
    now = datetime.now()
    clock = now.strftime(CLOCK)
    date = now.strftime(DATE)
    cells = []
    if has_battery:
        cells.append(get_battery_cell())
    cells.append((date, date_fg, date_bg))
    cells.append((clock, clock_fg, clock_bg))

    right_status_length = _cell_length(cells)

    _draw_left_status(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )
    _draw_right_status(
        screen,
        is_last,
        cells,
    )
    return screen.cursor.x
