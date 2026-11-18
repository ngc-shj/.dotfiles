# Most reliable WSL2 detection method
# Check /proc/version for Microsoft WSL2 signature

is_wsl2() {
    # Check if /proc/version contains Microsoft and WSL2
    if grep -qi "microsoft.*wsl2\|wsl2.*microsoft" /proc/version 2>/dev/null; then
        return 0  # WSL2 detected
    else
        return 1  # Not WSL2
    fi
}

# WSL-specific environment settings
if ! is_wsl2; then
    return
fi

# Windows Subsystem for Linux
# Note: NVIDIA CUDA bin paths are handled by nv_path.sh
path_prepend /usr/lib/wsl/lib
path_append /mnt/c/Windows \
    /mnt/c/Windows/System32/OpenSSH \
    /mnt/c/Windows/System32/Wbem \
    /mnt/c/Windows/System32/WindowsPowerShell/v1.0 \
    /mnt/c/Windows/system32

# env.d runs for every zsh, so launching a .exe here costs every shell a
# round trip through interop. The Windows user name never changes; cache it.
# Under sshd WSL_INTEROP is unset and the interop callback never connects:
# powershell.exe blocks ~10s (UtilAcceptVsock: accept4 failed 110) and
# returns nothing, so without a cache an ssh session skips the lookup.
WIN_USERNAME_CACHE="$XDG_CACHE_HOME/wsl/win-username"
if [[ -s "$WIN_USERNAME_CACHE" ]]; then
    WIN_USERNAME=$(<"$WIN_USERNAME_CACHE")
elif [[ -z "$SSH_CONNECTION" ]]; then
    # Keep stdin away from the interop relay: a Windows binary launched here
    # inherits this shell's stdin and drains whatever is buffered in it. Under
    # sshd that pipe carries the session payload, so an unredirected .exe
    # silently eats the head of every scp/rsync/tar stream into this box.
    WIN_USERNAME=$(powershell.exe '$env:UserName' </dev/null 2>/dev/null | tr -d '\r\n')
    if [[ -n "$WIN_USERNAME" ]]; then
        mkdir -p "${WIN_USERNAME_CACHE:h}"
        print -r -- "$WIN_USERNAME" >"$WIN_USERNAME_CACHE"
    fi
fi
unset WIN_USERNAME_CACHE

if [[ -n "$WIN_USERNAME" ]]; then
    path_append /mnt/c/Users/${WIN_USERNAME}/AppData/Local/Microsoft/WindowsApps
fi

# CUDA
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/lib/wsl/lib:${LD_LIBRARY_PATH}"
export LDFLAGS="${LDFLAGS} -L/usr/lib/wsl/lib"
export CUDA_DEVICE_ORDER="PCI_BUS_ID"
export CUDA_VISIBLE_DEVICES=1,0
