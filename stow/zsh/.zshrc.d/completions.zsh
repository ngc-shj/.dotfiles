# References:
# [16 Options](https://zsh.sourceforge.io/Doc/Release/Options.html)
# [19 Completion Widgets](https://zsh.sourceforge.io/Doc/Release/Completion-Widgets.html#Completion-Matching-Control)
# [20 Completion System](https://zsh.sourceforge.io/Doc/Release/Completion-System.html)
# [A Guide to the Zsh Completion With Examples](https://thevaluable.dev/zsh-completion-guide-examples/)

# ------------------------------------------------------------------------
# Basis
# ------------------------------------------------------------------------

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

setopt always_to_end
setopt auto_menu
setopt auto_param_slash
setopt auto_cd

# メニュー型補完を有効化
zstyle ':completion:*:*:*:*:*' menu select

# Completer
zstyle ':completion:*' completer _complete _approximate

# マッチングのルール
# m:{a-zA-Z}={A-Za-z}m:{a-zA-Z}={A-Za-z} -> 大文字、小文字を無視して補完: 
# r:|[._-]=* r:|=*                       -> マッチするものがなければ、「._-」を区切り文字としてFuzzy-matching:  
# l:|=* r:|=*                            -> それでもマッチしなければ、(調査中): 
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Directory Stackを使うコマンド(cd/chdir/pushd)でも、'-'入力時にオプションを補完
zstyle ':completion:*' complete-options true

# (たぶん)コマンドの補完関数にdescriptionが設定されていなかった場合に、自動推論する
# auto-description
# If set, this style’s value will be used as the description for options that are not described by the completion functions, 
# but that have exactly one argument. The sequence ‘%d’ in the value will be replaced by the description for this argument. 
# Depending on personal preferences, it may be useful to set this style to something like ‘specify: %d’. Note that this may not work for some commands.
zstyle ':completion:*:options' auto-description '%d'

# ------------------------------------------------------------------------
# Group
# ------------------------------------------------------------------------

# 補完候補をグループ別に表示
# これがないと、全てのグループ名のあとに全候補が表示されてしまいグループ表示が意味をなさない
zstyle ':completion:*' group-name ''

# グループの表示順序
zstyle ':completion:*:*:-command-:*:*' group-order builtins functions commands parameters aliases

# ------------------------------------------------------------------------
# Format
# ------------------------------------------------------------------------

# グループ名
zstyle ':completion:*:*:*:*:descriptions' format ' %F{yellow}-- %d --%f'

# 警告メッセージ
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

# Fuzzy-matchingでヒットした結果。completerに_approximateが指定されている(=Fuzzy-matching有効化)場合のみ利用可
zstyle ':completion:*:*:*:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'

# messageがどこを指しているのかイマイチよくわからないがとりあえず設定
# FIXME: どこのことかわかったらコメント追記
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'

# 補完候補をLS_COLORSで表示
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# ------------------------------------------------------------------------
# Fuzzy matching
# ------------------------------------------------------------------------

# あいまいさの許容値
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# ------------------------------------------------------------------------
# Cache
# ------------------------------------------------------------------------

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"

# ------------------------------------------------------------------------
# npm
# ------------------------------------------------------------------------

eval "npm completion" > /dev/null 
# eval "pnpm completion zsh" > /dev/null
