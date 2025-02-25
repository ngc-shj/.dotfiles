#!/bin/bash

# History
mkdir -p "${XDG_STATE_HOME}"/bash
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export HISTSIZE=1000000
export SAVEHIST=1000000
