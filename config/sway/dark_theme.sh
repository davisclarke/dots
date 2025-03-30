#!/bin/bash
# Change a few lines to match scheme
sed -i "s/vim.opt.background = 'light'/vim.opt.background = 'dark'/g" /home/davisc/.config/nvim/init.lua
# sed -i 's/config.colors = kanagawa_lotus/config.colors = kanagawa_wave/g' /home/davisc/.wezterm.lua
sed -i 's/use_dark_theme = false/use_dark_theme = true/g' /home/davisc/.wezterm.lua
sed -i 's/zenwritten_light/zenwritten_dark/g' /home/davisc/.config/sway/config
sed -i 's/zenwritten-light.rasi/zenwritten-dark.rasi/g' /home/davisc/.config/rofi/config.rasi
sed -i 's/"mode": "light"/"mode": "dark"/g' /home/davisc/.config/zed/settings.json
sed -i 's/kanagawa-lotus.css/kanagawa-wave.css/g' /home/davisc/.config/swaync/style.css
gsettings set org.gnome.desktop.interface gtk-theme "zenwritten-dark"
gsettings set org.gnome.desktop.interface icon-theme 'zenwritten-dark'

# Send command to all running instances of nvim
swaymsg reload

ls $XDG_RUNTIME_DIR/nvim.*.0 | xargs -I {} nvim --server {} --remote-expr "execute('set background=dark')"

systemctl restart swaync --user

