local status_ok, neo-zoom = pcall(require, "neo-zoom")
if not status_ok then
	return
end

neo-zoom.setup({
	-- use the defaults or UNCOMMENT and change any one to overwrite
      -- left_ratio = 0.2,
      -- top_ratio = 0.03,
      -- width_ratio = 0.67,
      -- height_ratio = 0.9,
      -- border = 'double',
      -- exclude_filetype = {
      --   'fzf', 'qf', 'dashboard'
      -- }
})

vim.keymap.set('n', '<C-+>', function ()
  vim.cmd('NeoZoomToggle')
end, NOREF_NOERR_TRUNC)

--     -- My setup (This requires NeoNoName.lua, and optionally NeoWell.lua)
--     local cur_buf = nil
--     local cur_cur = nil
--     vim.keymap.set('n', '<CR>', function ()
--       -- Pop-up Effect
--       if vim.api.nvim_win_get_config(0).relative == '' then
--         cur_buf = vim.fn.bufnr()
--         cur_cur = vim.api.nvim_win_get_cursor(0)
--         if vim.fn.bufname() ~= '' then
--           vim.cmd('NeoNoName')
--         end
--         vim.cmd('NeoZoomToggle')
--         vim.api.nvim_set_current_buf(cur_buf)
--         vim.api.nvim_win_set_cursor(0, cur_cur)
--         vim.cmd("normal! zt")
--         vim.cmd("normal! 7k7j")
--         return
--       end
--       vim.cmd('NeoZoomToggle')
--       vim.api.nvim_set_current_buf(cur_buf)
--       cur_buf = nil
--       cur_cur = nil
--       -- vim.cmd('NeoWellJump') -- you can safely remove this line.
--     end, NOREF_NOERR_TRUNC)
--   end
