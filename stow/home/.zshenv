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
# Auto-detect libsk-libfido2 library location
for sk_provider in \
    /usr/local/lib/libsk-libfido2.dylib \
    /opt/homebrew/lib/libsk-libfido2.dylib \
    /usr/lib/x86_64-linux-gnu/libsk-libfido2.so \
    /usr/lib/aarch64-linux-gnu/libsk-libfido2.so \
    /usr/lib/libsk-libfido2.so; do
    if [[ -f "$sk_provider" ]]; then
        export SSH_SK_PROVIDER="$sk_provider"
        break
    fi
done
unset sk_provider

# Load environment variables and PATH from env.d (for all shells)
# This ensures PATH is available even in non-login shells (e.g., GUI-launched terminals)
if [[ -d "$ZDOTDIR/env.d" ]]; then
    for rc in "$ZDOTDIR/env.d"/*.(zsh|sh)(N); do
        [[ -r "$rc" ]] && builtin source "$rc" || continue
    done

    # On macOS, save PATH after env.d loading
    # /etc/zprofile runs path_helper which reorders PATH, moving custom paths to the end
    # We'll restore this PATH in profile.d/00-restore-paths.sh
    if [[ "$OSTYPE" == "darwin"* ]]; then
        export ZSHENV_PATH="$PATH"
    fi
fi
