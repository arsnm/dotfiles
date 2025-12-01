#!/usr/bin/env bash
# ── workspace-2.sh ──────────────────────────────────────────
# Description: Highlight workspace 2 if active
# Usage: Called by Waybar `custom/workspace-2` module every 1s
# Dependencies: hyprctl (Hyprland)
# ────────────────────────────────────────────────────────────

active=$(hyprctl activeworkspace -j | jq '.id')

if [ "$active" -eq 2 ]; then
  echo "[<span foreground='#f43841'>●</span>]"
else
  echo "[β]"
fi
