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
spotify_theme=$(awk -F= -v theme="$theme" '/^\['"$theme"'\]/{a=1} a==1&&$1~/spotify/{print $2; exit}' "$CONFIG_FILE")
IFS=',' read -r spotify_theme spotify_style <<< "$spotify_theme"

primary_color=$(awk -F= -v theme="$theme" '/^\['"$theme"'\]/{a=1} a==1&&$1~/primary_color/{print $2; exit}' "$CONFIG_FILE")

gtk_theme=$(awk -F= -v theme="$theme" '/^\['"$theme"'\]/{a=1} a==1&&$1~/gtk/{print $2; exit}' "$CONFIG_FILE")
tmux_theme=$(awk -F= -v theme="$theme" '
  $0 == "[" theme "]" { in_theme = 1; next }
  /^\[.*\]/ { in_theme = 0 }
  in_theme && $1 == "tmux" {
    gsub(/^[ \t]+|[ \t]+$/, "", $2);
    print $2;
    exit
  }
' "$CONFIG_FILE")

swaync_theme=$(awk -F= -v theme="$theme" '/^\['"$theme"'\]/{a=1} a==1&&$1~/swaync/{print $2; exit}' "$CONFIG_FILE")

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
# Extract base theme name before first dash (e.g., "catppuccin" from "catppuccin-macchiato")
theme_base=$(echo "$theme" | cut -d'-' -f1)

echo "Using wallpaper: $wallpaper"
swww img "$wallpaper" --transition-type=outer --transition-duration=2 --transition-pos=top-right &

# Change Neovim theme
sed -i "s/vim.cmd.colorscheme .*/vim.cmd.colorscheme \"$nvim_theme\"/g" ~/.config/nvim/init.lua
for server in /tmp/themelistener*; do
    if [ -e "$server" ]; then
        nvim --server "$server" --remote-send ":colorscheme $nvim_theme<CR>"
    fi
done &

# Update the tmux.conf to use the selected theme
sed -i "s|^source-file \$HOME/.config/tmux/themes/.*|source-file \$HOME/.config/tmux/themes/$tmux_theme.conf|" "$HOME/.config/tmux/tmux.conf"
if tmux has-session 2>/dev/null; then
  tmux source-file "$HOME/.config/tmux/tmux.conf"
fi &

# Change rofi theme
sed -i "s/^[[:space:]]*selected-bg: .*/  selected-bg: $primary_color;/" ~/.config/rofi/config.rasi
# Change Ghostty theme
sed -i "s/^theme = .*/theme = $ghostty_theme/g" ~/.config/ghostty/config &

# Change Waybar theme
ln -s "$HOME/.config/waybar/themes/$waybar_theme.css" $HOME/.config/waybar/style.css -f &

# Change sway notification center theme
ln -s "$HOME/.config/swaync/themes/$swaync_theme.css" $HOME/.config/swaync/style.css -f &
swaync-client -rs &

# Change spotify
spicetify config current_theme $spotify_theme & spicetify config color_scheme $spotify_style; spicetify apply &

# Set GTK Theme
# gsettings
gsettings set org.gnome.desktop.interface gtk-theme $gtk_theme &
gsettings set org.gnome.desktop.wm.preferences theme $gtk_theme &

# gtk 2.0
sed -i -E 's/(gtk-theme-name=")(.*)(")/\1'$gtk_theme'\3/g' ~/.gtkrc-2.0 &

# gtk 3.0
rm -r ~/.config/gtk-3.0/* 
cp -r $HOME/.themes/$gtk_theme/gtk-3.0/* ~/.config/gtk-3.0/ || cp -r ~/.themes/$gtk_theme/gtk-3.0/* ~/.config/gtk-3.0/ || cp -r ~/.config/themes/gtk/$gtk_theme/gtk-3.0/* ~/.config/gtk-3.0/ &
sed -i -E 's/(gtk-theme-name=)(.*)/\1'$gtk_theme'/g' ~/.config/gtk-3.0/settings.ini &

# gtk 4.0
rm -r ~/.config/gtk-4.0/*
cp -r $HOME/.themes/$gtk_theme/gtk-4.0/* ~/.config/gtk-4.0/ || cp -r ~/.themes/$gtk_theme/gtk-4.0/* ~/.config/gtk-4.0/ || cp -r ~/.config/themes/gtk/$gtk_theme/gtk-4.0/* ~/.config/gtk-4.0/ &

export GTK_THEME="$gtk_theme"
hyprctl keyword env GTK_THEME,$gtk_theme &

# Reload Waybar to apply the changes
pkill waybar; hyprctl reload & hyprctl dispatch exec waybar &

# Wait for all background processes to complete before finishing the script
wait
