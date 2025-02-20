# SSH Agent
SSH_AGENT_INFO_FILE=~/.ssh/.ssh-agent-info

echo -n "ssh-agent: "
if [ -f "$SSH_AGENT_INFO_FILE" ]; then
    source "$SSH_AGENT_INFO_FILE"
    ssh-add -l >&/dev/null
    if [ $? -eq 2 ]; then
        echo -n "ssh-agent: restart...."
        ssh-agent > "$SSH_AGENT_INFO_FILE"
        source "$SSH_AGENT_INFO_FILE"
    fi
else
    echo -n "ssh-agent: start...."
    ssh-agent > "$SSH_AGENT_INFO_FILE"
    source "$SSH_AGENT_INFO_FILE"
fi

if ssh-add -l >&/dev/null; then
    echo "ssh-agent: Identity is already stored."
else
    ssh-add
fi

path_prepend /usr/local/sbin
