# GUIDE SETUP NEW DESKTOP
> Arch Linux

> [!WARNING]
> This guide was made by me, and is adapted to my needs, its not supposed to be
> a universal guide, and no guarantee comes with it.

> [!NOTE]
> Note that this giude/config is inspired from many sources on the web, when I
> remember where I got a tip from, I'll try to mention it, but I might (more
> like will) ommit some, please excuse me for that.

## Initial setup

- Main source: [Arch wiki](https://wiki.archlinux.org/title/Installation_guide)

- US keyboard (default)
```sh
loadkeys us
```
- French keyboard
```sh
loadkeys fr
```

### Disk (LVM on LUKS)

Recommendations: swap size = half of RAM size, boot 1G

Example of a working config:
```sh
NAME                     RM   SIZE RO TYPE  MOUNTPOINTS
nvme0n1                   0 465.8G  0 disk
├─nvme0n1p1               0     1G  0 part  /boot
└─nvme0n1p2               0 464.8G  0 part
  └─vaultboy_nvme         0 464.7G  0 crypt
    ├─vaultboy_nvme-swap  0     8G  0 lvm   [SWAP]
    ├─vaultboy_nvme-root  0 224.7G  0 lvm   /
    └─vaultboy_nvme-home  0   232G  0 lvm   /home
```

For the crypted disk setup (LVM on LUKS):
```sh
cryptsetup luksFormat /dev/<mydisk> # create encrypted container
cryptsetup open /dev/<my_disk> <container_name>
pvcreate /dev/mapper/<container_name>
vgcreate <vol_grp_name> /dev/mapper/<container_name>
lvcreate -L <size> -n <name> <vol_grp_name>
lvcreate -l 100%FREE -n <name> <vol_grp_name>
```

Format the files systems on each lv:
```sh
mkfs.ext4 /dev/<vol_grp_name>/<name>
mkswap /dev/<vol_grp_name>/<swap_name>
```

Mount each file system:
```sh
mount --mkdir /dev/<vol_grp_name>/<name> /mnt</PATH_TO_MOUNT>
swapon /dev/<vol_grp_name>/<swap_name>
```

Boot partition:
```sh
fdisk /dev/<disk_name> # interface to create partition
mkfs.fat -F32 /dev/<boot_partition>
mount --mkdir /dev/<boot_partition> /mnt/boot/
```

Configure mkinitcpio (systemd-based): Add `keyboard` `lvm2` `sd-encrypt` (`sd-vconsole` if
non-US layout) to `/etc/mkinitcpio.conf`

Configure bootloader (grub):
- Add this line to `/etc/default/grub`:
```txt
GRUB_CMDLINE_LINUX="rd.luks.name=<uuid_device>=<vg_name> root=/dev/mapper/<lv_root_name>"
```
- Regenerate the `grub.cfg`:
```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

### Installation of the initial packages

`pacstrap -K /mnt <packages>`
Packages to install (needed):
- NEEDED
    - base
    - linux
    - lvm2
    - linux-firmware
    - amd/intel-ucode
    - vim
    - man-db man-pages texinfo (for documentation)
    - networkmanager wpa_supplicant
    - sudo
    - pipewire
    - zsh
- CUSTOM
    - kitty
    - neovim
    - yazi
    - zathura zathura-pdf-mupdf
    - wl-clipboard
    - hyprland hyprpaper hyprlock hypridle
    - waybar
    - mpv
    - uwsm
    - openvpn
    - fastfetch
    - thunderbird
    - dolphin
    - chromium google-chrome(AUR)
    - dunst (notification applet)
    - paru
- PROGRAMMING
    - python
    - rustup

### Misc

#### Invert Left and Right audio channel
