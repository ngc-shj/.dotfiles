
# Homebrew
if [ -d "/opt/homebrew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Golang
if [ -d "$HOME/go" ]; then
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
fi

# nvm
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi

# cargo
if [ -d "$HOME/.cargo" ]; then
    . $HOME/.cargo/env
fi

# modular
if [ -d "$HOME/.modulear" ]; then
    export MODULAR_HOME="$HOME/.modular"
    export MOJO_PYTHON_LIBRARY="/usr/lib/x86_64-linux-gnu/libpython3.10.so"
fi
