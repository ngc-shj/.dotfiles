# Lang
export LANG="ja_JP.UTF-8"

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
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export LESSHISTSIZE=1000000


# XDG Base Directory

# android
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
# dotnet
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
# gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
# java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
# keras
export KERAS_HOME="$XDG_STATE_HOME"/keras
# redis
export REDISCLI_HISTFILE="$XDG_STATE_HOME"/redis/rediscli_history
# rustup
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# sqlite
export SQLITE_HISTORY="$XDG_STATE_HOME"/sqlite_history
# w3m
export W3M_DIR="$XDG_DATA_HOME"/w3m
