#!/bin/bash

while true; do
    ~/.config/waybar/scripts/scrolling-mpris ~/.config/waybar/config.jsonc | \
    while IFS= read -r line; do
        length=$(echo -n "$line" | wc -m)
        echo "length: $length"

        if [ "$length" -lt 25 ]; then
            text=$(echo -n "$line" | sed 's/[[:space:]]*$//')
        else
            text="$line"
        fi

        if [[ "$text" == " "* ]]; then
            status="Playing"
        elif [[ "$text" == " "* ]]; then
            status="Paused"
        elif [[ "$text" == "■"* ]]; then
            status="Stopped"
        else
            status="Unknown"
        fi

        printf '{ "text": "%s", "class": "%s" }\n' "$text" "$status"
    done

    sleep 1  # wait before retrying in case of crash or no Spotify
done
