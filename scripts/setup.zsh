#!/bin/zsh
set -e  # Exit immediately if a command exits with a non-zero status

setopt null_glob  # If a glob does not match, remove it from the list of arguments

echo "🛠️ Detecting system environment..."

# Detect OS and set the corresponding script path
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OS=""
if [[ "$OSTYPE" = "darwin"* ]]; then
    OS="macos"
elif grep -qi "microsoft" /proc/version 2>/dev/null; then
    OS="wsl"
elif [[ -f /etc/redhat-release ]]; then
    OS="rhel"
elif [[ -f /etc/lsb-release ]]; then
    OS="ubuntu"
else
    echo "❌ Unsupported OS detected"
    exit 1
fi

echo "✅ Detected environment: $OS"

# Function to run setup scripts for a given category
run_scripts() {
    local category="$1"
    for script in "$SCRIPT_DIR/common/"$category-setup.(zsh|sh) "$SCRIPT_DIR/$OS/"$category-setup.(zsh|sh); do
        if [[ -f "$script" ]]; then
            echo "🔧 Executing: $script"
            builtin source "$script"
            break
        fi
    done
}

# Run setup scripts for each category
run_scripts "homebrew"
#
run_scripts "core"
run_scripts "dev-cli"
run_scripts "dev-gui"
run_scripts "applications"
#
run_scripts "stow"

# Run other setup scripts
for script in "$SCRIPT_DIR/common/"*.(zsh|sh) "$SCRIPT_DIR/$OS/"*.(zsh|sh); do
    case "$script" in
        *core-setup.sh|*homebrew-setup.sh|*dev-cli-setup.sh|*dev-gui-setup.sh|*applications-setup.sh|*stow-setup.sh)
            # Skip category setup scripts
            continue
            ;;
        *)
            echo "🔧 Executing: $script"
            builtin source "$script"
            ;;
    esac
done

echo "🎉 Setup completed successfully!"
