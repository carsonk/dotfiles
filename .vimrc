execute pathogen#infect()
syntax enable
filetype plugin indent on

set mouse=a

colorscheme molokai
set tabstop=4
set softtabstop=4
set expandtab

set number
filetype indent on

set showmatch

set incsearch
set hlsearch

set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <space> za " space open/closes folds

set laststatus=2
let g:airline_theme='base16_monokai'
let g:airline_powerline_fonts=1

nnoremap B ^
nnoremap E $

nnoremap gV `[v`] " highlight text from last time you were in insert mode

