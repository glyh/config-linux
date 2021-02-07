#!/usr/bin/env bash

# pacmans -S xmonad xmonad-contrib xmobar xterm nm-applet volumeicon trayergg0 rofi picom nitrogen

cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# console applications, 
# desktop applications, 
# c development, 
# clojure development, 
# node.js environment,
# python environment
# patches

yay -S qtile 

yay -S \
    fish alacritty ttf-fira-code neovim v2ray \
    aria2 proxychains debtap hugo chezmoi man ranger openssh\
\
    network-manager-applet timeshift brave qutebrowser calibre libreoffice-fresh \
    qv2ray redshift vlc juk qemu samba fcitx fcitx-googlepinyin \
\
    gdb clang \
\
    leiningen joker-bin clj-kondo \
\
    nodejs yarn \
\
    python python-pip
\
    pulseaudio-bluetooth


# markdown format for nvim. 
yarn global add \
  remark, remark-cli, remark-stringify, remark-frontmatter, wcwidth

pip install \
  pylint yapf


# dot-files
chezmoi init https://github.com/glyh/dotfiles.git
chezmoi apply
chezmoi update

# omf framework
curl -L https://get.oh-my.fish > install
fish install --config=~/.config/omf
