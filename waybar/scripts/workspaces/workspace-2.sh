#!/bin/bash
# workspace-2.sh — highlight workspace 2 if active

active=$(hyprctl activeworkspace -j | jq '.id')

if [ "$active" -eq 2 ]; then
  echo "[<span foreground='#f43841'>●</span>]"
else
  echo "[β]"
fi
