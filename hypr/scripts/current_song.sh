if playerctl -p spotify status &> /dev/null; then
    printf " \u202F \u202F $(playerctl -p spotify metadata title) - $(playerctl -p spotify metadata artist)"
else
    echo ""
fi
