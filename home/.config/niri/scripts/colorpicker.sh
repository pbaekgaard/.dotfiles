#!/usr/bin/env bash

# Ensure required tools are installed
if ! command -v grim &>/dev/null || ! command -v slurp &>/dev/null; then
    notify-send "Color Picker Error" "grim and slurp are required but not installed." -u critical
    exit 1
fi

# Select a single pixel and grab its color in hex format
COLOR=$(grim -g "$(slurp -p -b 00000000)" -t ppm - | convert - -format "%[pixel:p{0,0}]" txt:- | grep -E -o '#[0-9a-fA-F]{6}')

# Check if a color was successfully picked (user didn't ESC)
if [ -n "$COLOR" ]; then
    # Copy to clipboard (supports both wl-clipboard and cliphist/wl-copy)
    if command -v wl-copy &>/dev/null; then
        echo -n "$COLOR" | wl-copy
    fi

    # Send a desktop notification with a small color preview if supported
    notify-send "Color Picker" "Copied to clipboard: $COLOR" \
        -i color-picker \
        -h string:x-canonical-private-synchronous:colorpicker
else
    notify-send "Color Picker" "Selection canceled" \
        -h string:x-canonical-private-synchronous:colorpicker
fi
