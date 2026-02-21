#!/usr/bin/env zsh

# Git aliases
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gbr='git branch -r'
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

# wget aliases
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'

# ssh aliases
(( $+commands[smart-ssh] )) && alias ssh='smart-ssh'

# tailscale aliases (macOS)
if [[ -x /Applications/Tailscale.app/Contents/MacOS/Tailscale ]]; then
  alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
  alias ts='tailscale'
  alias tss='tailscale status'
  alias tsup='tailscale up'
  alias tsdown='tailscale down'
  alias tsip='tailscale ip'
  alias tsping='tailscale ping'
fi

# claude-code aliases
if (( $+commands[claude] )); then
  local _ollama_host="http://gx10-a9c0:11434"
  alias claude-opus='unset ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN; export ANTHROPIC_API_KEY="your-api-key"; claude --model claude-opus-4-6'
  alias claude-20b='export ANTHROPIC_BASE_URL="'"${_ollama_host}"'" ANTHROPIC_AUTH_TOKEN="ollama" ANTHROPIC_API_KEY=""; claude --model gpt-oss:20b'
  alias claude-120b='export ANTHROPIC_BASE_URL="'"${_ollama_host}"'" ANTHROPIC_AUTH_TOKEN="ollama" ANTHROPIC_API_KEY=""; claude --model gpt-oss:120b'
fi
