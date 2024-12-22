#!/bin/bash
HERE=$(pwd)

# Create temp folder for files
INSTALLDIR="/tmp/dotfiles_installer"
mkdir -p $INSTALLDIR


# Ask for sudo password once at the beginning
sudo -v

# Update package lists
sudo apt update
sudo apt install vim libevent-dev yacc ncurses-dev build-essential bison pkg-config exa stow zsh -y

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
#
# # Stow Config
cd $HERE
git submodule init
git submodule update
git pull --recurse-submodules
#
# # Stow config to home directory
rm -rf $HOME/.zshrc
cd stow
stow * -t ~

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#
#
#
# # Temporarily switch to Zsh for the remainder of the script
# # Launch a new Zsh shell but keep the script running after

# Install Brew (Homebrew)
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


zsh -c "
source ~/.zshrc
INSTALLDIR="/tmp/dotfiles_installer"
# Install Kitty terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Install Zoxide and Neovim using Brew

brew install zoxide
brew install neovim
# tmux dependency
brew install byacc
brew install fzf

# install languages
brew install python3
brew install ghc
brew install go
brew install npm
brew install ghcup
curl -fsSL https://bun.sh/install | bash

source ~/.zshrc
# Install Tmux
git clone https://github.com/tmux/tmux.git \$INSTALLDIR/tmux
cd \$INSTALLDIR/tmux
sh autogen.sh
./configure
make && sudo make install

# Clean up
rm -rf \$INSTALLDIR
"
chsh -s /bin/zsh
zsh
