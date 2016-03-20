#!/bin/sh

backup_dir="$HOME/.dotfiles_backup"
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
	if test -e $HOME/$file
	then
		echo "moving $HOME/$file to $backup_dir"
		cp -Lr $HOME/$file $backup_dir
	fi
	echo "create symlink to $dir/$file in $HOME"
	ln -sf $dir/$file $HOME
done

echo "setup vundle for vim"

mv -f $HONE/.vim $backup_dir
mkdir -p $HOME/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
echo "done"
