# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zprofile.pre.zsh"

# Load login shell specific configurations (e.g., ssh-agent)
# Note: Environment variables and PATH are now loaded in .zshenv via env.d/
if [[ -d "$ZDOTDIR/profile.d" ]]; then
    for rc in "$ZDOTDIR/profile.d"/*.(zsh|sh)(N); do
       [[ -r "$rc" ]] && builtin source "$rc" || continue
    done
fi

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zprofile.post.zsh"
