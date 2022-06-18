"" Color Scheme Theme Sets
colorscheme gruvbox
" colorscheme bluewery " alt: bluewery-light reference: https://github.com/relastle/bluewery.vim
" colorscheme tokyonight " reference: https://github.com/folke/tokyonight.nvim
" colorscheme nightfox " reference: https://github.com/EdenEast/nightfox.nvim
" colorscheme everforest " reference: https://github.com/sainnhe/everforest

highlight Normal guibg=none ctermbg=none
highlight NonText ctermbg=none

"" Neovide settings ref: https://github.com/neovide/neovide/wiki/Configuration#transparency
let g:neovide_transparency=0.8 " 0.0 to 1.0
let g:neovide_fullscreen=v:true 
let g:neovide_cursor_vfx_mode = "pixiedust" " options: railgun, torpedo, pixiedust
let g:neovide_cursor_animation_length=0.13
let g:neovide_cursor_trail_length=0.8
let g:neovide_cursor_antialiasing=v:false
let g:neovide_cursor_vfx_opacity=200.0
let g:neovide_cursor_vfx_particle_lifetime=1.5
let g:neovide_cursor_vfx_particle_density=15.0
let g:neovide_cursor_vfx_particle_speed=10.0
let g:neovide_cursor_vfx_particle_phase=1.5 " Sets ... the phase? I'm not sure. Go poke @jonvaldes to figure out what it does.
let g:neovide_cursor_vfx_particle_curl=1.0 " Sets the ... I guess curl. I believe it has something to do with how the particles rotate in the Railgun trail. Again, go bug @jonvaldes.
let g:neovide_profiler = v:false
let g:neovide_refresh_rate=144
let g:neovide_remember_window_size = v:true
let g:neovide_no_idle=v:true

let g:theprimeagen_colorscheme = "gruvbox"
fun! ColorMyPencils()
    let g:gruvbox_contrast_dark = 'hard'
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    let g:gruvbox_invert_selection='0'

    set background=dark
    if has('nvim')
        call luaeval('vim.cmd("colorscheme " .. _A[1])', [g:theprimeagen_colorscheme])
    else
        " TODO: What the way to use g:theprimeagen_colorscheme
        colorscheme gruvbox
    endif

    highlight ColorColumn ctermbg=0 guibg=grey
    hi SignColumn guibg=none
    hi CursorLineNR guibg=None
    highlight Normal guibg=none
    " highlight LineNr guifg=#ff8659
    " highlight LineNr guifg=#aed75f
    highlight LineNr guifg=#5eacd3
    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
    hi TelescopeBorder guifg=#5eacd
endfun
call ColorMyPencils()

" Vim with me
nnoremap <leader>cmp :call ColorMyPencils()<CR>
nnoremap <leader>vwb :let g:theprimeagen_colorscheme =
