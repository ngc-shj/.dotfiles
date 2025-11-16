# [Configuring Zsh Without Dependencies](https://thevaluable.dev/zsh-install-configure-mouseless/)

# Disable Amazon Q qterm (PTY wrapper) to improve shell startup performance
# qterm launches a new shell which causes double initialization
export Q_TERM=1

# XDG Base Directory Specification
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Create required directories
mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_STATE_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_CACHE_HOME/zsh
mkdir -p $ZDOTDIR

# Move zsh session files to XDG_STATE_HOME (macOS Terminal.app)
# Session data (history restoration, etc.) belongs in state directory, not config
# Old location: $ZDOTDIR/.zsh_sessions/ (can be safely deleted after migration)
# New location: $XDG_STATE_HOME/zsh/sessions/
export SHELL_SESSIONS_DIR="$XDG_STATE_HOME/zsh/sessions"

# Platform-specific environment
# SSH Security Key Provider (FIDO2/U2F support for SSH keys)
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS: Homebrew installation path
    export SSH_SK_PROVIDER=/usr/local/lib/sk-libfido2.dylib
elif [[ -f "/usr/lib/x86_64-linux-gnu/libsk-libfido2.so" ]]; then
    # Linux: Standard library path
    export SSH_SK_PROVIDER=/usr/lib/x86_64-linux-gnu/libsk-libfido2.so
fi

# Load environment variables and PATH from env.d (for all shells)
# This ensures PATH is available even in non-login shells (e.g., GUI-launched terminals)
if [[ -d "$ZDOTDIR/env.d" ]]; then
    for rc in "$ZDOTDIR/env.d"/*.(zsh|sh)(N); do
        [[ -r "$rc" ]] && builtin source "$rc" || continue
    done
fi
