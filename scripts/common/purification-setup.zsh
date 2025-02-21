#!/bin/bash
set -e

echo "🚀 Setting up Zsh prompt configuration..."

# Check if ghq is installed
if ! command -v ghq &>/dev/null; then
    echo "🚫 ghq is not installed. Please install ghq and run this script again."
    exit 1
fi

echo "🔧 Downloading Zsh prompt source..."
PURIFICATION_GIT_URL="github.com/Phantas0s/purification"
ghq get -u -p $PURIFICATION_GIT_URL

echo "🔗 Creating symlink for Zsh prompt..."
PURIFICATION_DIR="$ZDOTDIR/purification"
ln -sf $(ghq root)/$PURIFICATION_GIT_URL $PURIFICATION_DIR

echo "✅ Zsh prompt setup complete!"
