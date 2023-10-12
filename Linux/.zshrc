## ANTIGEN
source ~/.config/zsh/antigen.zsh

## FISH LIKE AUTOSUGGESTION

antigen bundle zsh-users/zsh-autosuggestions

## AUTO TMUX
antigen apply

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt histignorespace                                          # Don't save commands that start with space

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
zstyle ':completion:*' menu select                              # Highlight menu selection
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000


# case insensitive tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

#Syntax Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# UP and DOWN arrow for history substring search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up			
bindkey '^[[B' history-substring-search-down

# NEOVIM BOB  PATH
export PATH="$PATH:/home/pbk/.local/share/bob/nvim-bin"

# ADD DART TO PATH
export PATH="$PATH:/opt/flutter/bin"

# STARSHIP
eval "$(starship init zsh)"

# CTRL+ARROW NAVIGATION
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      alias dir='dir --color=auto'
      alias vdir='vdir --color=auto'
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
  fi

# some more ls aliases

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#source /usr/share/nvm/init-nvm.sh


###############################
##                           ##
##          ALIASES          ##
##                           ##
###############################

alias repos='cd ~/dev/source'
alias ls='exa'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias py='python3'

# runs a nested gnome shell, good for extension development.
alias nestrun='dbus-run-session -- gnome-shell --nested --wayland 2> /dev/null &'

# bun completions
[ -s "/home/pbk/.bun/_bun" ] && source "/home/pbk/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export EDITOR="/home/pbk/.local/share/bob/nvim-bin/nvim"
# File and Dir colors for ls and other outputs
export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"
alias ls='exa $LS_OPTIONS'
alias df="df -h"

function sysmaintain {
  sudo pacman -Syyu --noconfirm
  yay -Syyu --noconfirm
  sudo find ~/.cache/ -type f -atime +100 -delete
  sudo journalctl --vacuum-size=50M
  sudo journalctl --vacuum-time=2weeks
  sudo pacman -Sc
  sudo pacman -Qdt
  sudo pacman -Rns $(sudo pacman -Qtdq)
}
ZELLIJ_AUTO_ATTACH=false
ZELLIJ_AUTO_EXIT=true

if [[ "$TERM" == "alacritty" ]]; then
  if [[ -z "$ZELLIJ" ]]; then
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
      else
        zellij
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
  fi
fi
export PATH=$PATH:/home/pbk/.spicetify
