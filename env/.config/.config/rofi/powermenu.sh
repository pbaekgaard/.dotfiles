#!/bin/bash

# Options
options=" Lock\n󰗽 Logout\n󰜉 Reboot\n Shutdown"

# Rofi theme override to hide the input box
rofi_theme='
element-text, element-icon {
    text-color: inherit;
}
mainbox {
children: [listview];
}
inputbar {
    enabled: false;
}
'

# Show menu
chosen=$(echo -e "$options" | rofi \
    -dmenu \
    -p "Power Menu" \
    -theme-str "$rofi_theme")

case "$chosen" in
    " Lock")
        hyprlock
        ;;
    "󰗽 Logout")
        hyprctl dispatch exit
        ;;
    "󰜉 Reboot")
        systemctl reboot
        ;;
    " Shutdown")
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac
