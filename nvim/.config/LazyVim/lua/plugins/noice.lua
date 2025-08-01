return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    views = {
      cmdline_popup = {
        position = {
          row = "50%",
          col = "50%",
        },
        size = {
          width = "50%",
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "61%",
          col = "50%",
        },
        size = {
          width = 60,
          height = 5,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          -- winblend = 10, -- lower = more opaque, higher = more transparent
          winhighlight = {
            Normal = "Normal",
            NormalFloat = "NormalFloat",
            -- FloatBorder = "DiagnosticInfo",
            FloatBorder = "FloatBorder",
          },
        },
      },
    },
    presets = {
      command_palette = false,
      bottom_search = false,
    },
    -- routes = {}, -- optional custom routes
    -- -- optional LSP override settings
    -- lsp = {
    --   progress = { enabled = true },
    --   hover = { enabled = true },
    --   signature = { enabled = true },
    -- },
  },
}
