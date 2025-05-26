#!/bin/sh

get_layout() {
  hyprctl devices -j |
    jq -r '.keyboards[] | .active_keymap' |
    head -n1 |
    cut -c1-2 |
    tr 'a-z' 'A-Z'
}

show_help() {
  echo "Usage: $0 [OPTION]"
  echo "Options:"
  echo "  --toggle    Toggle between 'EN' and 'DK' layouts"
  echo "  --get       Get the current keyboard layout (returns 'US' for EN, 'DK' for DK)"
  echo "  --help      Show this help message"
}

if [ "$1" = "--toggle" ]; then
  CURRENT_LAYOUT=$(get_layout)

  if [ "$CURRENT_LAYOUT" = "EN" ]; then
    hyprctl keyword input:kb_layout dk
    echo "DK"
  else
    hyprctl keyword input:kb_layout us
    echo "US"
  fi
  exit 0
fi

if [ "$1" = "--get" ]; then
  LAYOUT=$(get_layout)
  if [ "$LAYOUT" = "EN" ]; then
    echo "US"
  else
    echo "DK"
  fi
  exit 0
fi

if [ "$1" = "--help" ] || [ -z "$1" ]; then
  show_help
  exit 0
fi

echo "Invalid option: $1"
show_help
exit 1
