# ~/.zshenv exports ZDOTDIR, so a nested zsh (tmux, `zsh -l`, a shell a
# script starts) reads this file instead of ~/.zshenv. Hand it back so env.d
# runs there too: exported variables survive into the child, but the
# functions env.d defines (path_append, is_wsl2, ...) do not.
source "$HOME/.zshenv"
