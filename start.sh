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
    proxychains debtap hugo chezmoi man\
    
\
    ranger google-chrome qutebrowser calibre libreoffice-fresh \
    qv2ray redshift vlc juk qemu samba fcitx fcitx-googlepinyin \
\
    base-devel gdb clang \
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

# oh-my-zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# dot-files
chezmoi init git@github.com:glyh/dotfiles.git
chezmoi apply
chezmoi update
