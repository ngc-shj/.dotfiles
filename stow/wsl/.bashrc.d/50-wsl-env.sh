# CUDA
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/lib/wsl/lib:${LD_LIBRARY_PATH}"
export LDFLAGS="${LDFLAGS} -L/usr/lib/wsl/lib"
export CUDA_VISIBLE_DEVICES=1,0

# Windows Subsystem for Linux
path_prepend $HOME/bin /usr/local/cuda/bin /usr/lib/wsl/lib
path_append /mnt/c/Windows \
    /mnt/c/Windows/System32/OpenSSH \
    /mnt/c/Windows/System32/Wbem \
    /mnt/c/Windows/System32/WindowsPowerShell/v1.0 \
    /mnt/c/Windows/system32

WIN_USERNAME=$(powershell.exe '$env:UserName' | tr -d '\r\n')

path_append /mnt/c/Users/${WIN_USERNAME}/AppData/Local/Microsoft/WindowsApps
