#!/usr/bin/env bash

# Script inspired from
# https://github.com/hyprwm/hyprpaper/issues/194#issuecomment-2645933522

# NOTE: This script is not used anymore, as hyprpaper can do ramdom-shuffle by
# itself (not documented as of 2026-09-06 tho).

WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
WALL_LOC="$HOME/.local/state/wallpaper"

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$(readlink -e $WALL_LOC)")" | shuf -n 1)

ln -sf $WALLPAPER $WALL_LOC

ACTUAL_WALLPAPER=$(realpath ~/.local/state/wallpaper)

hyprctl hyprpaper preload "$ACTUAL_WALLPAPER"
hyprctl hyprpaper wallpaper ",$ACTUAL_WALLPAPER"
hyprctl hyprpaper unload all
