#!/bin/bash
set -e  # Exit on error

echo "Installing GIMP..."
paru -S --needed --noconfirm gimp

echo "Downloading PhotoGIMP..."
PHOTO_GIMP_ZIP="/tmp/PhotoGIMP-linux.zip"
curl -L -o "$PHOTO_GIMP_ZIP" https://github.com/Diolinux/PhotoGIMP/releases/latest/download/PhotoGIMP-linux.zip

echo "Extracting PhotoGIMP..."
sudo pacman -S unzip
unzip -o "$PHOTO_GIMP_ZIP" -d /tmp/

echo "Installing PhotoGIMP..."
cp -r /tmp/PhotoGIMP-linux/.local $HOME
cp -r /tmp/PhotoGIMP-linux/.config $HOME

echo "Cleaning up..."
rm -rf /tmp/PhotoGIMP-linux/ "$PHOTO_GIMP_ZIP"

echo "PhotoGIMP installed successfully!"


# PDF Reader (Zathura)
paru -S --needed --noconfirm zathura zathura-pdf-poppler


# wallpaper
paru -S --needed --noconfirm swww

# multimonitor stuff
paru -S --needed --noconfirm kanshi

# rofi
paru -S --needed --noconfirm rofi

# nautilus
paru -S --needed --noconfirm nautilus
xdg-mime default org.gnome.Nautilus.desktop inode/directory


# other
paru -S --needed --noconfirm socat

paru -S --needed --noconfirm thunar rsync discord spotify spicetify-cli spicetify-marketplace-bin

paru -S --needed --noconfirm swaync zscroll
