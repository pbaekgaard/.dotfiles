#!/usr/bin/env bash
# Pick color and strip # + newlines
color=$(hyprpicker -a | tr -d "#\n\r")

# Send notification with rgb(HEX) as background and hex as text
notify-send "Colorpicker" "Copied #$color"
