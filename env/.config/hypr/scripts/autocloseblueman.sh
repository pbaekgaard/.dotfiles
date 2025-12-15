#!/bin/sh

# === Configuration ===
CLOSE_DELAY_MS=200  # Delay in milliseconds before closing blueman-manager

# === Internals ===
current_window="N/A"
blueman_unfocus_timer_pid=""
CLOSE_DELAY_SEC=$(awk "BEGIN { printf \"%.3f\", $CLOSE_DELAY_MS / 1000 }")

# === Functions ===

close_blueman() {
  event="$1"
  case "$event" in
    activewindowv2* ) return ;;
  esac

  if echo "$event" | grep -q "blueman-manager"; then
    # Focus is on blueman — cancel any pending close
    current_window="blueman"
    if [ -n "$blueman_unfocus_timer_pid" ]; then
      kill "$blueman_unfocus_timer_pid" 2>/dev/null
      blueman_unfocus_timer_pid=""
    fi
  else
    if [ "$current_window" = "blueman" ]; then
      # Focus just left blueman — start delayed close
      current_window="$event"
      (
        sleep "$CLOSE_DELAY_SEC"
        focused="$(hyprctl activewindow -j | jq -r '.class')"
        if [ "$focused" != "blueman-manager" ]; then
          echo "Closing blueman-manager"
          hyprctl dispatch closewindow class:blueman-manager
        else
          echo "Focus returned to blueman-manager, not closing."
        fi
      ) &
      blueman_unfocus_timer_pid=$!
    fi
  fi
}

handle() {
  case "$1" in
    monitoradded*) do_something ;;
    focusedmon*) do_something_else ;;
    activewindow*) close_blueman "$1" ;;
  esac
}

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | \
while read -r line; do
  echo "$line"
  handle "$line"
done
