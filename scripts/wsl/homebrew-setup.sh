#!/bin/bash
set -e

echo "🚀 Setting up Homebrew for WSL..."

# Install dependencies
sudo apt-get install -y build-essential procps curl file git

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

