#!/usr/bin/env bash

pacstrap /mnt base linux linux-firmware

pacstrap /mnt git base-devel vi vim networkmanager # Use pacstrap instead

pacman -S grub efibootmgr amd-ucode
