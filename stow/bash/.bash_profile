#. bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -d "$XDG_CONFIG_HOME/bash/profile.d" ]; then
    for rc in "$XDG_CONFIG_HOME/bash/profile.d/"*.sh; do
        [ -r "$rc" ] && . "$rc"
    done
fi
