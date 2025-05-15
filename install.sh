#!/bin/bash

set -e

JUST_CONFIG=false

# Parse arguments
for arg in "$@"; do
  case $arg in
    --just-config)
      JUST_CONFIG=true
      shift
      ;;
    *)
      echo "Unknown option: $arg"
      exit 1
      ;;
  esac
done

# Copy dotfiles
echo "Copying dotfiles..."
cp -r ./env/.local $HOME
cp -r ./env/.config $HOME
cp -r ./env/.zshrc $HOME/.zshrc
rm -rf ~/.config/nvim
ln -s $HOME/.dotfiles/env/.config/nvim $HOME/.config/nvim


# If just doing config, exit here
if [ "$JUST_CONFIG" = true ]; then
  echo "Dotfiles installed. Exiting (--just-config)."
  exit 0
fi


# Get best mirrors
sudo pacman -S --needed --noconfirm reflector
sudo reflector \
  --country "$(curl -s https://ipapi.co/country/)" \
  --protocol https \
  --latest 20 \
  --sort rate \
  --save /etc/pacman.d/mirrorlist
sudo pacman -Syy && sudo pacman -Syu
sudo pacman -S --needed --noconfirm wl-clipboard brightnessctl

# Install PARU
sudo pacman -S --needed base-devel --noconfirm
sudo pacman -S --needed --noconfirm rustup
rustup default stable
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

# tools (exa, zoxide, brew, waybar)
paru -S --needed --noconfirm exa zoxide waybar fzf
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# hyprland stuff
paru -S hypridle hyprshot hyprlock --needed --confirm

for scripts in ./fonts/*.sh; do
	[ -x "$script" ] && "$script"
done
for scripts in ./applications/*.sh; do
	[ -x "$script" ] && "$script"
done
cp ./wallpapers $HOME/wallpapers -r
