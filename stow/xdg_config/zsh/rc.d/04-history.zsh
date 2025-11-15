#!/bin/zsh

setopt share_history
setopt hist_ignore_space

mkdir -p "$XDG_STATE_HOME"/zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export HISTSIZE=1000000
export HISTFILESIZE=1000000  # Bash: number of lines in history file
export SAVEHIST=1000000       # Zsh: number of lines to save
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
