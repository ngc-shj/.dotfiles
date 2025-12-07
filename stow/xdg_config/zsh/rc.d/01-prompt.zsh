#!/bin/zsh

# Pure prompt performance settings
# Disable git pull check to prevent delays from background git fetch
PURE_GIT_PULL=0

# Load prompt theme
# fpath+=($ZDOTDIR/purification)
# autoload -Uz promptinit && promptinit
# prompt_purification_setup

# Ensure Homebrew's zsh functions are in fpath before loading promptinit
if [[ -d "/opt/homebrew/share/zsh/site-functions" ]] && [[ ! "${fpath[(r)/opt/homebrew/share/zsh/site-functions]}" ]]; then
    fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi

# Initialize prompt system and load pure theme
autoload -Uz promptinit
promptinit
prompt pure
