#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -d "$HOME/.bashrc.d" ]; then
    for rc in "$HOME/.bashrc.d/"*.sh; do
        [ -r "$rc" ] && . "$rc"
    done
fi

# User specific environment and startup programs
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
