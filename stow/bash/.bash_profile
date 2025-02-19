#. bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -d "$HOME/.bash_profile.d" ]; then
    for rc in "$HOME/.bash_profile.d/"*.sh; do
        [ -r "$rc" ] && . "$rc"
    done
fi

# User specific environment and startup programs
if [ -f ~/.bash_profile.local ]; then
    . ~/.bash_profile.local
fi
