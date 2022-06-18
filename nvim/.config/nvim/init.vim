
call plug#begin('~\AppData\Local\nvim\plugged') " Windows
" call plug#begin(`~/.config/nvim/plugged`) " Linux

Plug 'nvim-telescope/telescope.nvim'

" Color Schemes
Plug 'gruvbox-community/gruvbox'
Plug 'relastle/bluewery.vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'sainnhe/everforest'

call plug#end()

let mapleader = " "

" greatest remap ever
xnoremap <leader>p "_dP

" next greatest remap ever : asbjornHaland
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader>Y "+Y

nnoremap <leader>d "_d
vnoremap <leader>d "_d
