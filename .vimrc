"
"	.VIMRC
"	Config file for vim
"	use vim-plug for plugin managment
"

" define leader
let mapleader = ","

" enable syntax highlighting
syntax on

" enable line number
set number
set numberwidth=3

" enable mouse
set mouse=a

" tab size
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4

" define shortcut for buffers
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'				"side bar file explorer
Plug 'kien/ctrlp.vim'					"fuzzy loader
Plug 'altercation/vim-colors-solarized' "color theme
Plug 'vim-airline/vim-airline'			"status bar
Plug 'vim-airline/vim-airline-themes'	"status bar theme
Plug 'tpope/vim-fugitive'				"git integration
Plug 'edkolev/tmuxline.vim'				"tmux status bar theme ^^
Plug 'loikg/vim-epitech'				"epitech plugin
Plug 'scrooloose/syntastic'				"syntax checker
Plug 'scrooloose/nerdcommenter'			"quicly comment
Plug 'airblade/vim-gitgutter'			"show modified line in gutter
Plug 'rking/ag.vim'						"search through project

call plug#end()

" theme configuration
set background=dark
colorscheme solarized
set t_Co=16
let g:solarized_termcolors=16

" airline configuration
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1 " Show buffer list
let g:airline#extensions#tabline#fnamemod = ':t' " Show filename only

" vim-epitech config
let g:epi_login = 'gaonac_l'
let g:epi_name = 'Loik Gaonach'
let g:epi_mode_emacs = 1
let g:header_update = 0

" Ctrl-p config
" ignore some folders
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
 let g:syntastic_cpp_compiler_options = '-std=c++11'
 let g:syntastic_cpp_config_file = '.vim_syntastic'
