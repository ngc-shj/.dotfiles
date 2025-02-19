#!/bin/bash
set -e

echo "🚀 Setting up npiperelay for WSL2..."

# Install Go if not installed
if ! command -v go &>/dev/null; then
    echo "🔧 Installing Go..."
    sudo apt update
    sudo apt install -y golang
fi

# Define paths
WIN_GO_BIN="/mnt/c/Users/$(powershell.exe '$env:UserName' | tr -d '\r\n')/go/bin"
NPIPERELAY_EXE="$WIN_GO_BIN/npiperelay.exe"

# Build npiperelay.exe
if [ ! -f "$NPIPERELAY_EXE" ]; then
    echo "🔧 Downloading npiperelay source..."
    go get -d github.com/jstarks/npiperelay

    echo "🔨 Building npiperelay.exe..."
    GOOS=windows go build -o "$NPIPERELAY_EXE" github.com/jstarks/npiperelay
fi

# Ensure npiperelay is accessible from WSL
if [ ! -L "/usr/local/bin/npiperelay.exe" ]; then
    echo "🔗 Creating symlink for npiperelay..."
    sudo ln -s "$NPIPERELAY_EXE" /usr/local/bin/npiperelay.exe
fi

# Install socat if not installed
if ! command -v socat &>/dev/null; then
    echo "🔧 Installing socat..."
    sudo apt install -y socat
fi

# Create SSH agent wrapper
mkdir -p ~/.ssh
cat <<EOF > ~/.ssh/win-ssh-agent
#!/bin/bash
exec socat -d -d UNIX-LISTEN:\$SSH_AUTH_SOCK,fork EXEC:"\$NPIPERELAY_EXE -ei -s //./pipe/openssh-ssh-agent",nofork
EOF
chmod +x ~/.ssh/win-ssh-agent

# Add SSH_AUTH_SOCK to .bashrc if not already added
if ! grep -q "export SSH_AUTH_SOCK" ~/.bashrc; then
    echo "export SSH_AUTH_SOCK=/tmp/ssh-agent.sock" >> ~/.bashrc
    echo "if [ ! -S \$SSH_AUTH_SOCK ]; then ~/.ssh/win-ssh-agent & fi" >> ~/.bashrc
fi

echo "✅ npiperelay setup complete!"
