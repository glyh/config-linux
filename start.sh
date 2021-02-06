#!/usr/bin/env bash

# Can't use yay sine yay depends on xorg
pacman -S xorg xorg-xinit xmonad xmonad-contrib

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
yay -S \
    zsh alacritty ttf-fira-code neovim v2ray \
    aria2 proxychains debtap hugo chezmoi man ranger openssh\
\
    nm-connection-editor timeshift google-chrome qutebrowser calibre libreoffice-fresh \
    qv2ray redshift vlc juk qemu samba fcitx fcitx-googlepinyin \
\
    gdb clang \
\
    leiningen babashka-bin joker-bin clj-kondo \
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

# oh-my-zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# dot-files
chezmoi init git@github.com:glyh/dotfiles.git
chezmoi apply
chezmoi update
