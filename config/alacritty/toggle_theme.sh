#!/bin/bash

alacrittyConfigPath="$HOME/.config/alacritty/alacritty.toml"
alacrittyLightTheme=catppuccin-latte
alacrittyDarkTheme=catppuccin-mocha
tmuxConfigPath="$HOME/.config/tmux/tmux.conf"
tmuxLightTheme=latte
tmuxDarkTheme=mocha
fishLightTheme="Catppuccin Latte"
fishDarkTheme="Catppuccin Mocha"

theme=$1

if [ "$theme" == "dark" ]; then
    gsed -i --follow-symlinks "s/$alacrittyLightTheme/$alacrittyDarkTheme/" $alacrittyConfigPath && \
    gsed -i --follow-symlinks "s/$tmuxLightTheme/$tmuxDarkTheme/" $tmuxConfigPath && \
    tmux source ~/.config/tmux/tmux.conf && \
    echo "y" | fish -c "fish_config theme save \"$fishDarkTheme\"" && \
    exit
else 
    gsed -i --follow-symlinks "s/$alacrittyDarkTheme/$alacrittyLightTheme/" $alacrittyConfigPath && \
    gsed -i --follow-symlinks "s/$tmuxDarkTheme/$tmuxLightTheme/" $tmuxConfigPath && \
    tmux source ~/.config/tmux/tmux.conf && \
    echo "y" | fish -c "fish_config theme save \"$fishLightTheme\"" && \
    exit
fi
