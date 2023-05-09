" ==============================================================================
" author: stefangreve <greve.stefan@outlook.jp>
" ==============================================================================

let mapleader=" "

syntax on
filetype on
" disable redraws during macro execution to improve performance
set lazyredraw
set nocompatible
set encoding=utf-8
set expandtab
set smarttab
" one tab equals four spaces
set shiftwidth=4
set tabstop=4
" turn on linebreaks
set linebreak
" and set a 240 character line limit
set textwidth=240
set autoindent
set smartindent
" turn on (absolute) line numbers
set number
" show line and column number
set ruler
" highlight search results
set hlsearch
" enable auto-completion
set wildmode=longest,list,full
set magic
set nobackup
set noswapfile

if has('termguicolors')
    set termguicolors
endif

" ==============================================================================
" global macros
" ==============================================================================

" disable comment continuation
autocmd BufNewFile,Bufread * setlocal formatoptions-=cro
" return to last modified line after re-opening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" automatically delete all trailing white spaces
autocmd BufWritePre * %s/\s\+$//e
" check spelling
map <leader>o :setlocal spell! spelllang=en_us<CR>
