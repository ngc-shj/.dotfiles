# [Configuring Zsh Without Dependencies](https://thevaluable.dev/zsh-install-configure-mouseless/)

# Environment Variables
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_CACHE_HOME/zsh
mkdir -p $ZDOTDIR

# History
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export HISTSIZE=1000000
export SAVEHIST=1000000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-R"
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline - URL
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export LESSHISTSIZE=1000000


# TCL/TK
[[ -d /usr/local/opt/tcl-tk/ ]] && {
    export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
    export LDFLAGS="-L/usr/local/opt/tcl-tk/lib $LDFLAGS"
    export CPPFLAGS="-I/usr/local/opt/tcl-tk/include $CPPFLAGS"
    export PKG_CONFIG_PATH="/usr/local/opt/tcl-tk/lib/pkgconfig:$PKG_CONFIG_PATH"
}

# Golang
if [ -d "$HOME/go" ]; then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
fi

# nvm
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi

# cargo
if [ -d "$HOME/.cargo" ]; then
    . $HOME/.cargo/env
fi

# modular
if [ -d "$HOME/.modulear" ]; then
    export MODULAR_HOME="$HOME/.modular"
    export MOJO_PYTHON_LIBRARY="/usr/lib/x86_64-linux-gnu/libpython3.10.so"
fi
