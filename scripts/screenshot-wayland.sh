#!/usr/bin/env bash
# Wayland screenshot script (grim+slurp)
mkdir -p ~/Pictures/Screenshots
FILENAME=~/Pictures/Screenshots/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png
grim -g "$(slurp)" "$FILENAME"
wl-copy -t image/png < "$FILENAME"
notify-send "Screenshot taken" "Saved to $FILENAME and copied to clipboard" -i "$FILENAME"
