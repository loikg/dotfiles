#!/bin/bash

stowDotConfigPackage() {
    mkdir -p $HOME/.config/$1
    stow --adopt --dir=config --target=$HOME/.config/$1  --verbose=1 $1
}

installOnLinux() {
	stowDotConfigPackage "i3"
	stowDotConfigPackage "tmux"
	stowDotConfigPackage "alacritty"
	stowDotConfigPackage "nvim"
	stowDotConfigPackage "fish"
	stowDotConfigPackage "git"
    stow starship
    stow zsh
    stow wezterm
}

installOnMacos() {
	stowDotConfigPackage "tmux"
	stowDotConfigPackage "alacritty"
	stowDotConfigPackage "nvim"
	stowDotConfigPackage "fish"
	stowDotConfigPackage "git"
	stowDotConfigPackage "yabai"
	stowDotConfigPackage "skhd"
    stow starship
    stow zsh
    stow wezterm
}


case "$1" in
        macos)
		installOnMacos
          	;;
        linux)
		installOnLinux
          	;;
        *)
       echo "Incorrect input provided"
esac
