
# WSL specific environment settings
if [ "$WSL_DISTRO_NAME" ]; then
    # SSH Agent relay
    export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
    ss -a | grep -q $SSH_AUTH_SOCK
    if [ $? -ne 0 ]; then
        rm -f $SSH_AUTH_SOCK
        (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
    fi

    return
fi

# Linux specific environment settings
if [ $(uname) = "Linux" ]; then
    # SSH Agent
    SSH_AGENT_INFO_FILE=~/.ssh/agent-info

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
fi
