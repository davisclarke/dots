#!/bin/bash 
cp -r ./config/. $HOME/.config/ 
cp -r ./homedir/. $HOME/
mkdir $HOME/repos

sudo cp -r ./sddm/sddm-astronaut-theme/ /usr/share/sddm/themes/ 
sudo cp ./sddm/default.conf /usr/lib/sddm/sddm.conf.d/

