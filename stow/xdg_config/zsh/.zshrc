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
# env.d/nvm.sh already puts the default node on PATH, so only the nvm
# command itself needs loading on first use
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    nvm() {
        unfunction nvm
        source "$NVM_DIR/nvm.sh"
        nvm "$@"
    }
fi

# Load interactive shell configurations
if [[ -d "$ZDOTDIR/rc.d" ]]; then
    for rc in "$ZDOTDIR/rc.d"/*.(zsh|sh)(N); do
       [[ -r "$rc" ]] && builtin source "$rc" || continue
    done
fi

