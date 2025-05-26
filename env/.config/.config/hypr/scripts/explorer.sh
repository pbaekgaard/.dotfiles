#!/bin/bash
THEME=catppuccin-mocha
gsettings set org.gnome.desktop.interface gtk-theme "$THEME"
GTK_THEME=$THEME nautilus
