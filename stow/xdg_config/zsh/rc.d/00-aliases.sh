# Git aliases
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gr='git branch -r'
alias gplo='git pull origin'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'

# ls aliases
eval "$(gdircolors -b $XDG_CONFIG_HOME/dircolors/dircolors)"
alias ls='gls --color=auto'
alias ll='gls -l --color=auto'
alias la='gls -la --color=auto'
alias l='gls -lA --color=auto'

# grep aliases
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# nvim aliases
alias vim='nvim'
alias vi='nvim'
alias view='nvim -R'

# tmux aliases
alias tmux='tmux -2'

# python aliases
alias py='python'
alias py3='python3'
alias pip='pip3'
alias ipy='ipython'

# docker aliases
alias dc='docker-compose'
alias d='docker'    # docker is a common typo

# kubectl aliases
alias k='kubectl'