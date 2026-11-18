# Most reliable WSL2 detection method
# Check /proc/version for Microsoft WSL2 signature

is_wsl2() {
    # Check if /proc/version contains Microsoft and WSL2. Read it with zsh,
    # not grep: this runs in every shell on every OS (see env.d/00-paths.zsh)
    [[ -r /proc/version ]] || return 1
    local version=${(L)"$(</proc/version)"}
    [[ $version == *microsoft*wsl2* || $version == *wsl2*microsoft* ]]
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

# Autoloaded from an absolute path so profile.d and rc.d can declare their own
# dependency on these instead of relying on env.d having run first.
autoload -Uz "$ZDOTDIR"/functions/wsl_{interop_enabled,require_interop}

# env.d runs for every zsh, so launching a .exe here costs every shell a
# round trip through interop. The Windows user name never changes; cache it.
WIN_USERNAME_CACHE="$XDG_CACHE_HOME/wsl/win-username"
if [[ -s "$WIN_USERNAME_CACHE" ]]; then
    WIN_USERNAME=$(<"$WIN_USERNAME_CACHE")
elif wsl_interop_enabled; then
    # Keep stdin away from the interop relay: a Windows binary launched here
    # inherits this shell's stdin and drains whatever is buffered in it. Under
    # sshd that pipe carries the session payload, so an unredirected .exe
    # silently eats the head of every scp/rsync/tar stream into this box.
    WIN_USERNAME=$(powershell.exe '$env:UserName' </dev/null 2>/dev/null | tr -d '\r\n')
    if [[ -n "$WIN_USERNAME" ]]; then
        mkdir -p "${WIN_USERNAME_CACHE:h}"
        print -r -- "$WIN_USERNAME" >"$WIN_USERNAME_CACHE"
    fi
elif [[ -o interactive ]]; then
    # Only interactive shells hear about it: scp and `ssh host cmd` would
    # otherwise carry this line on stderr. Seeding the cache by hand fixes it.
    wsl_require_interop "Windows user name lookup (WindowsApps not on PATH; write it to $WIN_USERNAME_CACHE)"
fi
unset WIN_USERNAME_CACHE

if [[ -n "$WIN_USERNAME" ]]; then
    path_append /mnt/c/Users/${WIN_USERNAME}/AppData/Local/Microsoft/WindowsApps
fi

# CUDA
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
ld_library_path=(/usr/local/cuda/lib64 /usr/lib/wsl/lib $ld_library_path)
export LD_LIBRARY_PATH
[[ " $LDFLAGS " == *" -L/usr/lib/wsl/lib "* ]] || export LDFLAGS="${LDFLAGS:+$LDFLAGS }-L/usr/lib/wsl/lib"
export CUDA_DEVICE_ORDER="PCI_BUS_ID"
export CUDA_VISIBLE_DEVICES=1,0
