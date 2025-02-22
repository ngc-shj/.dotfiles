#!/bin/bash
set -e

echo "🚀 Installing CLI development tools using Homebrew..."

brew bundle --file="$HOME/.dotfiles/brewfiles/dev-cli"

echo "✅ CLI development tools installation complete!"
