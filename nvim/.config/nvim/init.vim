
call plug#begin('~\AppData\Local\nvim\plugged') " Windows
" call plug#begin(`~/.config/nvim/plugged`) " Linux

Plug 'nvim-telescope/telescope.nvim'

" Color Schemes
Plug 'gruvbox-community/gruvbox'
Plug 'relastle/bluewery.vim'
Plug 'ciaranm/inkpot'
Plug 'EdenEast/nightfox.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'sainnhe/everforest'

call plug#end()

let mapleader = " "
