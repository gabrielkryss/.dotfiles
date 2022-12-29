local installed, _ = require("telescope")

if not installed then
	return
end

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>pp', builtin.planets, {}) -- this doesn't work :( and idk why
vim.keymap.set('n', '<leader>c', builtin.colorscheme, {})
