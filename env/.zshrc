export ZSH="/usr/share/oh-my-zsh/"
source $HOME/.local/scripts/tmux-sessionizer.zsh

ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

setopt nullglob

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
alias vim='nvim'
alias py='python3'
alias open='xdg-open'
alias icat='kitten icat'
alias python='python3'
alias pip='pip3'
alias ls='exa'
alias la='exa -la'
alias lg='lazygit'
alias qnotes='nvim ~/Nextcloud/Notes/Quicknotes.norg'
dotcommit() {
  local verbose=0
  # Check if verbose flag is passed
  for arg in "$@"; do
    case "$arg" in
      -v|--verbose) verbose=1 ;;
    esac
  done

  # Paths to sync in an array for readability
  local paths=(
    ~/.config/alacritty
    ~/.config/autostart
    ~/.config/ghostty
    ~/.config/htop
    ~/.config/hypr
    ~/.config/kanshi
    ~/.config/kitty
    ~/.config/nwg-look
    ~/.config/pip
    ~/.config/rofi
    ~/.config/spicetify
    ~/.config/swaync
    ~/.config/systemd
    ~/.config/themer
    ~/.config/Thunar
    ~/.config/tmux
    ~/.config/waybar
    ~/.config/wlogout
    ~/.config/wofi
    ~/.config/zathura
  )

  # Build rsync command
  local rsync_cmd=(rsync -av --exclude='.git/')

  # If not verbose, add --info=progress2 for progress bar output only
  if [[ $verbose -eq 0 ]]; then
    rsync_cmd+=(--info=progress2)
  fi

  # Add paths
  rsync_cmd+=("${paths[@]}" ~/.dotfiles/env/.config)

  # Run rsync
  if [[ $verbose -eq 1 ]]; then
    "${rsync_cmd[@]}"
  else
    # Hide normal rsync verbose output except progress
    "${rsync_cmd[@]}" 2>&1 | stdbuf -o0 tr '\r' '\n' | grep --line-buffered -E 'to-check|^ *[0-9]+%'
  fi

  # Git commit and push
  (
    cd ~/.dotfiles || return
    git add .
    git commit -m "dotcommit"
    git push
  )
}

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
export PATH="$PATH:$HOME/.config/tmux/plugins/tmuxifier/bin/"
eval "$(tmuxifier init -)"
eval "$(fzf --zsh)"
export EDITOR="nvim"
export TMUXIFIER_LAYOUT_PATH="$HOME/.config/tmux/layouts/"
export TMUXIFIER_TEMPLATE_PATH="$HOME/.config/tmux/templates/"


if [ "$NVIM_IS_DEFINED" != true ]; then
  nvim_random_listen() {
    export NVIM_IS_DEFINED=true
    local random_number=$(od -An -N2 -i /dev/random | tr -d ' ')
    local server_name="/tmp/themelistener${random_number}"
    nvim --listen "$server_name" "$@"
  }
  alias nvim=nvim_random_listen
fi

[ -f "/home/pbk/.ghcup/env" ] && . "/home/pbk/.ghcup/env" # ghcup-env

# bun completions
[ -s "/home/pbk/.bun/_bun" ] && source "/home/pbk/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export FZF_CTRL_R_EDIT_KEY=ctrl-e
export FZF_CTRL_R_EXEC_KEY=enter
