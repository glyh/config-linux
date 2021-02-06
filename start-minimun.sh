cd ~

pacman -S git base-devel

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

yay -S xorg xorg-xinit xmonad xmonad-contrib

# console applications, 
# desktop applications, 
# c development, 
# clojure development, 
# node.js environment,
# python environment
# patches
yay -S \
    sudo zsh alacritty ttf-fira-code nvim v2ray aria2 \
    proxychains debtap chezmoi man\
    
\
    ranger google-chrome \
    qv2ray redshift fcitx fcitx-googlepinyin \
\
    gdb clang \

# dot-files
chezmoi init git@github.com:glyh/dotfiles.git
chezmoi apply
chezmoi update
