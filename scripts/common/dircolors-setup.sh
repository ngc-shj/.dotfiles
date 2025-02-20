#!/bin/bash
set -e

echo "🚀 Setting up dircolors configuration..."

# Check if ghq is installed
if ! command -v ghq &>/dev/null; then
    echo "🚫 ghq is not installed. Please install ghq and run this script again."
    exit 1
fi

echo "🔧 Downloading dircolors-solarized source..."
ghq get -u -p github.com/seebi/dircolors-solarized

ln -sf $(ghq root)/github.com/seebi/dircolors-solarized/dircolors.256dark $HOME/.dircolors

echo "✅ dircolors setup complete!"
