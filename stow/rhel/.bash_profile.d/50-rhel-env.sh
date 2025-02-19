# SSH Agent
SSH_AGENT_INFO=~/.ssh-agent-info

echo -n "ssh-agent: "
source $SSH_AGENT_INFO
ssh-add -l >&/dev/null
if [ $? == 2 ] ; then
    echo -n "ssh-agent: restart...."
    ssh-agent > $SSH_AGENT_INFO
    source $SSH_AGENT_INFO
fi

if ssh-add -l >&/dev/null ; then
    echo "ssh-agent: Identity is already stored."
else
    ssh-add
fi

path_prepend /usr/local/sbin
