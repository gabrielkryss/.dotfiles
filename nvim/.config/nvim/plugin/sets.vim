set exrc
set guicursor=
set number
set relativenumber
set nu
set autoindent
set expandtab
set smartindent
set smarttab
set tabstop=4 softtabstop=4
set nowrap
set mouse=a
set nohlsearch
set hidden
set noerrorbells
set incsearch
set scrolloff=8
set colorcolumn=80
set signcolumn=yes
set guifont=
set termguicolors

" Terminal
" (Windows) powershell
" (Linux) use default so leave blank
set shell=powershell

" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50
