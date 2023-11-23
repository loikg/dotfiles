#!/bin/bash

configPath="$HOME/.config/alacritty/alacritty.yml"
lightTheme=catppuccin-latte
darkTheme=catppuccin-mocha

grep -q $lightTheme $configPath && \
    gsed -i --follow-symlinks "s/$lightTheme/$darkTheme/" $configPath && \
    exit

grep -q $darkTheme $configPath && \
    gsed -i --follow-symlinks "s/$darkTheme/$lightTheme/" $configPath
