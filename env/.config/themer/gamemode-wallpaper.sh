#!/bin/bash

HYPRLAND_SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# File to hold DP-3's previous wallpaper
PREV_WALL="/tmp/dp3_prev_wall.png"
BLACK_WALL="/tmp/black.png"

# Ensure a 1x1 black PNG exists
if [ ! -f "$BLACK_WALL" ]; then
    convert -size 1x1 xc:black "$BLACK_WALL"
fi

socat -u UNIX-CONNECT:"$HYPRLAND_SOCKET" - | while read -r line; do
    case "$line" in
        workspace*">>"*)
            ws=$(echo "$line" | cut -d'>' -f3 | cut -d',' -f1)
            echo "Switched to workspace $ws"
if [[ "$line" == *","* ]]; then
                continue
            fi

            if [ "$ws" = "10" ]; then
                # Save DP-3's current wallpaper (column 8)
                swww query | grep "DP-3" | awk '{print $8}' > "$PREV_WALL"

                # Set DP-3 to black, keep HDMI-A-1 as is
                swww img --outputs DP-3 "$BLACK_WALL" --transition-type fade --transition-duration 0.2 --transition-fps 100

                echo "Workspace 10: DP-3 wallpaper set to black"
            else
                # Restore DP-3 wallpaper if we have one
                if [ -f "$PREV_WALL" ]; then
                    WALL=$(cat "$PREV_WALL")
                    swww img --outputs DP-3 "$WALL" --transition-type fade --transition-duration 0.2 --transition-fps 100
                    echo "Workspace $ws: DP-3 wallpaper restored"
                fi
            fi
        ;;
    esac
done
