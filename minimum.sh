#!/usr/bin/env bash

cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S qtile ssdm

yay -S \
    fish alacritty nerd-fonts-fira-mono neovim ranger openssh\
    network-manager-applet brave redshift 
