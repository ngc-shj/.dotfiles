#!/bin/sh
# NVIDIA CUDA paths for Linux

# Skip if macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    return
fi

# Add NVIDIA CUDA bin if exists
if [ -d "/usr/local/cuda/bin" ]; then
    path_prepend /usr/local/cuda/bin
fi

# Add opt bin if exists
if [ -d "/opt/bin" ]; then
    path_prepend /opt/bin
fi
