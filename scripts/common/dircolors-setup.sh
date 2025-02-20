#!/bin/bash
set -e

echo "🚀 Setting up dircolors configuration..."

# Check if ghq is installed
if ! command -v ghq &>/dev/null; then
    echo "🚫 ghq is not installed. Please install ghq and run this script again."
    exit 1
fi

echo "🔧 Downloading dircolors-solarized source..."
DIRCOLORS_DIR="$XDG_CONFIG_HOME/dircolors"
mkdir -p $DIRCOLORS_DIR

DIRCOLORS_GIT_URL="github.com/seebi/dircolors-solarized"
ghq get -u -p $DIRCOLORS_GIT_URL

echo "🔗 Creating symlink for dircolors..."
ln -sf $(ghq root)/$DIRCOLORS_GIT_URL/dircolors.256dark $DIRCOLORS_DIR/dircolors.256dark
ln -sf $(ghq root)/$DIRCOLORS_GIT_URL/dircolors.ansi-dark $DIRCOLORS_DIR/dircolors.ansi-dark
ln -sf $(ghq root)/$DIRCOLORS_GIT_URL/dircolors.ansi-light $DIRCOLORS_DIR/dircolors.ansi-light
ln -sf $(ghq root)/$DIRCOLORS_GIT_URL/dircolors.ansi-universal $DIRCOLORS_DIR/dircolors.ansi-universal

(cd $DIRCOLORS_DIR && ln -sf dircolors.ansi-dark dircolors)

echo "✅ dircolors setup complete!"
