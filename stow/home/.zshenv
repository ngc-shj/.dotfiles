# [Configuring Zsh Without Dependencies](https://thevaluable.dev/zsh-install-configure-mouseless/)

# Environment Variables
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_STATE_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_CACHE_HOME/zsh
mkdir -p $ZDOTDIR
export SSH_SK_PROVIDER=/usr/local/lib/sk-libfido2.dylib
