#!/bin/bash
set -e

echo "🚀 Setting up Homebrew for Ubuntu..."

# Install dependencies
sudo apt-get install -y build-essential procps curl file git

# Check if Homebrew is already installed
if ! command -v brew &>/dev/null; then
    echo "🔧 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo $PATH
else
    echo "✅ Homebrew is already installed"
fi

echo "🔄 Running brew bundle for Homebrew taps..."
brew bundle --file="$HOME/.dotfiles/brewfiles/homebrew"

echo "✅ Homebrew setup complete"

