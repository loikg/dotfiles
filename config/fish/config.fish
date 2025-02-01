if status is-interactive
    if test (uname) = Darwin
        eval (/opt/homebrew/bin/brew shellenv)
    end
    atuin init --disable-up-arrow fish | source
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

# set default fish key bindings to vi mode
set -g fish_key_bindings fish_vi_key_bindings

# Rust
source "$HOME/.cargo/env.fish"

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

abbr -a tc "sesh connect (sesh list -t | fzf)"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# setup starship
starship init fish | source

# setup zoxide
zoxide init --cmd cd fish | source
