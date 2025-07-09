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

CLOCK = " \uf017 %H:%M:%S "
DATE = " \uf073 %m/%d "

# Requires nerdfont: https://www.nerdfonts.com
SEPARATOR_SYMBOL_LEFT = "\ue0b0"
SOFT_SEPARATOR_SYMBOL_LEFT = "\ue0b1"
SEPARATOR_SYMBOL_RIGHT = "\ue0b2"
RIGHT_MARGIN = 0
REFRESH_TIME = 10

UNPLUGGED_ICONS = {
    10: " 󰁺 ",
    20: " 󰁻 ",
    30: " 󰁼 ",
    40: " 󰁽 ",
    50: " 󰁾 ",
    60: " 󰁿 ",
    70: " 󰂀 ",
    80: " 󰂁 ",
    90: " 󰂂 ",
    100: " 󰁹 ",
}
PLUGGED_ICONS = {
    10: " 󰢜 ",
    20: " 󰂆 ",
    30: " 󰂇 ",
    40: " 󰂈 ",
    50: " 󰢝 ",
    60: " 󰂉 ",
    70: " 󰢞 ",
    80: " 󰂊 ",
    90: " 󰂋 ",
    100: "󰂅 ",
}
ERROR_ICON = "󰂑"


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
            icon = _get_closest(UNPLUGGED_ICONS, percent)
        elif status == "Not charging\n":
            icon = _get_closest(PLUGGED_ICONS, percent)
        else:
            icon = _get_closest(PLUGGED_ICONS, percent)
    except FileNotFoundError:
        percent = 0
        icon = ERROR_ICON

    battery_str = "%s%02i%% " % (icon, percent)
    # bat_cell = (battery_str, bat_bg, bat_bg)
    return battery_str


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

    screen.draw(" ")
    screen.cursor.bg = tab_bg
    draw_title(draw_data, screen, tab, index)
    screen.draw(" ")
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
        # screen.draw(SEPARATOR_SYMBOL_RIGHT)
        screen.cursor.fg = color_fg
        screen.cursor.bg = color_bg
        screen.draw(status)
    screen.cursor.bg = 0
    return screen.cursor.x


def _cell_length(cells):
    right_status_length = RIGHT_MARGIN
    for cell in cells:
        right_status_length += len(str(cell[0]))
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

    cells.append(clock)
    cells.append(date)
    if has_battery:
        cells.append(get_battery_cell())

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
