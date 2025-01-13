#!/bin/bash 
cp -r ./config/. $HOME/.config/ 
cp -r ./homedir/. $HOME/
mkdir $HOME/repos

sudo cp -r ./sddm/sddm-astronaut-theme/ /usr/share/sddm/themes/ 
sudo cp ./sddm/default.conf /usr/lib/sddm/sddm.conf.d/

# Get to this later
# packages_to_sift_through = { swaylock firewalld fastfetch noto-fonts noto-fonts eza btop pkgstats zotero-bin rofi-wayland kanagawa-theme-git bibata-cursor-theme lazygit firefox unzip zip lua luarocks cmake wlogout fish }

wlr_and_sddm = { swaylock sway swayidle wl-clipboard grim slurp sddm wlogout }

gtk = { rofi-wayland waybar nwg-look }

essentials = { unzip zip eza pkgstats firewalld fish blueman }

lang = { lua luarocks cmake }




