set nocompatible
filetype off

set rtp+=$HOME/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'

call vundle#end()
filetype plugin indent on

" enable syntax highlighting
syntax on

" enable line number
set number

" enable mouse
set mouse=a

" theme configuration
set background=dark
colorscheme solarized
set t_Co=16
let g:solarized_termcolors=16

" airline configuration
let g:airline_theme='solarized'
