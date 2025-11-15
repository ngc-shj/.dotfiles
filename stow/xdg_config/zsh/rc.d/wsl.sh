#!/bin/bash

# WSL-specific RC settings (interactive shell functions)
# Check if is_wsl2 function exists and we're on WSL2
if ! type is_wsl2 &>/dev/null || ! is_wsl2; then
    return
fi

open() {
    if [ $# -eq 0 ]; then
        # Open current directory if no arguments provided
        /mnt/c/Windows/explorer.exe "$(wslpath -w .)"
    else
        # Convert WSL path to Windows path before passing
        local target_path="$1"

        # Convert relative path to absolute path if needed
        if [[ ! "$target_path" = /* ]]; then
            target_path="$(realpath "$target_path")"
        fi

        # Convert WSL path to Windows path
        local windows_path="$(wslpath -w "$target_path")"
        /mnt/c/Windows/explorer.exe "$windows_path"
    fi
}
