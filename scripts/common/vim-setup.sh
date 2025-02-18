#!/bin/bash
set -e

echo "🚀 Setting up Vim configuration..."

# Ensure ~/.vim directory exists
mkdir -p ~/.vim/colors ~/.vim/bundle ~/.vim/autoload

# Install vim-plug if not present
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "🔧 Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Clone or update Solarized theme
SOLARIZED_DIR="$HOME/.vim/bundle/vim-colors-solarized"
if [ -d "$SOLARIZED_DIR/.git" ]; then
    echo "🔄 Updating vim-colors-solarized..."
    git -C "$SOLARIZED_DIR" pull
elif [ ! -d "$SOLARIZED_DIR" ]; then
    echo "🔧 Cloning vim-colors-solarized..."
    git clone https://github.com/altercation/vim-colors-solarized.git "$SOLARIZED_DIR"
fi

# Ensure symlink exists for color scheme
ln -sf "$SOLARIZED_DIR/colors/solarized.vim" ~/.vim/colors/solarized.vim

echo "✅ Vim setup complete!"
