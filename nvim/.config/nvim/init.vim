
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
