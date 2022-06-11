#!/bin/bash

stowDotConfigPackage() {
    mkdir -p $HOME/.config/$1
    stow --dir=config --target=$HOME/.config/$1  --verbose=1 $1
}

installOnLinux() {
	stowDotConfigPackage "i3"
	stowDotConfigPackage "tmux"
	stowDotConfigPackage "alacritty"
	stowDotConfigPackage "nvim"
	stowDotConfigPackage "fish"
	stowDotConfigPackage "omf"
}

installOnMacos() {
	stowDotConfigPackage "tmux"
	stowDotConfigPackage "alacritty"
	stowDotConfigPackage "nvim"
	stowDotConfigPackage "fish"
	stowDotConfigPackage "omf"
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
