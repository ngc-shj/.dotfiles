#. bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
if [ "$(uname)" == "Darwin" ]; then
    [ -f ~/.bash_profile_macos ] && source ~/.bash_profile_macos
fi

if [ -f /etc/redhat-release ]; then
    [ -f ~/.bash_profile_rhel ] && source ~/.bash_profile_rhel
fi

if [ -f /etc/lsb-release ]; then
    [ -f ~/.bash_profile_ubuntu ] && source ~/.bash_profile_ubuntu
fi

if grep -qi microsoft /proc/version; then
    [ -f ~/.bash_profile_wsl ] && source ~/.bash_profile_wsl
fi
