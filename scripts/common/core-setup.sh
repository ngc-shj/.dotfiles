#!/bin/bash
set -e

echo "🚀 Installing Core tools using Homebrew..."

brew bundle --file="$HOME/.dotfiles/brewfiles/core"

echo "✅ Core tools installation complete!"
