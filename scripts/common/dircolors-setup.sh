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
ln -sf $(ghq root)/$DIRCOLORS_GIT_URL $DIRCOLORS_DIR/dircolors-solarized

(cd $DIRCOLORS_DIR && ln -sf dircolors-solarized/dircolors.ansi-light dircolors)

echo "✅ dircolors setup complete!"
