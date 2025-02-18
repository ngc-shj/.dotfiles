#!/bin/bash
set -e

echo "🚀 Applying dotfiles using stow for RHEL..."

cd ~/.dotfiles/stow
stow -t ~ bash rhel git vim ssh tmux

echo "✅ Stow setup complete for RHEL"
