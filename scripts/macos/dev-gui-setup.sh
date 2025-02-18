#!/bin/bash
set -e

echo "🚀 Installing GUI applications using Homebrew..."

brew bundle --file="$HOME/.dotfiles/Brewfiles/dev-gui"

echo "✅ GUI applications installation complete"
