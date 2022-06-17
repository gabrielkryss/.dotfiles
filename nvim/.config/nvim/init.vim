set exrc
set guicursor=
set number
set relativenumber
set nu
set autoindent
set expandtab
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


call plug#begin()

Plug 'nvim-telescope/telescope.nvim'
Plug 'gruvbox-community/gruvbox'

" Color Schemes
Plug 'relastle/bluewery.vim'
Plug 'ciaranm/inkpot/blob/master/colors/inkpot.vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

call plug#end()

colorscheme gruvbox
highlight Normal guibg=none

let mapleader = " "
