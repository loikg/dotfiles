if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)
end

# Run ssh-agent
if test -z (pgrep ssh-agent)
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    eval (ssh-add ~/.ssh/id_github)
end

export AWS_PROFILE=epitech

# Rust
fish_add_path "$HOME/.cargo/bin"

# pnpm
set -gx PNPM_HOME "/home/loik/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

# set editor
set -gx EDITOR nvim
set -gx GOPATH "$HOME/go"

fish_add_path "$GOPATH/bin"
