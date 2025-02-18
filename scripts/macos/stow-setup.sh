#!/bin/bash
set -e

echo "🚀 Applying dotfiles using stow for macOS..."

cd ~/.dotfiles/stow
stow -t ~ bash macos git vim zsh ssh tmux

echo "✅ Stow setup complete for macOS"

