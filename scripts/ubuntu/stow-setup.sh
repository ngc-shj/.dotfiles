#!/bin/bash
set -e

echo "🚀 Applying dotfiles using stow for Ubuntu..."

cd ~/.dotfiles/stow
stow -t ~ bash ubuntu git vim ssh tmux

echo "✅ Stow setup complete for Ubuntu"

