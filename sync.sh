#!/bin/bash

# Dots
rsync -r ~/.config/status-rs/ ./config/
rsync -r ~/.config/sway/ ./config/
rsync -r ~/.config/swaync/ ./config/
rsync -r ~/.config/rofi/ ./config/

# Homedir dots
rsync -r ~/.wezterm.lua ./homedir/ 
rsync -r ~/.tmux.conf ./homedir/ 
rsync -r ~/.taskrc ./homedir/ 
rsync -r ~/.gtkrc-2.0 ./homedir/ 
