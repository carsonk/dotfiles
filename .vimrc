execute pathogen#infect()
syntax enable
filetype plugin indent on

set mouse=a

colorscheme molokai
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set smarttab

set number
filetype indent plugin on

set showmatch

set incsearch
set hlsearch

set wildmenu

set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <space> za " space open/closes folds

set laststatus=2
let g:airline_theme='base16_monokai'

" air-line
let g:airline_powerline_fonts=0

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

set guifont=DejaVu\ Sans:s12

