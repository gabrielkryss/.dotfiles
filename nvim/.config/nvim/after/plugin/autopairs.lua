local installed, _ = pcall(require, "nvim-autopairs")

if not installed then
	return
end

require("nvim-autopairs").setup {}