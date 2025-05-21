#!/bin/bash
# Change a few lines to match scheme
sed -i "s/vim.opt.background = 'light'/vim.opt.background = 'dark'/g" /home/davisc/.config/nvim/init.lua
# sed -i 's/config.colors = kanagawa_lotus/config.colors = kanagawa_wave/g' /home/davisc/.wezterm.lua
sed -i 's/use_dark_theme = false/use_dark_theme = true/g' /home/davisc/.wezterm.lua
sed -i 's/melange_light/melange_dark/g' /home/davisc/.config/sway/config
sed -i 's/melange-light.rasi/melange-dark.rasi/g' /home/davisc/.config/rofi/config.rasi
sed -i 's/"mode": "light"/"mode": "dark"/g' /home/davisc/.config/zed/settings.json
sed -i 's/melange-light.css/melange-dark.css/g' /home/davisc/.config/swaync/style.css
sed -i 's/include light-256.theme/include dark-256.theme/g' /home/davisc/.taskrc
gsettings set org.gnome.desktop.interface gtk-theme "melange-dark"
gsettings set org.gnome.desktop.interface icon-theme 'melange-dark'

# Send command to all running instances of nvim
swaync-client -rs
swaymsg reload

ls $XDG_RUNTIME_DIR/nvim.*.0 | xargs -I {} nvim --server {} --remote-expr "execute('set background=dark')"

systemctl restart swaync --user

