#!/bin/bash

# Dots
rsync -r ~/.config/status-rs/ ./config/status-rs
rsync -r ~/.config/sway/ ./config/sway
rsync -r ~/.config/swaync/ ./config/swaync
rsync -r ~/.config/rofi/ ./config/rofi

# Homedir dots
rsync -r ~/.wezterm.lua ./homedir/ 
rsync -r ~/.tmux.conf ./homedir/ 
rsync -r ~/.taskrc ./homedir/ 
rsync -r ~/.gtkrc-2.0 ./homedir/ 

# Packages
paru -Qqe > paclist.txt
