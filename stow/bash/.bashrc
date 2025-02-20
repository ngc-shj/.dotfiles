#!/bin/bash

# Environment Variables
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="$HOME/.local/share"
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
