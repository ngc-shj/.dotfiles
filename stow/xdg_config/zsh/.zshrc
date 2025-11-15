# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Lazy load conda to improve shell startup time
# Conda initialization is deferred until first use of conda command
if [[ -f "$ZDOTDIR/env.d/miniconda3.sh" ]]; then
    if [[ -f "$HOME/miniconda3/bin/conda" ]]; then
        conda() {
            unfunction conda
            source "$ZDOTDIR/env.d/miniconda3.sh"
            conda "$@"
        }
    fi
fi

# Lazy load nvm to improve shell startup time
# NVM initialization is deferred until first use of nvm/node/npm commands
if [[ -f "$ZDOTDIR/env.d/nvm.sh" ]]; then
    if [[ -d "$XDG_DATA_HOME/nvm" ]]; then
        nvm() {
            unfunction nvm node npm
            source "$ZDOTDIR/env.d/nvm.sh"
            nvm "$@"
        }

        node() {
            unfunction nvm node npm
            source "$ZDOTDIR/env.d/nvm.sh"
            node "$@"
        }

        npm() {
            unfunction nvm node npm
            source "$ZDOTDIR/env.d/nvm.sh"
            npm "$@"
        }
    fi
fi

# Load interactive shell configurations
if [[ -d "$ZDOTDIR/rc.d" ]]; then
    for rc in "$ZDOTDIR/rc.d"/*.(zsh|sh)(N); do
       [[ -r "$rc" ]] && builtin source "$rc"
    done
fi

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
