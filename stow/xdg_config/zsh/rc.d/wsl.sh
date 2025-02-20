# WSL-specific environment settings
if [ -z "$WSL_DISTRO_NAME" ]; then
    return
fi

alias open="/mnt/c/Windows/explorer.exe"
