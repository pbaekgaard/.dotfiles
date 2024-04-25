#!/bin/sh
if bspc query -N -d focused -n newest.!automatic >/dev/null; then
    echo node=newest.!automatic
fi
