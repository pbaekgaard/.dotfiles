#! /bin/bash

keylayout=$(cat /home/pbk/.config/bspwm/keylayout)

if [ "$keylayout" = "US" ]; then
  setxkbmap dk
  echo "DK" > /home/pbk/.config/bspwm/keylayout
else
  setxkbmap us
  echo "US" > /home/pbk/.config/bspwm/keylayout
fi
