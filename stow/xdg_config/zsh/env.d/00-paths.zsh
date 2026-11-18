# Every exec at startup can stall for hundreds of ms on a Mac whose endpoint
# scanner (Microsoft Defender) vets each one, so startup avoids them: $OSTYPE
# instead of uname, and command output that only changes on upgrade is cached.
# cached_source NAME INPUT CMD...: source CMD's output, rerunning CMD only
# when INPUT is newer than the cache.
cached_source() {
    local cache="$XDG_CACHE_HOME/zsh/$1" input=$2
    shift 2
    if [[ ! -s "$cache" || "$input" -nt "$cache" ]]; then
        "$@" >| "$cache.$$" && mv -f "$cache.$$" "$cache" || { rm -f "$cache.$$"; return 1; }
    fi
    source "$cache"
}

# Homebrew
if [[ "$OSTYPE" == darwin* ]]; then
    brew_prefix=/opt/homebrew
else
    brew_prefix=/home/linuxbrew/.linuxbrew
fi
[[ -x "$brew_prefix/bin/brew" ]] && cached_source brew-shellenv "$brew_prefix/bin/brew"(:A) "$brew_prefix/bin/brew" shellenv
unset brew_prefix

# env.d also runs again in every nested zsh (see $ZDOTDIR/.zshenv), on top of
# the values it inherits; keep these lists from growing duplicates each time.
typeset -U PATH path
typeset -TU LD_LIBRARY_PATH ld_library_path

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
