#!/bin/bash
set -e

echo "🚀 Applying dotfiles using stow for WSL..."

cd ~/.dotfiles/stow
stow -t ~ bash ubuntu wsl git vim ssh tmux

echo "✅ Stow setup complete for WSL"
