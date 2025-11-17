#!/bin/sh
# NVIDIA CUDA paths for Linux

# Skip if macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    return
fi

# Add opt bin if exists (add first so CUDA takes precedence)
if [ -d "/opt/bin" ]; then
    path_prepend /opt/bin
fi

# Set default CUDA environment (uses symlink /usr/local/cuda)
# Added after /opt/bin so it appears earlier in PATH
if [ -d "/usr/local/cuda" ]; then
    export CUDA_HOME="/usr/local/cuda"
    export LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"
    path_prepend /usr/local/cuda/bin
fi
