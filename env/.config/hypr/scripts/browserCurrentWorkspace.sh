#!/bin/sh

hyprctl keyword windowrule "workspace unset, class:^(zen)$"
zen-browser
sleep 1
hyprctl keyword windowrule "workspace 2, class:^(zen)$"
