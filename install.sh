#!/bin/sh

set -e

git config --global user.name "pbaekgaard"
git config --global user.email "pbakga21@student.aau.dk"
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
rm -rf $HOME/.config/nvim
cp -r ./env/.local $HOME
cp -rf ./env/.config $HOME
cp -r ./env/.zshrc $HOME/.zshrc;
rm -rf $HOME/.config/nvim
ln -s $HOME/.dotfiles/env/.config/nvim $HOME/.config/nvim -f 


# If just doing config, exit here
if [ "$JUST_CONFIG" = true ]; then
  echo "Dotfiles installed. Exiting (--just-config)."
  exit 0
fi


# Get best mirrors
echo "Getting best mirrors"
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
if ! command -v paru &> /dev/null; then
	git clone https://aur.archlinux.org/paru.git
	cd paru
	makepkg -si
	cd ..
	rm -rf paru
fi

# tools (exa, zoxide, brew, waybar)
paru -S --needed --noconfirm exa zoxide waybar fzf

# hyprland stuff
paru -S hypridle hyprshot-git hyprlock --needed --noconfirm

echo "hello"
for script in ~/.dotfiles/fonts/*.sh; do
	echo "checking if $script is executable"
	[ -x "$script" ] && echo "executing $script" && "$script"
done
for script in ~/.dotfiles/applications/*.sh; do
	[ -x "$script" ] && "$script"
done
cp ./wallpapers $HOME/wallpapers -r
