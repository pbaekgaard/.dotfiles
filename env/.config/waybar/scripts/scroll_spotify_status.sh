#!/bin/bash
delay=0.2
zscroll -l 30 \
        --delay $delay \
        --scroll-padding "    " \
        --match-command "`dirname $0`/get_spotify_status.sh --status" \
        --always-reprint 1\
        --update-check true "`dirname $0`/get_spotify_status.sh"
