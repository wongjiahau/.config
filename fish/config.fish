fish_default_key_bindings
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /usr/local/go/bin $PATH
set -gx PATH $HOME/go/bin $PATH
set -gx PATH $GOPATH/bin $PATH
set -gx EDITOR ki

set -x PATH ~/npm/bin:$PATH

# This is needed to solve Powerline not being rendered inside tmux
# Refer https://github.com/gpakosz/.tmux/issues/171#issuecomment-426048355
set -gx LC_ALL en_US.UTF-8

fish_default_key_bindings

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

# pnpm
set -gx PNPM_HOME /Users/wongjiahau/Library/pnpm
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# Setting PATH for Python 3.10
# The original version is saved in /Users/wongjiahau/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"

zoxide init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Set up fzf key bindings
fzf --fish | source

# Setting up nix-shell
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    set -gx PATH /nix/var/nix/profiles/default/bin $PATH
    set -gx NIX_PATH $HOME/.nix-defexpr/channels
    set -gx NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"
    set -gx NIX_SSL_CERT_FILE /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt
    set -gx PATH $HOME/.nix-profile/bin $PATH
end


direnv hook fish | source

