
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
        local ARG=${!i}
        if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        	PATH="$ARG${PATH:+":$PATH"}"
    	fi
    done
}
