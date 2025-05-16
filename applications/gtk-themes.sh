THEMES_FOLDER=$HOME/.themes
mkdir -p $THEMES_FOLDER

# Catppuccin Mocha
CATPPUCCIN_MOCHA_GTK_ZIP="/tmp/catppuccin_mocha.zip"
CATPPUCCIN_MOCHA_GTK_FOLDER="/tmp/catppuccin_mocha"
curl -L -o "$CATPPUCCIN_MOCHA_GTK_ZIP" https://github.com/catppuccin/gtk/releases/latest/download//catppuccin-mocha-mauve-standard+default.zip

unzip -o "$CATPPUCCIN_MOCHA_GTK_ZIP" -d $CATPPUCCIN_MOCHA_GTK_FOLDER
cp -r $CATPPUCCIN_MOCHA_GTK_FOLDER/catppuccin-mocha-mauve-standard+default $THEMES_FOLDER/catppuccin-mocha

# Juno Mirage (Ayu Mirage)
git clone https://github.com/EliverLara/Juno/ -b mirage $THEMES_FOLDER/juno-mirage
