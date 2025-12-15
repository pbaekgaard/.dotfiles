#!/bin/bash

set -e

echo "🚀 Starting Omarchy dotfiles installation..."

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install zsh if not present
if ! command_exists zsh; then
    echo "📦 Installing zsh..."
    if command_exists pacman; then
      sudo pacman -S --noconfirm zsh
    else
        echo "❌ Please install zsh manually and run this script again"
        exit 1
    fi
else
    echo "✅ zsh is already installed"
fi

# Install oh-my-zsh silently
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installing oh-my-zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ oh-my-zsh is already installed"
fi

# Install zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "📦 Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "✅ zsh-syntax-highlighting is already installed"
fi

# Install zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo "📦 Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "✅ zsh-autosuggestions is already installed"
fi

echo "✅ Shell setup complete!"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_DIR="$SCRIPT_DIR/env"

# Function to create symlink if target doesn't exist
create_symlink() {
    local src="$1"
    local dest="$2"
    local dest_dir="$(dirname "$dest")"
    local basename="$(basename "$dest")"
    local timestamp=$(date +%d%m%Y)
    
    # Create destination directory if it doesn't exist
    mkdir -p "$dest_dir"
    
    # Backup existing file/directory if it exists
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        local backup="$dest.$timestamp.bak"
        echo "⚠️  Backing up existing $dest to $backup"
        mv "$dest" "$backup"
    fi
    
    # Create symlink
    echo "🔗 Linking $src -> $dest"
    ln -s "$src" "$dest"
}

echo "🔗 Setting up dotfile symlinks..."

# Home directory files
create_symlink "$ENV_DIR/home/.zshenv" "$HOME/.zshenv"

# Config directory symlinks
create_symlink "$ENV_DIR/.config/hypr" "$HOME/.config/hypr"
create_symlink "$ENV_DIR/.config/waybar" "$HOME/.config/waybar"
create_symlink "$ENV_DIR/.config/omarchy" "$HOME/.config/omarchy"
create_symlink "$ENV_DIR/.config/tmux" "$HOME/.config/tmux"
create_symlink "$ENV_DIR/.config/zsh" "$HOME/.config/zsh"
create_symlink "$ENV_DIR/.config/nvim" "$HOME/.config/nvim"

# Local directory symlinks
create_symlink "$ENV_DIR/.local/bin/tmux-sessionizer" "$HOME/.local/bin/tmux-sessionizer"
create_symlink "$ENV_DIR/.local/bin/tmux-sessionizer.zsh" "$HOME/.local/bin/tmux-sessionizer.zsh"

# Initialize git submodules
echo "📦 Initializing git submodules..."
cd "$SCRIPT_DIR"
git submodule update --init --recursive

echo "✅ Dotfiles installation complete!"
echo "🎯 Restart your shell or run 'source ~/.zshenv' to apply changes"
