return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      -- transparent_mode = true,
      contrast = "hard", -- options: "soft", "medium", "hard"
    },
  },

  {
    "rose-pine/neovim",
    lazy = false,
    name = "rose-pine",
    opts = {
      --- @usage 'auto'|'main'|'moon'|'dawn'
      variant = "auto",
      --- @usage 'main'|'moon'|'dawn'
      dark_variant = "main",
      bold_vert_split = false,
      dim_nc_background = false,
      -- disable_background = true,
      -- disable_float_background = true,
    },
  },
  { "ellisonleao/gruvbox.nvim" },
  { "olivercederborg/poimandres.nvim" },
  { "relastle/bluewery.vim" },
  { "EdenEast/nightfox.nvim" },
  { "sainnhe/everforest" },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      term_colors = true,
      integrations = {
        neotree = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    -- transparent = true,
    priority = 1000,
    opts = {
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "gmr458/dark_modern.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      cursorline = true,
      -- transparent_background = true,
      nvim_tree_darker = true,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      colorscheme = "everforest",
      -- colorscheme = "rose-pine",
      -- colorscheme = "gruvbox",
      -- colorscheme = "tokyonight",
    },
  },
}
