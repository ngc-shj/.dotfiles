#!/bin/bash
set -e

echo "🚀 Setting up nvim configuration..."

# Ensure $XDG_CONFIG_HOME/nvim directory exists
mkdir -p $XDG_CONFIG_HOME/nvim/colors $XDG_CONFIG_HOME/nvim/bundle $XDG_CONFIG_HOME/nvim/autoload

# Install vim-plug if not present
if [ ! -f "$XDG_CONFIG_HOME/nvim/autoload/plug.vim" ]; then
    echo "🔧 Installing vim-plug..."
    curl -fLo $XDG_CONFIG_HOME/nvim/autoload/plug.vim --create-dirs \
        https://github.com/junegunn/vim-plug/plug.vim
fi

# Clone or update Solarized theme
SOLARIZED_DIR="$XDG_CONFIG_HOME/nvim/bundle/vim-colors-solarized"
if [ -d "$SOLARIZED_DIR/.git" ]; then
    echo "🔄 Updating vim-colors-solarized..."
    git -C "$SOLARIZED_DIR" pull
elif [ ! -d "$SOLARIZED_DIR" ]; then
    echo "🔧 Cloning vim-colors-solarized..."
    git clone https://github.com/altercation/vim-colors-solarized.git "$SOLARIZED_DIR"
fi

# Ensure symlink exists for color scheme
ln -sf "$SOLARIZED_DIR/colors/solarized.vim" $XDG_CONFIG_HOME/nvim/colors/solarized.vim

echo "✅ nvim setup complete!"
