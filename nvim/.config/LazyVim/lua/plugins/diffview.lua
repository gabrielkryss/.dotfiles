return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" }, -- required
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  -- keys = {
  --   { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
  --   { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
  -- },
}
