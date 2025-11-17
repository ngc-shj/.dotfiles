#!/bin/sh
# Restore PATH priority on macOS after /etc/zprofile
#
# Problem:
#   macOS /etc/zprofile runs /usr/libexec/path_helper which reorders PATH,
#   moving custom paths (from env.d) to the end after system paths.
#
# Solution:
#   .zshenv saves PATH after env.d loading in ZSHENV_PATH
#   This script restores that PATH to maintain our preferred order
#
# Execution order:
#   1. .zshenv loads env.d/* → PATH has custom paths first
#   2. .zshenv saves PATH to ZSHENV_PATH
#   3. /etc/zprofile runs path_helper → PATH reordered (system paths first)
#   4. .zprofile loads profile.d/* → This script restores ZSHENV_PATH

# Only run on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    return
fi

# Restore PATH from .zshenv if available
if [[ -n "$ZSHENV_PATH" ]]; then
    export PATH="$ZSHENV_PATH"
    unset ZSHENV_PATH
fi
