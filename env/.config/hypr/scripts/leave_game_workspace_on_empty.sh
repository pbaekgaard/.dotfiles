#!/bin/bash

# Define the target workspace to check and the fallback workspace
CHECK_WS=10
FALLBACK_WS=2

# Helper function to handle the check
handle_check() {
    # 1. Get the current active workspace ID
    ACTIVE_WS=$(hyprctl activeworkspace -j | jq '.id')

    # Only proceed if we are currently looking at the workspace in question
    if [ "$ACTIVE_WS" -eq "$CHECK_WS" ]; then
        
        # 2. Count how many clients (windows) exist on this workspace
        WINDOW_COUNT=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == $CHECK_WS)] | length")

        # 3. If no windows remain, switch to the fallback workspace
        if [ "$WINDOW_COUNT" -eq 0 ]; then
            hyprctl dispatch workspace $FALLBACK_WS
        fi
    fi
}

# Listen to the Hyprland socket for events
# We look specifically for 'closewindow' and 'movewindow' events
socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    case "$line" in
        closewindow*|movewindow*)
            handle_check
            ;;
    esac
done
