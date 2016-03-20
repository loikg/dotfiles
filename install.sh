#!/bin/sh

backup_dir="$HOME/.dotfile_backup"
dir="$HOME/.dotfiles"
files=".zshrc .vimrc .tmux.conf"

echo "create backup dir..."
mkdir -p $backup_dir
echo "done..."

echo "cd to $dir"
cd $dir
echo "done..."

echo "begin backup old files and setup new files..."
for file in $files; do
	if -e $HOME/$file
	then
		echo "moving $HOME/$file to $backup_dir"
		mv -f $HOME/$file $backup_dir
	fi
	echo "create symlink to $dir/$file in $HOME"
	ln -sf $dir/$file $HOME
done
echo "done..."

echo "sourcing new zsh file"
source $HOME/.zshrc
