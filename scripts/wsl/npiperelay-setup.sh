#!/bin/bash
set -e

echo "🚀 Setting up npiperelay for WSL2..."

# Check if npiperelay is already installed
if command -v npiperelay.exe &>/dev/null; then
    echo "🚫 npiperelay.exe is already installed. Exiting..."
    exit 1
fi

# Check if Go is installed
if ! command -v go &>/dev/null; then
    echo "🚫 Go is not installed. Please install Go and run this script again."
    exit 1
fi 

# Check if socat is installed
if ! command -v socat &>/dev/null; then
    echo "🚫 socat is not installed. Please install socat and run this script again."
    exit 1
fi

# Check if ghq is installed
if ! command -v ghq &>/dev/null; then
    echo "🚫 ghq is not installed. Please install ghq and run this script again."
    exit 1
fi

# Define paths
WIN_GO_BIN="/mnt/c/Users/$(powershell.exe '$env:UserName' | tr -d '\r\n')/go/bin"
mkdir -p $WIN_GO_BIN
NPIPERELAY_EXE="$WIN_GO_BIN/npiperelay.exe"

# Build npiperelay.exe
if [ ! -f "$NPIPERELAY_EXE" ]; then
    echo "🔧 Downloading npiperelay source..."
    ghq get -u -p github.com/albertony/npiperelay

    echo "🔨 Building npiperelay.exe..."
    cd $(ghq root)/github.com/albertony/npiperelay
    GOOS=windows go build -o "$NPIPERELAY_EXE" 
fi

# Ensure npiperelay is accessible from WSL
if [ ! -L "/usr/local/bin/npiperelay.exe" ]; then
    echo "🔗 Creating symlink for npiperelay..."
    sudo ln -s "$NPIPERELAY_EXE" /usr/local/bin/npiperelay.exe
fi

echo "✅ npiperelay setup complete!"
