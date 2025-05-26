#!/bin/sh

rofi_theme='
element-text, element-icon {
    text-color: inherit;
}
mainbox {
children: [listview];
}
inputbar {
    enabled: false;
}
'

MONITORAMOUNT=$(hyprctl monitors all | grep '^Monitor ' | wc -l | tr -d '\n')

if [ "$MONITORAMOUNT" -le 1 ]; then
    exit 1
fi

# Extract all monitor descriptions
DESCRIPTIONS=$(hyprctl monitors all | grep 'description:' | sed 's/.*description:[[:space:]]*//')

# Check if Vestel monitor is connected
VESTEL_DESC="Vestel Elektronik Sanayi ve Ticaret A. S. 49UHD_LCD_TV"

echo "$DESCRIPTIONS" | grep -Fxq "$VESTEL_DESC"
if [ $? -ne 0 ]; then
    echo "Vestel monitor not connected."
    exit 1
fi

# Read profiles from kanshi config file
KANSHI_CONFIG="$HOME/.config/kanshi/config"
if [ ! -f "$KANSHI_CONFIG" ]; then
    echo "Kanshi config file not found at $KANSHI_CONFIG"
    exit 1
fi

# Extract profile names starting with 'grouproom_'
PROFILES=$(grep '^profile grouproom_' "$KANSHI_CONFIG" | sed 's/profile \(grouproom_[^ ]*\).*/\1/')

if [ -z "$PROFILES" ]; then
    echo "No grouproom profiles found in $KANSHI_CONFIG"
    exit 1
fi

ROFI_OPTIONS=$(echo "$PROFILES" | while read -r PROFILE; do
    DESC=$(echo "$PROFILE" | sed -E 's/^grouproom_//' | tr '_' ' ')
    echo "$DESC|$PROFILE"
done)

SELECTED=$(echo "$ROFI_OPTIONS" | cut -d'|' -f1 | rofi -dmenu -p "Choose display profile" -theme-str "$rofi_theme")

[ -z "$SELECTED" ] && exit 0

CHOSEN_PROFILE=$(echo "$ROFI_OPTIONS" | grep "^$SELECTED|" | cut -d'|' -f2)
echo "Switching to profile: $CHOSEN_PROFILE"

kanshictl switch "$CHOSEN_PROFILE"
