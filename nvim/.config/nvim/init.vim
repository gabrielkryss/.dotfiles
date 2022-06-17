
call plug#begin('~\AppData\Local\nvim\plugged') " Windows
" call plug#begin(`~/.config/nvim/plugged`) " Linux

Plug 'nvim-telescope/telescope.nvim'
Plug 'gruvbox-community/gruvbox'

" Color Schemes
Plug 'relastle/bluewery.vim'
Plug 'ciaranm/inkpot/blob/master/colors/inkpot.vim'
Plug 'EdenEast/nightfox.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'sainnhe/everforest'

call plug#end()

highlight Normal guibg=none

let mapleader = " "
