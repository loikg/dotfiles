if status is-interactive
    if test (uname) = Darwin
        eval (/opt/homebrew/bin/brew shellenv)
    end
end

# Run ssh-agent
if test -z (pgrep ssh-agent)
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    eval (ssh-add ~/.ssh/id_github)
end

set -gx EDITOR nvim

# Rust
fish_add_path "$HOME/.cargo/bin"

# Go
switch (uname)
    case Darwin
        set -gx GOPATH "$HOME/go"
        fish_add_path "$GOPATH/bin"
    case '*'
        fish_add_path /usr/local/go/bin
end

# Volta
set -gx VOLTA_FEATURE_PNPM "1"
set -gx VOLTA_HOME "$HOME/.volta"
fish_add_path "$VOLTA_HOME/bin"

alias tf="terraform"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
