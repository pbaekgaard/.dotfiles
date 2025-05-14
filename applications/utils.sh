#!/bin/bash
set -e  # Exit on error

echo "Installing GIMP..."
paru -S --needed --noconfirm gimp

echo "Downloading PhotoGIMP..."
PHOTO_GIMP_ZIP="/tmp/PhotoGIMP-linux.zip"
curl -L -o "$PHOTO_GIMP_ZIP" https://github.com/Diolinux/PhotoGIMP/releases/latest/download/PhotoGIMP-linux.zip

echo "Extracting PhotoGIMP..."
unzip -o "$PHOTO_GIMP_ZIP" -d /tmp/

echo "Installing PhotoGIMP..."
cp -r /tmp/PhotoGIMP-linux/.local $HOME
cp -r /tmp/PhotoGIMP-linux/.config $HOME

echo "Cleaning up..."
rm -rf /tmp/PhotoGIMP-linux/ "$PHOTO_GIMP_ZIP"

echo "PhotoGIMP installed successfully!"
