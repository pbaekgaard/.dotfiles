#!/bin/bash

HYPRLAND_SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

# Paths
CONFIG_FILE="$HOME/.config/themer/themes.conf"   # adjust if needed
GAMEOVER_WALL="$HOME/.dotfiles/wallpapers/gameover.png"

# --- function to get current theme ---
get_current_theme() {
    awk -F= '/^current=/ {print $2}' "$CONFIG_FILE"
}

# --- function to get DP-3 wallpaper path for current theme ---
get_dp3_wall() {
    local theme
    theme=$(get_current_theme)

    awk -v theme="[$theme]" '
        $0 == theme { in_theme=1; next }
        /^\[/ { in_theme=0 }

        # Single-path wallpaper (no block)
        in_theme && /^wallpaper=/ && $0 !~ /\{/ {
            sub(/^wallpaper=/, "", $0)
            print $0
            exit
        }

        # Start of block wallpaper format
        in_theme && /^wallpaper=\{/ { in_wall=1; next }

        # End of block
        in_wall && /\}/ { in_wall=0 }

        # Inside block: extract DP-3
        in_wall && /DP-3=/ {
            gsub(/,/, "", $0)
            sub(/^.*DP-3=/, "", $0)
            print $0
            exit
        }
    ' "$CONFIG_FILE"
}

get_hdmi_wall() {
    local theme
    theme=$(get_current_theme)

    awk -v theme="[$theme]" '
        $0 == theme { in_theme=1; next }
        /^\[/ { in_theme=0 }

        # Single-path wallpaper (no block)
        in_theme && /^wallpaper=/ && $0 !~ /\{/ {
            sub(/^wallpaper=/, "", $0)
            print $0
            exit
        }

        # Start of block wallpaper format
        in_theme && /^wallpaper=\{/ { in_wall=1; next }

        # End of block
        in_wall && /\}/ { in_wall=0 }

        # Inside block: extract HDMI-A-1
        in_wall && /HDMI-A-1=/ {
            gsub(/,/, "", $0)
            sub(/^.*HDMI-A-1=/, "", $0)
            print $0
            exit
        }
    ' "$CONFIG_FILE"
}

# --- startup: set theme wallpaper ---
DP3_WALL=$(get_dp3_wall)
DP3_WALL="${DP3_WALL/#\~/$HOME}"
HDMI_WALL=$(get_hdmi_wall)
echo $HDMI_WALL
HDMI_WALL="${HDMI_WALL/#\~/$HOME}"
echo $HDMI_WALL
if [ -n "$DP3_WALL" ]; then
    swww img --outputs DP-3 "$DP3_WALL" --transition-type fade --transition-duration 0.2 --transition-fps 100
    echo "Startup: DP-3 wallpaper set to $DP3_WALL"
fi

if [ -n "$HDMI_WALL" ]; then
    swww img --outputs HDMI-A-1 "$HDMI_WALL" --transition-type fade --transition-duration 0.2 --transition-fps 100
    echo "Startup: HDMI-A-1 wallpaper set to $HDMI_WALL"
fi

# --- event listener ---
socat -u UNIX-CONNECT:"$HYPRLAND_SOCKET" - | while read -r line; do
    case "$line" in
        workspace*">>"*)
            ws=$(echo "$line" | cut -d'>' -f3 | cut -d',' -f1)
            echo "Switched to workspace $ws"

            # Ignore multi-switch messages
            [[ "$line" == *","* ]] && continue

            if [ "$ws" = "10" ]; then
                # Set Game Over wallpaper
                swww img --outputs DP-3 "$GAMEOVER_WALL" --transition-type fade --transition-duration 0.2 --transition-fps 100
                killall -9 waybar zscroll 2>/dev/null
                echo "Workspace 10: DP-3 wallpaper set to Game Over"
            else
                # Restore from theme
                DP3_WALL=$(get_dp3_wall)
                DP3_WALL="${DP3_WALL/#\~/$HOME}"
                if [ -n "$DP3_WALL" ]; then
                    swww img --outputs DP-3 "$DP3_WALL" --transition-type fade --transition-duration 0.2 --transition-fps 100
                    if ! pidof waybar > /dev/null; then
                        hyprctl dispatch exec waybar &
                    fi
                    echo "Workspace $ws: DP-3 wallpaper restored to $DP3_WALL"
                fi
            fi
        ;;
    esac
done
