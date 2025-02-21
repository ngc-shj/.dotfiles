#!/bin/bash
set -e

echo "🚀 Setting up nvim configuration..."

# Check if ghq is installed
if ! command -v ghq &>/dev/null; then
    echo "🚫 ghq is not installed. Please install ghq and run this script again."
    exit 1
fi

# Ensure $XDG_CONFIG_HOME/nvim directory exists
mkdir -p $XDG_CONFIG_HOME/nvim/colors $XDG_CONFIG_HOME/nvim/bundle $XDG_CONFIG_HOME/nvim/autoload

echo "🔧 Downloading vim-plug..."
VIM_PLUG_URL="github.com/junegunn/vim-plug"
ghq get -u -p $VIM_PLUG_URL

echo "🔗 Creating symlink for vim-plug"
ln -sf $(ghq root)/$VIM_PLUG_URL/plug.vim $XDG_CONFIG_HOME/nvim/autoload/plug.vim

echo "🔧 Downloading vim-colors-solarized..."
SOLARIZED_GIT_URL="github.com/altercation/vim-colors-solarized"
ghq get -u -p $SOLARIZED_GIT_URL
SOLARIZED_DIR="$XDG_CONFIG_HOME/nvim/bundle/vim-colors-solarized"
ln -sf $(ghq root)/$SOLARIZED_GIT_URL $SOLARIZED_DIR

echo "🔗 Creating symlink for solarized color scheme..."
ln -sf "$SOLARIZED_DIR/colors/solarized.vim" $XDG_CONFIG_HOME/nvim/colors/solarized.vim

echo "✅ nvim setup complete!"
