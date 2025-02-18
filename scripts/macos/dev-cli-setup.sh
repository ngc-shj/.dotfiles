#!/bin/bash
set -e

echo "🚀 Installing CLI development tools using Homebrew..."

brew bundle --file="$HOME/.dotfiles/Brewfiles/dev-cli"

echo "✅ CLI development tools installation complete"
