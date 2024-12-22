#!/bin/zsh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# export TERM="xterm-color"
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
alias cat='bat'
alias ssh='kitten ssh'
alias qnotes='nvim ~/Nextcloud/Notes/Quicknotes.norg'

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
export NOTION_API_KEY="secret_lzFlqrbTtZJgIeiC29Y4wjqsdPBw9UnN4BKDqNILVnK"
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
