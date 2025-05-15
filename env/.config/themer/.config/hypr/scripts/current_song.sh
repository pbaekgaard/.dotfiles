if playerctl -p spotify status &> /dev/null; then
    echo "  $(playerctl -p spotify metadata title) - $(playerctl -p spotify metadata artist)"
else
    echo ""
fi
