#!/usr/bin/env bash
# ─── keyboard-status.sh ──────────────────────────────────────────────────────────
#  Description: Displays keyboard layout and Caps Lock status for Waybar (Hyprland)
#  Usage: Called by Waybar `custom/keyboard` module to show “Caps”, “Intl”, or both
#  Dependencies: hyprctl (Hyprland), jq (JSON parser)
# ─────────────────────────────────────────────────────────────────────────────────

# Set your keyboard name as shown in `hyprctl devices`
KEYBOARD_NAME="usb-hid-keyboard"

# Query keyboard information from Hyprland
INFO=$(hyprctl -j devices | jq -r --arg NAME "$KEYBOARD_NAME" \
  '.keyboards[] | select(.name == $NAME) | {caps: .capsLock, layout: .active_keymap}')

# Extract relevant data
CAPS=$(echo "$INFO" | jq -r '.caps')
LAYOUT=$(echo "$INFO" | jq -r '.layout')

# Initialize display text
TEXT=""

# Check if layout is International (US, intl with dead keys)
if [[ "$LAYOUT" == *"intl"* ]]; then
    TEXT="I"
fi

# Append “Caps” if Caps Lock is active
if [[ "$CAPS" == "true" ]]; then
    if [[ -n "$TEXT" ]]; then
        TEXT="C-$TEXT"
    else
        TEXT="C"
    fi
fi

# Output JSON for Waybar
# When TEXT is empty, Waybar hides the module
if [[ -n "$TEXT" ]]; then
    echo "{\"text\": \"[$TEXT]\", \"tooltip\": \"Layout: $LAYOUT | Caps: $CAPS\"}"
else
    echo "{\"text\": \"\"}"
fi

