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
if [ ! is_wsl2 ]; then
    return
fi

# Windows Subsystem for Linux
path_prepend /usr/local/cuda/bin /usr/lib/wsl/lib
path_append /mnt/c/Windows \
    /mnt/c/Windows/System32/OpenSSH \
    /mnt/c/Windows/System32/Wbem \
    /mnt/c/Windows/System32/WindowsPowerShell/v1.0 \
    /mnt/c/Windows/system32

WIN_USERNAME=$(powershell.exe '$env:UserName' | tr -d '\r\n')

path_append /mnt/c/Users/${WIN_USERNAME}/AppData/Local/Microsoft/WindowsApps

# CUDA
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/lib/wsl/lib:${LD_LIBRARY_PATH}"
export LDFLAGS="${LDFLAGS} -L/usr/lib/wsl/lib"
export CUDA_VISIBLE_DEVICES=1,0
