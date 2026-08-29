
# WSL specific environment settings
if [ "$WSL_DISTRO_NAME" ]; then
    # SSH Agent relay
    export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
    ss -a | grep -q $SSH_AUTH_SOCK
    if [ $? -ne 0 ]; then
        rm -f $SSH_AUTH_SOCK
        # socat outlives this shell, so detach all three fds, not just the two
        # that were noisy: an inherited stdin leaves the daemon holding the
        # login shell's terminal open for as long as it runs. npiperelay is
        # unaffected either way -- socat hands it the accepted socket as fd 0.
        (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) </dev/null >/dev/null 2>&1
    fi

    return
fi

# macOS specific environment settings
if [ $(uname) = "Darwin" ]; then
    # GUI terminals inherit SSH_AUTH_SOCK from launchd and `ssh -A` brings its
    # own; an ssh login to this machine gets neither, so start (or reuse) an
    # agent only in that case. `ssh-add -l` exits 2 when no agent is reachable,
    # 1 when one is reachable but holds no keys.
    ssh-add -l >&/dev/null
    if [ $? -eq 2 ]; then
        SSH_AGENT_INFO_FILE=~/.ssh/agent-info

        if [ -f "$SSH_AGENT_INFO_FILE" ]; then
            source "$SSH_AGENT_INFO_FILE" >/dev/null
        fi

        ssh-add -l >&/dev/null
        if [ $? -eq 2 ]; then
            (umask 077; ssh-agent > "$SSH_AGENT_INFO_FILE")
            source "$SSH_AGENT_INFO_FILE" >/dev/null
        fi

        # Keys whose passphrase lives in the login Keychain load without a
        # prompt; anything never added with `ssh-add --apple-use-keychain`
        # still asks at connect time.
        ssh-add --apple-load-keychain >&/dev/null
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
