#!/bin/bash 
# Less of a mess?
sudo su 
pacman -S --needed base-devel

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ../
rm -rf paru 

# Install packages
paru -S < paclist.txt --noconfirm

# Overwrite floorp policies
mv ./misc/policies.json /usr/lib/floorp/policies.json

systemctl enable --now paccache.timer
exit

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Copy configs
cp -r ./config/. $HOME/.config/ 
cp -r ./homedir/. $HOME/

mkdir $HOME/repos

