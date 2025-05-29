# Neovim and Tmux
paru -S --needed --noconfirm neovim tmux lazygit
mkdir -p $HOME/.config/nvim
git clone git@github.com:pbaekgaard/kickstart.nvim $HOME/.config/nvim

mkdir -p $HOME/.config/tmux/plugins
git clone https://github.com/tmux-plugins/tpm $HOME/.config/tmux/plugins/tpm
git clone https://github.com/jimeh/tmuxifier.git $HOME/.config/tmux/plugins/tmuxifier

# Neovim Language Dependencies
## GoLang
sudo pacman -S --needed --noconfirm go

# Node
paru -S --needed --noconfirm nodejs npm

# Python
paru -S --needed --noconfirm poetry python-httpx python-pip

# Markdown
sudo pacman -S --needed --noconfirm markdownlint

# latex
paru -S --needed --noconfirm texlive-fontsrecommended texlive-latexrecommended texlive-langgreek pandoc texlive-mathscience texlive-binextra
