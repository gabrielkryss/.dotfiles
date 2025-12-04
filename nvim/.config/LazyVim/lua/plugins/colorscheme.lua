return {
  -- Configure LazyVim to load colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      -- colorscheme = "burzum", -- bathory | burzum | dark-funeral | darkthrone | emperor | gorgoroth | immortal | impaled-nazarene | khold | marduk | mayhem | nile | taake | thyrfing | venom | windir
      -- colorscheme = "vague",
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
    "vague-theme/vague.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require("vague").setup({
        transparent = false, -- don't set background
        -- disable bold/italic globally in `style`
        bold = true,
        italic = true,
        style = {
          -- "none" is the same thing as default. But "italic" and "bold" are also valid options
          boolean = "bold",
          number = "none",
          float = "none",
          error = "bold",
          comments = "italic",
          conditionals = "none",
          functions = "none",
          headings = "bold",
          operators = "none",
          strings = "italic",
          variables = "none",

          -- keywords
          keywords = "none",
          keyword_return = "italic",
          keywords_loop = "none",
          keywords_label = "none",
          keywords_exception = "none",

          -- builtin
          builtin_constants = "bold",
          builtin_functions = "none",
          builtin_types = "bold",
          builtin_variables = "none",
        },
        -- plugin styles where applicable
        -- make an issue/pr if you'd like to see more styling options!
        plugins = {
          cmp = {
            match = "bold",
            match_fuzzy = "bold",
          },
          dashboard = {
            footer = "italic",
          },
          lsp = {
            diagnostic_error = "bold",
            diagnostic_hint = "none",
            diagnostic_info = "italic",
            diagnostic_ok = "none",
            diagnostic_warn = "bold",
          },
          neotest = {
            focused = "bold",
            adapter_name = "bold",
          },
          telescope = {
            match = "bold",
          },
        },

        -- Override highlights or add new highlights
        on_highlights = function(highlights, colors) end,

        -- Override colors
        colors = {
          bg = "#141415",
          inactiveBg = "#1c1c24",
          fg = "#cdcdcd",
          floatBorder = "#878787",
          line = "#252530",
          comment = "#606079",
          builtin = "#b4d4cf",
          func = "#c48282",
          string = "#e8b589",
          number = "#e0a363",
          property = "#c3c3d5",
          constant = "#aeaed1",
          parameter = "#bb9dbd",
          visual = "#333738",
          error = "#d8647e",
          warning = "#f3be7c",
          hint = "#7e98e8",
          operator = "#90a0b5",
          keyword = "#6e94b2",
          type = "#9bb4bc",
          search = "#405065",
          plus = "#7fa563",
          delta = "#f3be7c",
        },
      })
      -- vim.cmd("colorscheme vague")
    end,
  },
  -- Using lazy.nvim
  {
    "metalelf0/black-metal-theme-neovim",
    lazy = false,
    name = "black-metal",
    priority = 1000,
    config = function()
      require("black-metal").setup({
        -----MAIN OPTIONS-----
        --
        -- Can be one of: bathory | burzum | dark-funeral | darkthrone | emperor | gorgoroth | immortal | impaled-nazarene | khold | marduk | mayhem | nile | taake | thyrfing | venom | windir
        theme = "bathory",
        -- Can be one of: 'light' | 'dark', or set via vim.o.background
        variant = "dark",
        -- Use an alternate, lighter bg
        alt_bg = false,
        -- If true, docstrings will be highlighted like strings, otherwise they will be
        -- highlighted like comments. Note, behavior is dependent on the language server.
        colored_docstrings = true,
        -- If true, highlights the {sign,fold} column the same as cursorline
        cursorline_gutter = true,
        -- If true, highlights the gutter darker than the bg
        dark_gutter = false,
        -- if true favor treesitter highlights over semantic highlights
        favor_treesitter_hl = false,
        -- Don't set background of floating windows. Recommended for when using floating
        -- windows with borders.
        plain_float = true,
        -- Show the end-of-buffer character
        show_eob = true,
        -- If true, enable the vim terminal colors
        term_colors = true,
        -- Keymap (in normal mode) to toggle between light and dark variants.
        toggle_variant_key = nil,
        -- Don't set background
        transparent = false,

        -----DIAGNOSTICS and CODE STYLE-----
        --
        diagnostics = {
          darker = true, -- Darker colors for diagnostic
          undercurl = true, -- Use undercurl for diagnostics
          background = true, -- Use background color for virtual text
        },
        -- The following table accepts values the same as the `gui` option for normal
        -- highlights. For example, `bold`, `italic`, `underline`, `none`.
        code_style = {
          comments = "italic",
          conditionals = "none",
          functions = "none",
          keywords = "none",
          headings = "bold", -- Markdown headings
          operators = "none",
          keyword_return = "none",
          strings = "none",
          variables = "none",
        },

        -----PLUGINS-----
        --
        -- The following options allow for more control over some plugin appearances.
        plugin = {
          lualine = {
            -- Bold lualine_a sections
            bold = true,
            -- Don't set section/component backgrounds. Recommended to not set
            -- section/component separators.
            plain = false,
          },
          cmp = { -- works for nvim.cmp and blink.nvim
            -- Don't highlight lsp-kind items. Only the current selection will be highlighted.
            plain = false,
            -- Reverse lsp-kind items' highlights in blink/cmp menu.
            reverse = false,
          },
        },

        -- CUSTOM HIGHLIGHTS --
        --
        -- Override default colors
        colors = {},
        -- Override highlight groups
        highlights = {},
      })
      -- Convenience function that simply calls `:colorscheme <theme>` with the theme
      -- specified in your config.
      -- require("black-metal").load()
    end,
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
