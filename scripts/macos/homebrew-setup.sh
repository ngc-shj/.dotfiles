#!/bin/bash
set -e  # Exit on error

echo "🚀 Setting up Homebrew for macOS..."

# Check if Homebrew is already installed
if ! command -v brew &>/dev/null; then
    echo "🔧 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✅ Homebrew is already installed"
fi

echo "✅ Homebrew setup complete"
