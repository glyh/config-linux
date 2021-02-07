#!/usr/bin/env bash

# Keyboard layouts
ls /usr/share/kbd/keymaps/**/*.map.gz | less # Find all keyboard layout
loadkeys de-latin1 # An example for load keyboard layouts

# Boot mode
ls /sys/firmware/efi/efivars # Verrify UEFI boot mode

# Networking
rfkill list 
rfkill unblock (blocked-internet)
# For wifi. 
iwctl
device list 
station (device) scan 
station (device) get-networks
station (device) connect SSID

# Set up ntp server 
timedatectl set-ntp true

# Partioning
fdisk -l 
fdisk
# Do not change type codes in a GPT disk, it may results in system fail to boot. 
# First delete everything, then creates some partions, write on exit. 
mkfs.ext4 /dev/(root_partition) # For linux file system is common to use ext4
mkfs.vfat -F32 /dev/(boot_partition) # For UEFI boot partion is common to use FAT32
mkswap /dev/(swap_partion) # Make swap

mount /dev/(root_partition) /mnt
mkdir /mnt/boot
mount /dev/(boot_partion) /mnt/boot
swapon /dev/(swap_partion)
vim /etc/pacman.d/mirrorlist

# Install linux
pacstrap /mnt base linux linux-firmware

# Install some softwares so you can easily install something else after reboot
pacstrap /mnt git base-devel vi vim networkmanager # Use pacstrap instead

pacstrap /mnt xorg xorg-xinit 

# Install GRUB
pacstrap /mnt grub efibootmgr (amd-ucode)

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

# Set time zone
ln -sf /usr/share/zoneinfo/(Reigon)/(City) /etc/localtime
hwclock --systohc

# Localization
vim /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf
# echo KEYMAP=de_latin1 >> /etc/vconsole.conf # If set keyboard layout. 

echo (myhostname) >> /etc/hostname
vim /etc/hosts
# 127.0.0.1	localhost
# ::1		localhost
# 127.0.1.1	(myhostname).localdomain	(myhostname)
passwd


grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager.service

exit 
umount -R /mnt
reboot

visudo 

# uncomment wheel group
# make sure shell is in the place
useradd -m -G wheel -s /bin/bash (username)
