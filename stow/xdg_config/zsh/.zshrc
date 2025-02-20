# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

zshrc_d="$ZDOTDIR/rc.d"
if [ -d "${zshrc_d}" ]; then
    for rc in "${zshrc_d}"/*; do
        [ -r "$rc" ] && . "$rc"
    done
fi

unset zshrc_d

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
