#!/usr/bin/env bash
# ── workspace-1.sh ──────────────────────────────────────────
# Description: Highlight workspace 1 if active
# Usage: Called by Waybar `custom/workspace-1` module every 1s
# Dependencies: hyprctl (Hyprland)
# ────────────────────────────────────────────────────────────

active=$(hyprctl activeworkspace -j | jq '.id')

if [ "$active" -eq 1 ]; then
  echo "[<span foreground='#f43841'>●</span>]"
else
  echo "[α]"
fi
