#!/bin/bash
set -e  # Exit on error

if command -v brew &>/dev/null; then
    echo "✅ Homebrew is already installed"
    return
fi

# Detect OS to determine installation method
if [[ "$OSTYPE" = "darwin"* ]]; then
    HOME_BREW_PATH="/opt/homebrew/bin/brew"

elif grep -qi "microsoft" /proc/version 2>/dev/null; then
    HOME_BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"

    # Install dependencies
    sudo apt-get install -y build-essential procps curl file git

elif [[ -f /etc/redhat-release ]]; then
    HOME_BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"

    # Install dependencies
    sudo dnf groupinstall -y "Development Tools"
    sudo dnf install -y curl file git

elif [[ -f /etc/lsb-release ]]; then
    HOME_BREW_PATH="/home/linuxbrew/.linuxbrew/bin/brew"

    # Install dependencies
    sudo apt-get install -y build-essential procps curl file git

else
    echo "❌ Unsupported OS detected"
    exit 1
fi

echo "🚀 Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
# Add Homebrew to PATH
eval "$($HOME_BREW_PATH shellenv)"

echo "✅ Homebrew installation complete!"
