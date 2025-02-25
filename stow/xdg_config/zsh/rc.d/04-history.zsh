#!/bin/zsh

# History
setopt share_history

mkdir -p "$XDG_STATE_HOME"/zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
