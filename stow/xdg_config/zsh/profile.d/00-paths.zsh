# Homebrew
if [ "$(uname)" = "Darwin" ]; then
    [[ -d "/opt/homebrew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ "$(uname)" = "Linux" ]; then
    [[ -d "/home/linuxbrew/.linuxbrew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# common functions
path_append() {
    local ARG
    for ARG in "$@"; do
        if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
            PATH="${PATH:+"$PATH:"}$ARG"
        fi
    done
}

path_prepend() {
    for ((i=$#; i>0; i--)); do
        local ARG=${(P)i}
        if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        	PATH="$ARG${PATH:+":$PATH"}"
    	fi
    done
}

if [ -d "$HOME/.local/bin" ]; then
    path_prepend "$HOME/.local/bin"
fi

if [ -d "$HOME/bin" ]; then
    path_prepend "$HOME/bin"
fi
