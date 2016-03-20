#!/bin/sh

backup_dir="$HOME/.dotfiles_backup"
dir="$HOME/.dotfiles"
files=".zshrc .vimrc .tmux.conf .emacs .emacs.d .bin"

echo "create backup dir..."
mkdir -p $backup_dir
echo "done..."

echo "cd to $dir"
cd $dir
echo "done..."

echo "begin backup old files and setup new files..."
for file in $files; do
	if test -e $HOME/$file
	then
		echo "moving $HOME/$file to $backup_dir"
		cp -Lr $HOME/$file $backup_dir
	fi
	echo "create symlink to $dir/$file in $HOME"
	ln -sfn $dir/$file $HOME
done

echo "setup vundle for vim"
if test ! -d $HOME/.vim/bundle/Vundle.vim; then
	mkdir -p $HOME/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
echo "done"
