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

echo "setup vim-plug for vim"

if test ! -f $HOME/.vim/autoload/plug.vim; then

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

fi

echo "done"

echo "setup tpm (tmux plugin manager)"
if test ! -d $HOME/.tmux/plugins/tpm/; then
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi
