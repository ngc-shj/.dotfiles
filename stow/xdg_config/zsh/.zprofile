# Load login shell specific configurations (e.g., ssh-agent)
# Note: Environment variables and PATH are now loaded in .zshenv via env.d/
if [[ -d "$ZDOTDIR/profile.d" ]]; then
    for rc in "$ZDOTDIR/profile.d"/*.(zsh|sh)(N); do
       [[ -r "$rc" ]] && builtin source "$rc" || continue
    done
fi

