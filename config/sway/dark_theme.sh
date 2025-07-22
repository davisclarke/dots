#!/bin/bash
# Change a few lines to match scheme
sed -i "s/vim.opt.background = 'light'/vim.opt.background = 'dark'/g" /home/davisc/.config/nvim/init.lua
# sed -i 's/use_dark_theme = false/use_dark_theme = true/g' /home/davisc/.wezterm.lua
kitten themes --cache-age=-1 --reload-in=all Jellybeans
sed -i 's/jellybeans_light/jellybeans_dark/g' /home/davisc/.config/sway/config
sed -i 's/jellybeans-light.rasi/jellybeans-dark.rasi/g' /home/davisc/.config/rofi/config.rasi
sed -i 's/jellybeans-light/jellybeans-dark/g' /home/davisc/.config/status-rs/jellybeans/status-rs.toml
sed -i 's/"mode": "light"/"mode": "dark"/g' /home/davisc/.config/zed/settings.json
sed -i 's/jellybeans-light.css/jellybeans-dark.css/g' /home/davisc/.config/swaync/style.css
sed -i 's/include light-256.theme/include dark-256.theme/g' /home/davisc/.taskrc
gsettings set org.gnome.desktop.interface gtk-theme "jellybeans-dark"
gsettings set org.gnome.desktop.interface icon-theme 'jellybeans-dark'
gsettings set org.gnome.desktop.interface icon-theme 'jellybeans-dark'
# gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
# Send command to all running instances of nvim
swaync-client -rs
swaymsg reload

ls $XDG_RUNTIME_DIR/nvim.*.0 | xargs -I {} nvim --server {} --remote-expr "execute('set background=dark')"

systemctl restart swaync --user
