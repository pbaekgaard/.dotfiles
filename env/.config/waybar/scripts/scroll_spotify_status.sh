#!/bin/bash
delay=0.2
zscroll -l 30 \
        --delay $delay \
        --scroll-padding "    " \
        --match-command "`dirname $0`/get_spotify_status.sh --status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --always-reprint 1\
        --update-check true "`dirname $0`/get_spotify_status.sh"
