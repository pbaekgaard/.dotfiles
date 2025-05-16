#!/bin/sh

current_window="N/A"

close_blueman() {
  echo "closeman"
  thing="$1"
  case "$thing" in
    activewindowv2* ) return ;;
  esac

  if echo "$thing" | grep -q "blueman-manager"; then
    current_window="blueman"
  else
    if [ "$current_window" = "blueman" ]; then
      echo "Closing blueman-manager"
      hyprctl dispatch closewindow class:blueman-manager
      current_window="$thing"
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
  echo $line
  handle "$line"
done
