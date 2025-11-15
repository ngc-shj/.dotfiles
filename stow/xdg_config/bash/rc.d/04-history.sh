#!/bin/bash

mkdir -p "${XDG_STATE_HOME}"/bash
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export HISTSIZE=1000000
export HISTFILESIZE=1000000  # Bash: number of lines in history file
export SAVEHIST=1000000       # Zsh: number of lines to save
export HISTCONTROL=ignorespace
