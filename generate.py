#!/usr/bin/env python

import json, getpass

config = {
  "audio" : "pulseaudio",
  "bootloader" : "grub-install",
  "filesystem" : "btrfs",
  "gfx_driver" : "AMD / ATI (open-source)",
  "harddrive" : {
    "path": "/dev/nvme0n1"
  },
  "hostname" : "arch",
  "kernels" : ["linux-hardened"],
  "keyboard-language" : "us",
  "mirror-region" : {
    "China" : {
      "http://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch": True,
      "https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch": True,
      "http://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch": True,
      "https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch": True,
      "http://mirrors.aliyun.com/archlinux/$repo/os/$arch": True,
      "https://mirrors.aliyun.com/archlinux/$repo/os/$arch": True
    }
  },
  "nic" : {"NetworkManager" : True},
  "ntp" : True,
  "packages" : ["base-devel"], # For paru support
  "sys-encoding": "utf-8",
  "sys-language": "en_US",
  "timezone": "Asia/Shanghai"
}

def get_pass(prompt):
  out, repeat = "", ""
  while True:
    out = getpass.getpass(prompt=prompt)
    repeat = getpass.getpass(prompt="Repeat once to confirm: ")
    if out == repeat:
      break
    else:
      print("Two input don't match!")
  return out

config["!root-password"] = get_pass("Root password (won\'t echo): ")
config["superusers"] = {input("Super user: ") : {"!password": get_pass("Super user password (won\'t echo): ")}}

with open("config.json", "w") as f:
    f.write(json.dumps(config))
