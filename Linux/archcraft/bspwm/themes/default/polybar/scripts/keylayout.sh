#!/bin/bash
caps=$(xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p')

layout=$(cat ~/.config/bspwm/keylayout)
if [ "$caps" = "off" ]; then
    echo "$layout"
else
  echo "$layout (CAPS)"
fi
