#!/usr/bin/env zsh
# CUDA version switcher for easy switching between CUDA versions
# Only available on Linux (WSL2)

# Skip if macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    return
fi

# Function to run command with specific CUDA version
# Usage: with-cuda <version> <command> [args...]
# Example: with-cuda 12 nvcc --version
with-cuda() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: with-cuda <version> <command> [args...]" >&2
        echo "Example: with-cuda 12 nvcc --version" >&2
        return 1
    fi

    local cuda_version="$1"
    shift

    local cuda_path="/usr/local/cuda-${cuda_version}"

    if [[ ! -d "$cuda_path" ]]; then
        echo "Error: CUDA ${cuda_version} not found at ${cuda_path}" >&2
        return 1
    fi

    CUDA_HOME="$cuda_path" \
    PATH="${cuda_path}/bin:$PATH" \
    LD_LIBRARY_PATH="${cuda_path}/lib64:${LD_LIBRARY_PATH}" \
    "$@"
}

# Convenience aliases for common CUDA versions
alias with-cuda11='with-cuda 11'
alias with-cuda12='with-cuda 12'
alias with-cuda13='with-cuda 13'

# Function to switch CUDA version for current shell session
# Usage: use-cuda <version>
# Example: use-cuda 12
use-cuda() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: use-cuda <version>" >&2
        echo "Example: use-cuda 12" >&2
        return 1
    fi

    local cuda_version="$1"
    local cuda_path="/usr/local/cuda-${cuda_version}"

    if [[ ! -d "$cuda_path" ]]; then
        echo "Error: CUDA ${cuda_version} not found at ${cuda_path}" >&2
        return 1
    fi

    # Remove old CUDA paths from PATH and LD_LIBRARY_PATH
    PATH=$(echo "$PATH" | tr ':' '\n' | grep -v '/cuda' | tr '\n' ':' | sed 's/:$//')
    LD_LIBRARY_PATH=$(echo "$LD_LIBRARY_PATH" | tr ':' '\n' | grep -v '/cuda' | tr '\n' ':' | sed 's/:$//')

    # Set new CUDA environment
    export CUDA_HOME="$cuda_path"
    export PATH="${cuda_path}/bin:$PATH"
    export LD_LIBRARY_PATH="${cuda_path}/lib64:${LD_LIBRARY_PATH}"

    echo "Switched to CUDA ${cuda_version}"
    echo "CUDA_HOME: $CUDA_HOME"

    # Verify installation if nvcc is available
    if command -v nvcc &>/dev/null; then
        nvcc --version | head -n 4
    fi
}

# Convenience aliases for switching CUDA versions
alias use-cuda11='use-cuda 11'
alias use-cuda12='use-cuda 12'
alias use-cuda13='use-cuda 13'

# Function to show current CUDA version
cuda-version() {
    if [[ -n "$CUDA_HOME" ]]; then
        echo "CUDA_HOME: $CUDA_HOME"
    else
        echo "CUDA_HOME is not set"
    fi

    if command -v nvcc &>/dev/null; then
        echo ""
        nvcc --version | head -n 4
    else
        echo "nvcc not found in PATH"
    fi
}
