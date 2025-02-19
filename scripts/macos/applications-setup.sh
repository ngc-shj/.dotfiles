#!/bin/bash
set -e

echo "🚀 Installing general applications using Homebrew..."

brew bundle --file="$HOME/.dotfiles/brewfiles/applications"

echo "✅ General applications installation complete"
