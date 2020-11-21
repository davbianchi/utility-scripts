#!/bin/bash

set -euo pipefail

echo "Be sure to have admin permissions, the script runs several sudo ops."

# install reflector, then sort the mirrors
sudo pacman -S reflector
sudo reflector --verbose -c Germany -c France -c Italy -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syyu

# start installing packages
sudo pacman -S networkmanager xfce4-desktop git xf86-video-amdgpu xorg-server xorg-xinit ttf-dejavu ttf-fira-mono zip unzip unrar pulseaudio\
pamixer telegram-desktop python python-pip openssh xorg-xrandr nemo man mesa vulkan-radeon libva-mesa-driver mumble mesa-vdpau discord bind-tools\
gnome-keyring ccache ttf-opensans pavucontrol rclone ufw vim texlive-most biber texstudio code thunderbird papirus-icon-theme papirus-folders\
hwlock tor torbrowser-launcher network-manager-applet bash-autocompletion mousepad

# install yay
cd
git clone https://aur.archlinux.org/yay.git $HOME/yay
cd yay
makepkg -si
cd
rm -rf $HOME/yay

# install packages on aur
yay -S spotify torsocks ttf-menlo-powerline-git noto-fonts-main
