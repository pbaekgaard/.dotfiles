#!/bin/sh
set -e
# ghostty
paru -S --needed --noconfirm ghostty
# zsh
paru -S --needed --noconfirm zsh
chsh -s /usr/bin/zsh
## oh my zsh
paru -S --needed --noconfirm oh-my-zsh-git

if [ ! -d "/usr/share/oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /usr/share/oh-my-zsh/plugins/zsh-syntax-highlighting
fi
if [ ! -d "/usr/share/oh-my-zsh/plugins/zsh-autosuggestions" ]; then
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git /usr/share/oh-my-zsh/plugins/zsh-autosuggestions
fi


