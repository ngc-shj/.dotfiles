# [Configuring Zsh Without Dependencies](https://thevaluable.dev/zsh-install-configure-mouseless/)

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

# Platform-specific environment
export SSH_SK_PROVIDER=/usr/local/lib/sk-libfido2.dylib

# Load environment variables and PATH from env.d (for all shells)
# This ensures PATH is available even in non-login shells (e.g., GUI-launched terminals)
if [[ -d "$ZDOTDIR/env.d" ]]; then
    for rc in "$ZDOTDIR/env.d"/*.(zsh|sh)(N); do
        [[ -r "$rc" ]] && builtin source "$rc"
    done
fi
