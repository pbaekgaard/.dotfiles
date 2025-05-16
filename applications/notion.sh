#!/bin/sh

# Install Notion and dependencies
paru -S --needed --noconfirm notion-app-enhanced
sudo npm i -g asar

resourcefolder="/opt/Notion Enhanced/resources"

# Extract the ASAR
sudo asar extract "$resourcefolder/app.asar" "$resourcefolder/app"

# Define paths
preloadjs="$resourcefolder/app/renderer/preload.js"
patchfile="notionfix.txt"

# Check if files exist
if ! sudo test -f "$preloadjs"; then
  echo "Error: preload.js not found at $preloadjs"
  exit 1
fi

if [ ! -f "$patchfile" ]; then
  echo "Error: patch file $patchfile not found"
  exit 1
fi

# Add ';' to end of last line if missing
last_line=$(sudo tail -n 1 "$preloadjs")
if [ "${last_line: -1}" != ";" ]; then
  sudo sh -c "head -n -1 \"$preloadjs\" > \"$preloadjs.tmp\" && echo \"$last_line;\" >> \"$preloadjs.tmp\" && mv \"$preloadjs.tmp\" \"$preloadjs\""
fi

# Append newline and contents of patch file
sudo sh -c "echo '' >> \"$preloadjs\" && cat \"$patchfile\" >> \"$preloadjs\""

echo "✅ preload.js patched successfully."
