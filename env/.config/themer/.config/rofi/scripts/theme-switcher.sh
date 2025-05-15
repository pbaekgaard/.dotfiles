#!/bin/sh

# Path to your theme configuration file
CONFIG_FILE="$HOME/.config/themer/themes.conf"

# Read the current theme from the [settings] section
current_theme=$(awk -F= '/^\[settings\]/{a=1} a==1&&$1~/current/{print $2; exit}' "$CONFIG_FILE")

# Read the theme list from the config file, excluding [settings]
themes=$(awk -F= '/^\[.*\]/ {gsub(/[[:space:]]/, "", $1); if ($1 != "[settings]") print substr($1,2,length($1)-2)}' "$CONFIG_FILE")

primary_color=$(awk -v theme="$current_theme" '
  $0 == "[" theme "]" { in_theme = 1; next }
  /^\[.*\]/ { in_theme = 0 }
  in_theme && /^primary_color=/ {
    split($0, a, "=")
    print a[2]
    exit
  }
' "$CONFIG_FILE")

# Mark the current theme in the list with green color using Pango markup
formatted_themes=$(echo "$themes" | while read -r theme; do
  if [ "$theme" = "$current_theme" ]; then
    echo "<span foreground='$primary_color'>$theme</span>"
  else
    echo "$theme"
  fi
done)

# Use rofi to select a theme, enabling markup
theme=$(echo "$formatted_themes" | rofi -dmenu -p "Select Theme" -markup-rows | sed 's/<span foreground.*>\(.*\)<\/span>/\1/')

if [ -z "$theme" ]; then
  exit 1
fi

if [ "$theme" = "$current_theme" ]; then
    exit 1
fi

# Update the current theme in the [settings] section
sed -i "s/^current=.*/current=$theme/g" "$CONFIG_FILE"

# Read values for the selected theme from the config
nvim_theme=$(awk -F= -v theme="$theme" '/^\['"$theme"'\]/{a=1} a==1&&$1~/nvim/{print $2; exit}' "$CONFIG_FILE")
ghostty_theme=$(awk -F= -v theme="$theme" '/^\['"$theme"'\]/{a=1} a==1&&$1~/ghostty/{print $2; exit}' "$CONFIG_FILE")
waybar_theme=$(awk -F= -v theme="$theme" '/^\['"$theme"'\]/{a=1} a==1&&$1~/waybar/{print $2; exit}' "$CONFIG_FILE")


hyprland_color=$(awk -v theme="$theme" '
  $0 == "[" theme "]" { in_theme = 1; next }
  /^\[.*\]/ { in_theme = 0 }
  in_theme && /^primary_color=/ {
    split($0, a, "=")
    print a[2]
    exit
  }
' "$CONFIG_FILE")
hyprland_color="${hyprland_color#\#}aa"
# Change hyprland active color
sed -i "s/col.active_border .*/col.active_border = rgba\($hyprland_color\)/g" ~/.config/hypr/hyprland.conf
# Extract base theme name before first dash (e.g., "catppuccin" from "catppuccin-macchiato")
theme_base=$(echo "$theme" | cut -d'-' -f1)

# Try to get wallpaper from config
wallpaper=$(awk -F= -v theme="$theme" '
  $0 == "[" theme "]" { in_theme = 1; next }
  /^\[.*\]/ { in_theme = 0 }
  in_theme && $1 == "wallpaper" {
    gsub(/^[ \t]+|[ \t]+$/, "", $2);
    print $2;
    exit
  }
' "$CONFIG_FILE")

# Expand ~ if present
wallpaper=$(echo "$wallpaper" | sed "s|~|$HOME|")

# If wallpaper is missing, empty, or invalid, fall back to a random one from the base theme's folder
if [ -z "$wallpaper" ] || [ ! -f "$wallpaper" ]; then
    echo "Wallpaper not specified or invalid for theme '$theme'. Falling back to random image from '$theme_base'."
    wallpaper_dir="$HOME/wallpapers/$theme_base"
    if [ ! -d "$wallpaper_dir" ]; then
        echo "Error: Wallpaper folder '$wallpaper_dir' does not exist."
        exit 1
    fi

    wallpaper=$(find "$wallpaper_dir" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | shuf -n 1)
    if [ -z "$wallpaper" ]; then
        echo "Error: No image files found in '$wallpaper_dir'."
        exit 1
    fi
fi

echo "Using wallpaper: $wallpaper"
swww img "$wallpaper" --transition-type=outer --transition-duration=2 --transition-pos=top-right

# Change Neovim theme
sed -i "s/vim.cmd.colorscheme .*/vim.cmd.colorscheme \"$nvim_theme\"/g" ~/.config/nvim/init.lua
for server in /tmp/themelistener*; do
    if [ -e "$server" ]; then
        nvim --server "$server" --remote-send ":colorscheme $nvim_theme<CR>"
    fi
done

# Change Ghostty theme
sed -i "s/^theme = .*/theme = $ghostty_theme/g" ~/.config/ghostty/config

# Change Waybar theme
cp "$HOME/.config/waybar/themes/$waybar_theme.css" ~/.config/waybar/style.css

# Reload Waybar to apply the changes
pkill waybar; hyprctl dispatch exec waybar
