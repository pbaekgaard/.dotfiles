#!/bin/bash

printf ""
~/.config/waybar/scripts/scrolling-mpris ~/.config/waybar/config.jsonc | \
while IFS= read -r line; do
    # Calculate the length of the string
    length=$(echo -n "$line" | wc -m)
    echo "length: $length"

    # If length is less than 34, remove trailing whitespace, otherwise keep it
    if [ "$length" -lt 25 ]; then
        text=$(echo -n "$line" | sed 's/[[:space:]]*$//')
    else
        text="$line"
    fi

    # Detect status from icon
    if [[ "$text" == " "* ]]; then
        status="Playing"
    elif [[ "$text" == " "* ]]; then
        status="Paused"
    elif [[ "$text" == "■"* ]]; then
        status="Stopped"
    else
        status="Unknown"
    fi

    # Use printf to output the JSON with preserved or trimmed text
    printf '{ "text": "%s", "class": "%s" }\n' "$text" "$status"
done
