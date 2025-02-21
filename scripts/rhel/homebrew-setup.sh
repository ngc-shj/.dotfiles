#!/bin/bash
set -e

echo "🚀 Setting up Homebrew for RHEL..."

# Install dependencies
sudo dnf groupinstall -y "Development Tools"
sudo dnf install -y curl file git

# Check if Homebrew is already installed
if ! command -v brew &>/dev/null; then
    echo "🔧 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "✅ Homebrew is already installed"
fi

echo "✅ Homebrew setup complete"

