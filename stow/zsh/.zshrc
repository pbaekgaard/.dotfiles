#!/bin/zsh
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config/"
source $HOME/.local/scripts/tmux-sessionizer.zsh
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="eastwood"
# ZSH_THEME="agnoster"
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13


# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

##########################################################################
#
#           $$\ $$\                                         
#           $$ |\__|                                        
#  $$$$$$\  $$ |$$\  $$$$$$\   $$$$$$$\  $$$$$$\   $$$$$$$\ 
#  \____$$\ $$ |$$ | \____$$\ $$  _____|$$  __$$\ $$  _____|
#  $$$$$$$ |$$ |$$ | $$$$$$$ |\$$$$$$\  $$$$$$$$ |\$$$$$$\  
# $$  __$$ |$$ |$$ |$$  __$$ | \____$$\ $$   ____| \____$$\ 
# \$$$$$$$ |$$ |$$ |\$$$$$$$ |$$$$$$$  |\$$$$$$$\ $$$$$$$  |
#  \_______|\__|\__| \_______|\_______/  \_______|\_______/
#
##########################################################################
alias notes="nvim ~/Nextcloud/Obsidian/Notes/index.md"
alias v='nvim'
alias vi='nvim'
alias py='python3.13'
alias pip='pip3'
alias ls='exa'
alias la='exa -la'
alias lg='lazygit'
alias cat='batcat'
alias sdk='. /usr/local/oecore-x86_64/environment-setup-cortexa53-crypto-oe-linux'

##########################################################################
#
# $$$$$$$$\ $$\    $$\  $$$$$$\  $$\       $$$$$$\  
# $$  _____|$$ |   $$ |$$  __$$\ $$ |     $$  __$$\ 
# $$ |      $$ |   $$ |$$ /  $$ |$$ |     $$ /  \__|
# $$$$$\    \$$\  $$  |$$$$$$$$ |$$ |     \$$$$$$\  
# $$  __|    \$$\$$  / $$  __$$ |$$ |      \____$$\ 
# $$ |        \$$$  /  $$ |  $$ |$$ |     $$\   $$ |
# $$$$$$$$\    \$  /   $$ |  $$ |$$$$$$$$\\$$$$$$  |
# \________|    \_/    \__|  \__|\________|\______/
#
##########################################################################
eval "$(zoxide init zsh --cmd cd)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
source <(fzf --zsh)


##########################################################################
#
#$$$$$$$$\ $$\   $$\ $$$$$$$\   $$$$$$\  $$$$$$$\ $$$$$$$$\  $$$$$$\  
# $$  _____|$$ |  $$ |$$  __$$\ $$  __$$\ $$  __$$\\__$$  __|$$  __$$\ 
# $$ |      \$$\ $$  |$$ |  $$ |$$ /  $$ |$$ |  $$ |  $$ |   $$ /  \__|
# $$$$$\     \$$$$  / $$$$$$$  |$$ |  $$ |$$$$$$$  |  $$ |   \$$$$$$\  
# $$  __|    $$  $$<  $$  ____/ $$ |  $$ |$$  __$$<   $$ |    \____$$\ 
# $$ |      $$  /\$$\ $$ |      $$ |  $$ |$$ |  $$ |  $$ |   $$\   $$ |
# $$$$$$$$\ $$ /  $$ |$$ |       $$$$$$  |$$ |  $$ |  $$ |   \$$$$$$  |
# \________|\__|  \__|\__|       \______/ \__|  \__|  \__|    \______/
#
##########################################################################
# export LDFLAGS=-L/home/linuxbrew/.linuxbrew/opt/node@20/lib
export SUDO_EDITOR=nvim
# export CPPFLAGS=-I/home/linuxbrew/.linuxbrew/opt/node@20/include

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/scripts"
export PATH="$PATH:$(brew --prefix python@3.11)/libexec/bin"
export PATH="$PATH:$HOME/.config/tmux/plugins/tmuxifier/bin/"
eval "$(tmuxifier init -)"
export EDITOR="nvim"
export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmux/layouts/"
export TMUXIFIER_TEMPLATE_PATH="$HOME/.config/tmux/templates/"

[ -f "/home/pbk/.ghcup/env" ] && . "/home/pbk/.ghcup/env" # ghcup-env

# bun completions
[ -s "/home/pbk/.bun/_bun" ] && source "/home/pbk/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH=$PATH:/home/pbk/.spicetify

export FZF_CTRL_R_EDIT_KEY=ctrl-e
export FZF_CTRL_R_EXEC_KEY=enter
