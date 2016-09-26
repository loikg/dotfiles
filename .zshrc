# Path to your oh-my-zsh installation.

export ZSH=$HOME/.oh-my-zsh

# Theme

ZSH_THEME="gentoo"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Plugins
plugins=(git sudo web-search zsh-autosuggestions)

# User configuration

  export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Variables
export LANG=en_US.UTF-8
export EDITOR="vim"
export PAGDER="most"
export HOSTTYPE="x86_64"
#export TERM="xterm-256color"

#Alias

# Epitech
alias blih="blih -u gaonac_l"

# git
alias gts="git status"
alias gtpm="git push origin master"
alias gtc="git commit -m"
alias gA="git add -A"
alias ga="git add"

# make
alias mk="make"
alias mkr="mk re"
alias mkf="mk fclean"
alias mkc="mk clean"

#ping
alias pgg="ping 8.8.8.8"
alias pgh="ping 192.168.1.1"

# emacs
alias ne="emacs -nw"

# other
alias open="nautilus"
alias czip="zip -r"

alias g++w="g++ -W -Wextra -Werror -Wall"
alias gccw="gcc -W -Wextra -Wall - Werror"

alias cl="clean-tmp"
alias src="source ~/.zshrc"

alias lc="i3lock -i ~/Pictures/Wallpapers/triangle-minimalism-colorful-2880x1800.png"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
