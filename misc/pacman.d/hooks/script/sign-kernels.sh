#!/bin/bash
KEY="/etc/refind.d/keys/refind_local.key"
CRT="/etc/refind.d/keys/refind_local.crt"

for k in /boot/vmlinuz-*; do
    if [[ -f "$k" ]]; then
        sbsign --key "$KEY" --cert "$CRT" --output "$k" "$k"
    fi
done
