#!/bin/bash
set -e

echo "🚀 Installing general applications using Homebrew..."

brew bundle --file="$HOME/.dotfiles/Brewfiles/applications"

echo "✅ General applications installation complete"
