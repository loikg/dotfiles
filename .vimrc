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
Plugin 'edkolev/tmuxline.vim'
Plugin 'loikg/vim-epitech'
Plugin 'scrooloose/syntastic'

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

" vim-epitech config
let g:epi_login = 'gaonac_l'
let g:epi_name = 'Loik Gaonach'
let g:epi_mode_emacs = 1
"let g:epi_mode_auto = 1 " auto indent epitech style when header

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" tab size
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4

" Setup some default ignores
 let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
    \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
    \}

" syntastic plug
 set statusline+=%#warningmsg#
 set statusline+=%{SyntasticStatuslineFlag()}
 set statusline+=%*

 let g:syntastic_always_populate_loc_list = 1
 let g:syntastic_auto_loc_list = 1
 let g:syntastic_check_on_open = 1
 let g:syntastic_check_on_wq = 0
