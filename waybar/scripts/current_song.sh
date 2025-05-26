PLAYER_STATUS=$(playerctl -s -p cider status | tail -n1)
# Replace &'s in artist name/song title with +'s to avoid parsing issues
ARTIST=$(playerctl -p cider metadata artist | sed 's/&/+/g') 
TITLE=$(playerctl -p cider metadata title | sed 's/&/+/g')

if [[ $PLAYER_STATUS == "Paused" || $PLAYER_STATUS == "Playing" ]]; then
    echo "${ARTIST} - ${TITLE}"
elif [[ $PLAYER_STATUS == "Stopped" ]]; then
    echo "No Music Playing"
else
   echo "Music Player Offline"
fi
