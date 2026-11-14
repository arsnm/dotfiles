# Misc setup files/directories

To hold certain useful config/setup files, that are not meant to be directly
symlinked in `$XDG_CONFIG_DIR`.

## Secure boot with SHIM + systemd-boot

1. Build the UKI.
2. Sign it with a initcpio/post hook:

``` sh
#!/usr/bin/env bash
uki="$3"
[[ -n "$uki" ]] || exit 0
key=/etc/secureboot/signing.key
cert=/etc/secureboot/signing.crt
if ! sbverify --cert "$cert" "$uki" &>/dev/null; then
    sbsign --key "$key" --cert "$cert" --output "$uki" "$uki"
fi
```

``` sh
sudo chmod +x /etc/initcpio/post/uki-sbsign
```

3. Re-sign systemd-boot and refresh the copy shim loads:

``` sh
#!/bin/sh
set -e
K=/etc/secureboot/signing
SRC=/usr/lib/systemd/boot/efi/systemd-bootx64.efi
ESP=/boot/efi
sbsign --key "$K.key" --cert "$K.crt" --output "$SRC.signed" "$SRC"
bootctl --esp-path="$ESP" update --graceful --no-variables
cp "$ESP/EFI/systemd/systemd-bootx64.efi" "$ESP/EFI/systemd/grubx64.efi"
```

with a Pacman hook:

``` apacheconf
[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = systemd

[Action]
Description = Signing systemd-boot and refreshing shim's grubx64.efi ...
When = PostTransaction
Depends = sbsigntools
Exec = /usr/local/bin/systemd-boot-shim-update
```


