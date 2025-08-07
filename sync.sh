#!/bin/bash

# Dots
rsync -r ~/.config/status-rs/ ./config/status-rs
rsync -r ~/.config/rofi/ ./config/rofi
rsync -r ~/.config/foot/ ./config/foot
rsync -r ~/.config/i3bar-river/ ./config/i3bar-river
rsync -r ~/.config/river/ ./config/river
rsync -r ~/.config/zellij/ ./config/zellij

# Homedir dots
rsync -r ~/.wezterm.lua ./homedir/ 
rsync -r ~/.tmux.conf ./homedir/ 
rsync -r ~/.taskrc ./homedir/ 
rsync -r ~/.gtkrc-2.0 ./homedir/ 

# Packages
paru -Qqe > paclist.txt
