#!/bin/bash
# ── mic.sh ─────────────────────────────────────────────────
# Description: Shows microphone mute/unmute status with icon
# Usage: Called by Waybar `custom/microphone` module every 1s
# Dependencies: wpctl (WirePlumber / PipeWire)
# ───────────────────────────────────────────────────────────

# Get the default source ID
SOURCE=$(wpctl status | awk '/Sources:/ {flag=1; next} /Sinks:/ {flag=0} flag && /\*/ {print $2; exit}')

if [ -z "$SOURCE" ]; then
  # No mic detected
  echo "<span foreground='#f43841'>[󱦉]</span>"
  exit 0
fi

# Query mute state
if wpctl get-volume "$SOURCE" | grep -q MUTED; then
  # Muted → mic-off icon
  echo "<span foreground='#f43841'>[]</span>"
else
  # Active → mic-on icon
  echo "<span foreground='#56b6c2'>[]</span>"
fi

