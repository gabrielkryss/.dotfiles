return {
  -- Configure LazyVim to load colorscheme
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
  { "olivercederborg/poimandres.nvim" },
  { "relastle/bluewery.vim" },
  { "EdenEast/nightfox.nvim" },
  {
    "neanias/everforest-nvim",
    name = "everforest", -- explicitly set the module name
    main = "everforest", -- tell Lazy.nvim the correct Lua module
    lazy = false, -- load during startup
    priority = 1000, -- load before other UI plugins
    opts = {
      background = "hard", -- "soft", "medium", or "hard"
      transparent_background_level = 2,
      italics = true,
    },
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      term_colors = true,
      auto_integrations = true,
      integrations = {
        -- dashboard = true,
        -- neotree = true,
        -- neotest = true,
        -- fzf = true,
        -- neogit = true,
        -- dap = true,
        -- dap_ui = true,
        -- gitsigns = {
        --   enabled = true,
        --   -- align with the transparent_background option by default
        --   transparent = false,
        -- },
        -- blink_cmp = {
        --   style = "bordered",
        -- },
        -- snacks = {
        --   enabled = true,
        --   indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
        -- },
        -- telescope = {
        --   enabled = true,
        -- },
        -- octo = true,
        -- overseer = true,
        -- mini = {
        --   enabled = true,
        --   indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
        -- },
        -- -- navic = {
        -- --   enabled = false,
        -- --   custom_bg = "NONE", -- "lualine" will set background to mantle
        -- --   -- -- You NEED to enable highlight in nvim-navic setting or it won't work
        -- --   -- require("nvim-navic").setup({
        -- --   --   highlight = true,
        -- --   -- }),
        -- -- },
        -- -- native_lsp = {
        -- --   enabled = true,
        -- --   virtual_text = {
        -- --     errors = { "italic" },
        -- --     hints = { "italic" },
        -- --     warnings = { "italic" },
        -- --     information = { "italic" },
        -- --     ok = { "italic" },
        -- --   },
        -- --   underlines = {
        -- --     errors = { "underline" },
        -- --     hints = { "underline" },
        -- --     warnings = { "underline" },
        -- --     information = { "underline" },
        -- --     ok = { "underline" },
        -- --   },
        -- --   inlay_hints = {
        -- --     background = true,
        -- --   },
        -- -- },
        -- -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
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
}
