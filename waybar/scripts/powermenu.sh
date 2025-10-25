#!/usr/bin/env bash
# ─── powermenu.sh ────────────────────────────────────────────────────────
#  Description : Provides a simple system power menu integrated with Waybar
# Usage: Called by Waybar `custom/powermenu` module when clicking on it
# Dependencies: wofi, hyprctl (Hyprland), hyprlock (Hyprlock)
# ─────────────────────────────────────────────────────────────────────────

wofi_command="wofi --dmenu --prompt 'Power'"

options="Shutdown\nReboot\nLogout\nSuspend\nLock"

chosen="$(echo -e "$options" | $wofi_command)"

# Execute corresponding action
case $chosen in
    Shutdown) systemctl poweroff ;;
    Reboot) systemctl reboot ;;
    Logout) hyprctl dispatch exit ;;
    Suspend) systemctl suspend ;;
    Lock) hyprlock ;;
esac
