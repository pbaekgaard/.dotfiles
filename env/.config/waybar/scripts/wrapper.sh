#!/bin/bash

~/.config/waybar/scripts/scroll_spotify_status.sh | \
while IFS= read -r line; do
    # Calculate the length of the string

    # If length is less than 34, remove trailing whitespace, otherwise keep it
    text="$line"

    # Detect status from icon
    status=$(~/.config/waybar/scripts/get_spotify_status.sh --status)

    # Use printf to output the JSON with preserved or trimmed text
    # if status="Off"
    # printf ""
    # else
if [ "$status" = "Off" ]; then
        printf ''
    else
        printf '{"text": "%s", "class": "%s" }\n' "$text" "$status"
    fi
done
