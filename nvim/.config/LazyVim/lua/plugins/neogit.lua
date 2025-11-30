-- plugins/neogit.lua
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required by Neogit
    "folke/snacks.nvim", -- Snacks integration
    "sindrets/diffview.nvim", -- Diff integration
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gn", "<cmd>Neogit<CR>", desc = "Open Neogit" },
  },
  config = function()
    require("neogit").setup({
      integrations = {
        telescope = false, -- Disable Telescope picker
        fzf_lua = false, -- Disable FZF picker
        diffview = true, -- enable Diffview integration
        snacks = true, -- Enable Snacks picker
      },
    })
  end,
}
