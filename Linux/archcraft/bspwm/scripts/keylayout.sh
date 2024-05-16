#! /bin/bash

keylayout=$(cat ~/.config/bspwm/keylayout)

if [ "$keylayout" = "US" ]; then
  setxkbmap dk
  echo "DK" > ~/.config/bspwm/keylayout
else
  setxkbmap us
  echo "US" > ~/.config/bspwm/keylayout
fi
