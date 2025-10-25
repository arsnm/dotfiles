#!/usr/bin/env bash
# ── workspace-3.sh ──────────────────────────────────────────
# Description: Highlight workspace 3 if active
# Usage: Called by Waybar `custom/workspace-3` module every 1s
# Dependencies: hyprctl (Hyprland)
# ────────────────────────────────────────────────────────────

active=$(hyprctl activeworkspace -j | jq '.id')

if [ "$active" -eq 3 ]; then
  echo "[<span foreground='#f43841'>●</span>]"
else
  echo "[γ]"
fi
