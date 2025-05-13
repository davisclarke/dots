#!/bin/bash

# Change a few lines to match scheme
sed -i "s/vim.opt.background = 'dark'/vim.opt.background = 'light'/g" /home/davisc/.config/nvim/init.lua
sed -i 's/use_dark_theme = true/use_dark_theme = false/g' /home/davisc/.wezterm.lua
sed -i 's/melange_dark/melange_light/g' /home/davisc/.config/sway/config
sed -i 's/melange-dark.rasi/melange-light.rasi/g' /home/davisc/.config/rofi/config.rasi
sed -i 's/"mode": "dark"/"mode": "light"/g' /home/davisc/.config/zed/settings.json
sed -i 's/melange-dark.css/melange-light.css/g' /home/davisc/.config/swaync/style.css
sed -i 's/include dark-256.theme/include light-256.theme/g' /home/davisc/.taskrc
gsettings set org.gnome.desktop.interface gtk-theme "melange-light"
gsettings set org.gnome.desktop.interface icon-theme 'melange-light'
swaync-client -rs
swaymsg reload

ls $XDG_RUNTIME_DIR/nvim.*.0 | xargs -I {} nvim --server {} --remote-expr "execute('set background=light')" 
systemctl restart swaync --user

# Send command to all running instances of nvim

