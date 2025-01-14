#!/bin/bash 
# Bit of a mess atm
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# sudo su 
# pacman -S --needed base-devel
# git clone https://aur.archlinux.org/paru.git
# cd paru
# makepkg -si
# cd ../
# rm -rf paru 
# paru -S < paclist.txt
# Get to this later
# packages_to_sift_through = { swaylock firewalld fastfetch noto-fonts noto-fonts eza btop pkgstats zotero-bin rofi-wayland kanagawa-theme-git bibata-cursor-theme lazygit firefox unzip zip lua luarocks cmake wlogout fish }

# wlr_and_sddm = { swaylock_effects sway swayidle wl-clipboard grim slurp sddm wlogout }
#
# xdg = {xdg-desktop-portal xdg-desktop-portal-wlr }
#
# gtk = { rofi-wayland waybar nwg-look kanagawa-theme-git papirus-icon-theme}
#
# essentials = { unzip zip eza pkgstats firewalld fish pacman-contrib reflector intel-ucode sof-firmware snapper }
#
# bluetooth = { blueman bluez } 
#
# lang = { lua luarocks cmake }
#
# fonts = { noto-fonts ttf-nerd-fonts-symbols ttf-meslo-nerd ttf-font-icons noto-fonts-emoji gnu-free-fonts } 

systemctl enable --now paccache.timer

cp -r ./config/. $HOME/.config/ 
cp -r ./homedir/. $HOME/
mkdir $HOME/repos

cp -r ./sddm/sddm-astronaut-theme/ /usr/share/sddm/themes/ 
cp ./sddm/default.conf /usr/lib/sddm/sddm.conf.d/

