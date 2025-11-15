# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/profile.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/profile.pre.bash"

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

if [ -d "$XDG_CONFIG_HOME/zsh/profile.d" ]; then
    for rc in "$XDG_CONFIG_HOME/zsh/profile.d/"*.sh; do
        [ -r "$rc" ] && . "$rc"
    done
fi

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/profile.post.bash" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/profile.post.bash"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/noguchi/.lmstudio/bin"
# End of LM Studio CLI section

