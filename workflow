## Kill buzzer so you won't hear noise anymore 
rmmod pcspkr # kill that fucking buzzer

## Set Keyboard layouts
ls /usr/share/kbd/keymaps/**/*.map.gz | less # Find all keyboard layout
loadkeys de-latin1 # An example for load keyboard layouts

## Boot mode
ls /sys/firmware/efi/efivars # Verrify UEFI boot mode

## Networking
rfkill list 
rfkill unblock (blocked-internet)

## For wifi. 
iwctl
device list 
station (device) scan 
station (device) get-networks
station (device) connect SSID

## Set up ntp server 
timedatectl set-ntp true

## Partioning
fdisk -l 
fdisk
# Do not change type codes in a GPT disk, it may results in system fail to boot. 
# First delete everything, then creates some partions, write on exit. 

## Build file systems 
mkfs.ext4 /dev/(root_partition) # For linux file system is common to use ext4
mkfs.vfat -F32 /dev/(boot_partition) # For UEFI boot partion is common to use FAT32
mkswap /dev/(swap_partion) # Make swap

## Mount up devices
mount /dev/(root_partition) /mnt
mkdir /mnt/boot
mount /dev/(boot_partion) /mnt/boot
swapon /dev/(swap_partion)

## Update Mirrorlist 
echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch" > /etc/pacman.d/mirrorlist
pacman -Syy

## Install linux
pacstrap /mnt base linux linux-firmware

## Install some softwares so you can easily install something else after reboot
pacstrap /mnt git base-devel vi vim neovim networkmanager # Use pacstrap instead

## Install xorg. xsel manage clipboard for neovim
pacstrap /mnt xorg xorg-xinit xsel

## Install GRUB
pacstrap /mnt grub efibootmgr (amd-ucode)

## Generate partion table for GRUB
genfstab -U /mnt >> /mnt/etc/fstab

## Chroot to new system
arch-chroot /mnt

## Localization

# Set timezone
ln -sf /usr/share/zoneinfo/(Reigon)/(City) /etc/localtime

hwclock --systohc

vim /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf
# echo KEYMAP=de_latin1 >> /etc/vconsole.conf # If set keyboard layout. 

## Set hostname
echo (myhostname) >> /etc/hostname
vim /etc/hosts
# 127.0.0.1	localhost
# ::1		localhost
# 127.0.1.1	(myhostname).localdomain	(myhostname)

## Password for root
passwd

## config GRUB
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

## enable NetworkManager so your machine can connect to web automatically 
systemctl enable NetworkManager.service
# if it failed to connect automatically, you may need to use nmcli to start it manually
# see: `man nmcli` and `man nmcli-examples`

## Install Window Manager and Display Manager, Screen Locker
pacman -S sddm awesome-luajit 
systemctl enable sddm

## Install alacritty instead of xterm 
pacman -S alacritty 

## Exit and reboot to our fresh Arch Linux 
exit 
umount -R /mnt
reboot

## root users are rarely used as common users for security reasons. 
# we want to add some users.
visudo 
# uncomment wheel group
# make sure shell is in the place
useradd -m -G wheel -s /bin/bash (username)
passwd (username)

## Copy touchpad configuration to xorg.conf.d
cp ./30-touchpad.conf /etc/X11/xorg.conf.d/

## Set mirrorlists (for this computer)
echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch" > /etc/pacman.d/mirrorlist
pacman -Syy

## Disable the fucking buzzer!
rmmod pcspkr 
touch /etc/modprobe.d/blacklist.conf
echo "blacklist pcspkr" >> /etc/modprobe.d/blacklist.conf

## su to common user.
su (username) # we don't need root privilage any more. 

## Install yay
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

## Install sound 
yay -S pulseaudio pulseaudio-bluetooth ncpamixer pavolume

## Install bluetooth
yay -S bluez bluez-utils
lsmod | grep btusb
# If no "btusb" displayed in lsmod, load it.
modprobe btusb
enable bluetooth service

## System tools: 

## Install shell, manuals and ssh
yay -S fish man-pages man-db openssh
# omf framework
curl -L https://raw.fastgit.org/oh-my-fish/oh-my-fish/master/bin/install >> setup-omf.fish
export OMF_REPO_URI=https://hub.fastgit.org/oh-my-fish/oh-my-fish
fish setup-omf.fish

omf i batman z fzf
omf i https://hub.fastgit.org/franciscolourenco/done https://hub.fastgit.org/jorgebucaran/autopair.fish                0

# change default shell to fish
sudo usermod -s /bin/fish (username)

## Install mount tool, file explorer, extract tool
yay -S udiskie ranger pcmanfm atool

## Install backup softwares
yay -S timeshift

## Install proxy softwares
yay -S v2ray proxychains
# Notice: v2ray core executable path is : /usr/bin/v2ray, 
# while v2ray asset dir is : v2ray/usr/share/v2ray 
# how to replace proxy: 

# install v2ray
# install qv2ray(from hub.fastgit.org)
# proxychains to install qv2ray maually. 
# see brave man pages to set ssytem proxy for brave. 
# install proxyomega for brave on chrome store.
# done. 

## Install IME
yay -S fcitx fcitx-sogoupinyin

## Install frontends 
yay -S network-manager-applet blueman
# Qv2ray should be install from hub.fastgit.org, since github is really slow. 

## Install working softwares
yay -S calibre libreoffice-fresh

## Install KVM
yay -S qemu samba

## Install multimedia
yay -S feh cmus vlc

## Install other tools for awesome
yay -S betterlockscreen unclutter rofi

## Install other tools
yay -S redshift chezmoi aria2 debtap hugo

## Install ariaNg, aria.conf for aria
# from https://github.com/mayswind/AriaNg/releases (all in one)
# extract as ariagng.htm to 
# to ~/.local/bin/

# clone https://github.com/P3TERX/aria2.conf.git 
# copy the files to ~/.aira2

## Install development softwares

yay -S gdb clang leiningen joker-bin clj-kondo nodejs yarn python python-pip
# Set PATH may be needed for yarn and pip.

## Install themes
git clone --recursive https://github.com/lcpz/awesome-copycats.git
mv -bv awesome-copycats/* ~/.config/awesome && rm -rf awesome-copycats

## Recover dot files
chezmoi init https://github.com/glyh/dotfiles.git
chezmoi apply
chezmoi update

# Install through proxy(They are huge):
proxychains yay -S brave adobe-source-han-sans-otc-fonts nerdfont-fira-mono

## Install SpaceVim

# markdown format for nvim. 
yarn global add  remark, remark-cli, remark-stringify, remark-frontmatter, wcwidth
pip install pylint yapf

## Recover dot files again to overwrite.
chezmoi update

## Hardware accleration for video decode
yay -S libva-vdpau-driver-chromium gst-libav komorebi
