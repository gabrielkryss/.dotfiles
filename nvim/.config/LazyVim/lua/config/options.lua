-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Neovide
vim.opt.guifont = { "Hack Nerd Font Mono", "h22" }
-- Neovide settings ref: https://neovide.dev/configuration.html
vim.g.neovide_transparency = 0.8
vim.g.neovide_scroll_animation_length = 0.3
vim.g.neovide_underline_automatic_scaling = false
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_fullscreen = false
vim.g.neovide_cursor_vfx_mode = "pixiedust" -- options: railgun, torpedo, pixiedust, sonicboom, ripple, wireframe
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_size = 0.8
vim.g.neovide_cursor_antialiasing = false
vim.g.neovide_cursor_vfx_opacity = 300.0
vim.g.neovide_cursor_vfx_particle_lifetime = 3.3
vim.g.neovide_cursor_vfx_particle_density = 150.0
vim.g.neovide_cursor_vfx_particle_speed = 7.0
vim.g.neovide_cursor_vfx_particle_phase = 1.5 -- Sets ... the phase? I'm not sure. Go poke @jonvaldes to figure out what it does.
vim.g.neovide_cursor_vfx_particle_curl = 1.0 -- Sets the ... I guess curl. I believe it has something to do with how the particles rotate in the Railgun trail. Again, go bug @jonvaldes.
vim.g.neovide_profiler = false
-- vim.g.neovide_refresh_rate = 144
vim.g.neovide_remember_window_size = true
vim.g.neovide_no_idle = true

-- for windows
vim.opt.shell = "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe"

vim.opt.winbar = "%=%m %f"

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
-- place holder: "C:\\Users\\Gabriel\\AppData\\Local\\nvim-data\\undodir"
vim.opt.undodir = vim.env.HOME .. "\\AppData\\Local\\nvim-data\\undodir" -- for windows, make sure to MANUALLY create this foler and that it exists, thought it might not solve the os.getenv("HOME") issue
-- vim.opt.undodir = vim.env.HOME ..  "/.vim/undodir" -- for Unix
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.o.clipboard = "unnamedplus"

-- For WSL Clipboard Note: Comment Out for Unix?
vim.g.clipboard = {
  name = 'WslClipboard',
  copy = {
    ['+'] = 'clip.exe',
    ['*'] = 'clip.exe',
  },
  paste = {
    ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}
