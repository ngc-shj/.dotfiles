# References:
# [16 Options](https://zsh.sourceforge.io/Doc/Release/Options.html)
# [19 Completion Widgets](https://zsh.sourceforge.io/Doc/Release/Completion-Widgets.html#Completion-Matching-Control)
# [20 Completion System](https://zsh.sourceforge.io/Doc/Release/Completion-System.html)
# [A Guide to the Zsh Completion With Examples](https://thevaluable.dev/zsh-completion-guide-examples/)
# [zsh zstyle](https://voidy21.hatenablog.jp/entry/20090902/1251918174)

# completion system initialization
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit -u
fi

setopt auto_param_slash     # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs            # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types           # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu            # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys      # カッコの対応などを自動的に補完
setopt auto_cd              # ディレクトリ名だけを入力した場合、cdを補完
setopt interactive_comments # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst    # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
 
setopt complete_in_word     # 語の途中でもカーソル位置で補完
setopt complete_aliases     # エイリアスの補完
setopt always_last_prompt   # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt always_to_end        # 補完後カーソルを行末に移動
 
setopt print_eight_bit      # 日本語ファイル名等8ビットを通す
setopt extended_glob        # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots             # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt pushd_ignore_dups    # 重複するディレクトリを追加しない
setopt pushd_silent         # pushd/popd時にディレクトリスタックの内容を表示しない
setopt correct_all          # 誤ったコマンドを修正する
setopt correct              # 誤ったコマンドを修正する

# 
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _extensions _complete _approximate

# Caching the Completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDOTDIR/.zcompcache"
# The Completion Menu
zstyle ':completion:*' menu select

# Formatting The Display
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
# zstyle ':completion:*:*:*:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format '%F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format '%F{red}-- no matches found --%f'

# Grouping Results
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands parameters

# Detailed List of Files and Folders
zstyle ':completion:*' file-list all

# Colorizing The Display
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Squeezing Slashes
zstyle ':completion:*' squeeze-slashes true

# Directory Stack Completion
zstyle ':completion:*' complete-options true

# Soring Matched Files
zstyle ':completion:*' file-sort name
zstyle ':completion:*' file-sort change reverse

# Completion Matching Control
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# npm completion
if [ command -v npm >/dev/null 2>&1 ]; then
    eval "npm completion" > /dev/null
fi
