
# WSL specific environment settings
if [ "$WSL_DISTRO_NAME" ]; then
    # The relay is a Windows binary; with interop off it would listen fine
    # and then fail every agent request, so leave SSH_AUTH_SOCK alone.
    autoload -Uz "$ZDOTDIR"/functions/wsl_{interop_enabled,require_interop}
    if ! wsl_require_interop "ssh-agent relay (npiperelay.exe)"; then
        return
    fi

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
if [[ "$OSTYPE" == darwin* ]]; then
    # GUI terminals inherit SSH_AUTH_SOCK from launchd and `ssh -A` brings its
    # own; an ssh login to this machine gets neither, so start (or reuse) an
    # agent only in that case. A live socket and agent pid stand in for
    # `ssh-add -l`: every exec at login can stall on the endpoint scanner
    # (see env.d/00-paths.zsh), so the usual paths here run none.
    if [[ ! -S "$SSH_AUTH_SOCK" ]]; then
        SSH_AGENT_INFO_FILE=~/.ssh/agent-info

        if [[ -f "$SSH_AGENT_INFO_FILE" ]]; then
            source "$SSH_AGENT_INFO_FILE" >/dev/null
        fi

        if [[ ! -S "$SSH_AUTH_SOCK" ]] || ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
            (umask 077; ssh-agent > "$SSH_AGENT_INFO_FILE")
            source "$SSH_AGENT_INFO_FILE" >/dev/null

            # Keys whose passphrase lives in the login Keychain load without a
            # prompt; anything never added with `ssh-add --apple-use-keychain`
            # still asks at connect time. A reused agent got them at its start.
            ssh-add --apple-load-keychain >&/dev/null
        fi
    fi

    return
fi

# Linux specific environment settings
if [[ "$OSTYPE" == linux* ]]; then
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
