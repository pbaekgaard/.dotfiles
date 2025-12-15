#!/bin/bash

HYPRLAND_SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# Wallpapers
DP3_WALL="$HOME/Pictures/wallpapers/private/DSCF7116.jpg"
HDMI_WALL="$HOME/Pictures/wallpapers/private/IMG20240825121628.jpg"
GAMEOVER_WALL="$HOME/Pictures/wallpapers/gameover.png"

# Start state: assume we begin on a normal workspace
CURRENT_MODE="normal"   # or "game"

# Kill swaybg for output
kill_swaybg() {
    pkill -f "swaybg -o $1" 2>/dev/null
}

socat -u UNIX-CONNECT:"$HYPRLAND_SOCKET" - | while read -r line; do
    case "$line" in
        workspace*">>"*)
            ws=$(echo "$line" | cut -d'>' -f3 | cut -d',' -f1)

            # Skip multi-events
            [[ "$line" == *","* ]] && continue

            # -----------------------------------------------------
            # ENTER WORKSPACE 10
            # -----------------------------------------------------
            if [ "$ws" = "10" ] && [ "$CURRENT_MODE" != "game" ]; then
                CURRENT_MODE="game"
                kill_swaybg "DP-3"
                swaybg -o DP-3 -i "$GAMEOVER_WALL" -m fill &
                killall -9 waybar
                echo "Entered 10 → switched to GAMEMODE wallpaper"
                continue
            fi

            # -----------------------------------------------------
            # LEAVE WORKSPACE 10
            # -----------------------------------------------------
            if [ "$ws" != "10" ] && [ "$CURRENT_MODE" != "normal" ]; then
                CURRENT_MODE="normal"
                kill_swaybg "DP-3"
                swaybg -o DP-3 -i "$DP3_WALL" -m fill &
                echo "Left 10 → restored normal wallpaper"

                if ! pgrep waybar >/dev/null; then
                    hyprctl dispatch exec waybar &
                fi

                continue
            fi

            # If same mode, do nothing → NO FLASHING
            ;;
    esac
done
