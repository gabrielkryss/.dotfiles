-- Neovide settings ref: https://github.com/neovide/neovide/wiki/Configuration#transparency
vim.cmd [[
  let g:neovide_transparency=0.8 " 0.0 to 1.0
  let g:neovide_fullscreen=v:false
  let g:neovide_cursor_vfx_mode = "pixiedust" " options: railgun, torpedo, pixiedust, sonicboom, ripple, wireframe 
  let g:neovide_cursor_animation_length=0.13
  let g:neovide_cursor_trail_length=0.8
  let g:neovide_cursor_antialiasing=v:false
  let g:neovide_cursor_vfx_opacity=300.0
  let g:neovide_cursor_vfx_particle_lifetime=3.3
  let g:neovide_cursor_vfx_particle_density=150.0
  let g:neovide_cursor_vfx_particle_speed=7.0
  let g:neovide_cursor_vfx_particle_phase=1.5 " Sets ... the phase? I'm not sure. Go poke @jonvaldes to figure out what it does.
  let g:neovide_cursor_vfx_particle_curl=1.0 " Sets the ... I guess curl. I believe it has something to do with how the particles rotate in the Railgun trail. Again, go bug @jonvaldes.
  let g:neovide_profiler = v:false
  let g:neovide_refresh_rate=144
  let g:neovide_remember_window_size = v:true
  let g:neovide_no_idle=v:true
]]
