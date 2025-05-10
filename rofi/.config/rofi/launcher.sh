#!/bin/sh

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10

dir="$HOME/.config/rofi/launchers/"
type="transparent"
style="config"

if [ "$type" = "transparent" ]; then
    rofi -kb-cancel "Escape,Alt+F12" \
         -show drun \
         -config "${dir}/${type}/${style}.rasi"
else
    rofi -kb-cancel "Escape,Alt+F12" \
         -show drun \
         -config "${dir}/${type}/${style}.rasi" \
         -theme "${dir}/${type}/${style}.rasi"
fi
