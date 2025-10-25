#!/usr/bin/env bash
# ── workspace-4.sh ──────────────────────────────────────────
# Description: Highlight workspace 4 if active
# Usage: Called by Waybar `custom/workspace-4` module every 1s
# Dependencies: hyprctl (Hyprland)
# ────────────────────────────────────────────────────────────

active=$(hyprctl activeworkspace -j | jq '.id')

if [ "$active" -eq 4 ]; then
  echo "[<span foreground='#f43841'>●</span>]"
else
  echo "[δ]"
fi
