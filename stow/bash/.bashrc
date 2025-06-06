# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bashrc.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bashrc.pre.bash"

# Environment Variables
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -d "$XDG_CONFIG_HOME/bash/rc.d" ]; then
    for rc in "$XDG_CONFIG_HOME/bash/rc.d/"*.sh; do
        [ -r "$rc" ] && . "$rc"
    done
fi

if [ -d "$XDG_CONFIG_HOME/zsh/rc.d" ]; then
    for rc in "$XDG_CONFIG_HOME/zsh/rc.d/"*.sh; do
        [ -r "$rc" ] && . "$rc"
    done
fi

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/bashrc.post.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/bashrc.post.bash"
