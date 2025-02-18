#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

echo "🛠️ Detecting system environment..."

# Detect OS and set the corresponding script path
if grep -qi microsoft /proc/version; then
    OS_DIR="wsl"
elif [ "$(uname)" == "Darwin" ]; then
    OS_DIR="macos"
elif [ -f /etc/redhat-release ]; then
    OS_DIR="rhel"
elif [ -f /etc/lsb-release ]; then
    OS_DIR="ubuntu"
else
    echo "❌ Unsupported OS detected"
    exit 1
fi

echo "✅ Detected environment: $OS_DIR"

# Define script directory
SCRIPT_TOPDIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_DIR="$SCRIPT_TOPDIR/$OS_DIR"

# Run categorized setup scripts
echo "🔧 Setting up Homebrew..."
source "$SCRIPT_DIR/homebrew-setup.sh"

echo "🔧 Setting up CLI development tools..."
bash "$SCRIPT_DIR/dev-cli-setup.sh"

echo "🔧 Setting up Vim..."
bash "$SCRIPT_TOPDIR/common/vim-setup.sh"

if [ "$OS_DIR" == "macos" ]; then
    echo "🔧 Setting up development GUI tools..."
    bash "$SCRIPT_DIR/dev-gui-setup.sh"

    echo "🔧 Setting up general applications..."
    bash "$SCRIPT_DIR/applications-setup.sh"
elif [ "$OS_DIR" == "wsl" ]; then
    echo "🔧 Setting up Windows GUI applications (via winget)..."
    bash "$SCRIPT_DIR/dev-gui-setup.sh"

    echo "🔧 Setting up Windows general applications (via winget)..."
    bash "$SCRIPT_DIR/applications-setup.sh"
fi

echo "🔧 Applying dotfiles using stow..."
bash "$SCRIPT_DIR/stow-setup.sh"

echo "🎉 Setup completed successfully!"

