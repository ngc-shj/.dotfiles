#!/bin/bash
set -e

echo "🚀 Applying dotfiles using stow for RHEL..."

cd ~/.dotfiles/stow
stow -t ~ home
stow -t ~/.config xdg_config

echo "✅ Stow setup complete for RHEL"
