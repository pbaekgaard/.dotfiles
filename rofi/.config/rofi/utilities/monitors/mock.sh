#!/bin/bash


# Check if GROUPROOM is set to 1
if [ "$GROUPROOM" = "1" ]; then
    profiles="extend\nduplicate"
else
    profiles="forever alone"
fi

# Use rofi to display options
chosen=$(echo -e "$profiles" | rofi -dmenu -p "Choose layout:" -config ./config.rasi)

# Just mock what happens when a layout is selected
if [ -n "$chosen" ]; then
    notify-send "You selected: $chosen"
    echo "You selected: $chosen"
fi
