#!/bin/bash

CONFIG_FILE="$HOME/.config/hypr/hyprland.conf"

# Get current opacity from Hyprland runtime
current_opacity=$(hyprctl getoption decoration:active_opacity | awk '/float:/ { print $2 }')

# Get config values from the config file
config_opacity_active=$(grep -E '^\s*active_opacity\s*=' "$CONFIG_FILE" | awk -F '=' '{ gsub(/ /, "", $2); print $2 }')
config_opacity_inactive=$(grep -E '^\s*inactive_opacity\s*=' "$CONFIG_FILE" | awk -F '=' '{ gsub(/ /, "", $2); print $2 }')

# Default if not found
config_opacity_active=${config_opacity_active:-0.9}
config_opacity_inactive=${config_opacity_inactive:-0.8}

# Toggle logic
if [[ "$current_opacity" != "1.000000" && "$current_opacity" != "1.0" ]]; then
    hyprctl keyword decoration:active_opacity 1
    hyprctl keyword decoration:inactive_opacity 1
else
    echo "Setting active opacity to $config_opacity_active"
    hyprctl keyword decoration:active_opacity "$config_opacity_active"
    echo "Setting inactive opacity to $config_opacity_inactive"
    hyprctl keyword decoration:inactive_opacity "$config_opacity_inactive"
fi
