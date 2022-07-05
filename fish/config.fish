fish_default_key_bindings
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -x PATH ~/npm/bin:$PATH

# This is needed to solve Powerline not being rendered inside tmux
# Refer https://github.com/gpakosz/.tmux/issues/171#issuecomment-426048355
set -gx LC_ALL en_US.UTF-8


# Solve SSH cannot open connection issue
# Refer https://gist.github.com/gerbsen/5fd8aa0fde87ac7a2cae
setenv SSH_ENV $HOME/.ssh/environment
function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' >$SSH_ENV
    echo succeeded
    chmod 600 $SSH_ENV
    . $SSH_ENV >/dev/null
    ssh-add
end
function test_identities
    ssh-add -l | grep "The agent has no identities" >/dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end
if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent >/dev/null
    if [ $status -eq 0 ]
        test_identities
    end
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV >/dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent >/dev/null
    if [ $status -eq 0 ]
        test_identities
    else
        start_agent
    end
end
