#!/bin/zsh

# Load prompt
fpath+=($ZDOTDIR/purification)
autoload -Uz promptinit && promptinit
prompt_purification_setup
