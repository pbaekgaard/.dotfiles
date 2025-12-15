#!/bin/bash

HOUR=$(date +%H)
USER_NAME=$USER

if [ "$HOUR" -ge 5 ] && [ "$HOUR" -lt 12 ]; then
    GREETING="Good Morning, $USER_NAME"
elif [ "$HOUR" -ge 12 ] && [ "$HOUR" -lt 17 ]; then
    GREETING="Good Afternoon, $USER_NAME"
elif [ "$HOUR" -ge 17 ] && [ "$HOUR" -lt 21 ]; then
    GREETING="Good Evening, $USER_NAME"
else
    GREETING="Goodnight, You Nightowl!"
fi

echo "$GREETING"
