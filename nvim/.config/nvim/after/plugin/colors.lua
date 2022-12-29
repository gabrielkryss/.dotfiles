-- gruvbox
-- bluewery
-- nightfox
-- everforest
-- poimandres
-- rose-pine
require('poimandres').setup({
    disable_background = true
})

function ColorMyPencils(color) 
	color = color or "poimandres"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

end

ColorMyPencils()

-- persists color scheme change when switching colorschemes
vim.g.colors_name_before = vim.g.colors_name
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    if vim.g.colors_name_before ~= vim.g.colors_name then
      local file_handle = io.open(string.format("%s\\after\\plugin\\colorscheme.lua", vim.fn.stdpath("config")), "w")
      if file_handle then
        file_handle:write(string.format([[vim.cmd.colo("%s")]], vim.g.colors_name))
        file_handle:close()
		    ColorMyPencils(vim.g.colors_name)
      end
      vim.g.colors_name_before = vim.g.colors_name
    end
  end,
  desc = "Persist colorscheme.",
})