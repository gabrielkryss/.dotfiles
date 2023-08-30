-- so that transparent plugin works
require("notify").setup({
  background_colour = "#000000",
})

return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "poimandres",
      -- colorscheme = "tokyonight",
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "tokyonight-storm",
      -- colorscheme = "tokyonight-moon",
      -- colorscheme = "tokyonight-day",
      -- colorscheme = "catppuccin",
      -- colorscheme = "catppuccin-latte",
      -- colorscheme = "catppuccin-frappe",
      colorscheme = "catppuccin-mocha",
      -- colorscheme = "catppuccin-macchiato",
      -- colorscheme = "dark_modern",
      -- colorscheme = "rose-pine",
      -- colorscheme = "rose-pine-main",
      -- colorscheme = "rose-pine-moon",
      -- colorscheme = "rose-pine-dawn",
    },
  },
  -- Edgy: LazyVim Core UI
  {
    "folke/edgy.nvim",
    opts = {
      left = {},
      right = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = function()
            vim.api.nvim_input("<esc><space>e")
          end,
          size = { height = 0.5 },
        },
        { title = "Neotest Summary", ft = "neotest-summary" },
        {
          title = "Neo-Tree Git",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "git_status"
          end,
          pinned = true,
          open = "Neotree position=right git_status",
        },
        {
          title = "Neo-Tree Buffers",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "buffers"
          end,
          pinned = true,
          open = "Neotree position=top buffers",
        },
        "neo-tree",
      },
      animate = {
        enabled = true,
        fps = 144, -- frames per second
        cps = 200, -- cells per second
      },
    },
  },
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },
  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },
  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },
  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "rust",
        "go",
      },
    },
  },
  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },
  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  },
  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },
  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "rust-analyzer",
        "flake8",
      },
    },
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
        width = 27,
      },
    },
  },
  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 50,
      },
    },
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      local logo1 = {
        [[            :h-                                  Nhy`               ]],
        [[           -mh.                           h.    `Ndho               ]],
        [[           hmh+                          oNm.   oNdhh               ]],
        [[          `Nmhd`                        /NNmd  /NNhhd               ]],
        [[          -NNhhy                      `hMNmmm`+NNdhhh               ]],
        [[          .NNmhhs              ```....`..-:/./mNdhhh+               ]],
        [[           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ]],
        [[           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ]],
        [[      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ]],
        [[ .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ]],
        [[ h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ]],
        [[ hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ]],
        [[ /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ]],
        [[  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ]],
        [[   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ]],
        [[     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ]],
        [[       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ]],
        [[       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ]],
        [[       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ]],
        [[       //+++//++++++////+++///::--                 .::::-------::   ]],
        [[       :/++++///////////++++//////.                -:/:----::../-   ]],
        [[       -/++++//++///+//////////////               .::::---:::-.+`   ]],
        [[       `////////////////////////////:.            --::-----...-/    ]],
        [[        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ]],
        [[         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ]],
        [[           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ]],
        [[            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``]],
        [[           s-`::--:::------:////----:---.-:::...-.....`./:          ]],
        [[          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ]],
        [[         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ]],
        [[        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ]],
        [[                        .-:mNdhh:.......--::::-`                    ]],
        [[                           yNh/..------..`                          ]],
        [[                                                                    ]],
      }

      local logo2 = {
        [[                                                 .------.------.    ]],
        [[  +-------------+                     ___        |      |      |    ]],
        [[  |             |                     \ /]       |      |      |    ]],
        [[  |             |        _           _(_)        |      |      |    ]],
        [[  |             |     ___))         [  | \___    |      |      |    ]],
        [[  |             |     ) //o          | |     \   |      |      |    ]],
        [[  |             |  _ (_    >         | |      ]  |      |      |    ]],
        [[  |          __ | (O)  \__<          | | ____/   '------'------'    ]],
        [[  |         /  o| [/] /   \)        [__|/_                          ]],
        [[  |             | [\]|  ( \         __/___\_____                    ]],
        [[  |             | [/]|   \ \__  ___|            |                   ]],
        [[  |             | [\]|    \___E/%%/|____________|_____              ]],
        [[  |             | [/]|=====__   (_____________________)             ]],
        [[  |             | [\] \_____ \    |                  |              ]],
        [[  |             | [/========\ |   |                  |              ]],
        [[  |             | [\]     []| |   |                  |              ]],
        [[  |             | [/]     []| |_  |                  |              ]],
        [[  |             | [\]     []|___) |                  |    MEPH      ]],
        [[====================================================================]],
      }

      local logo3 = {
        [[             ________________________________________________              ]],
        [[            /                                                \             ]],
        [[           |    _________________________________________     |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |  C:\> _                                 |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |                                         |    |            ]],
        [[           |   |_________________________________________|    |            ]],
        [[           |                                                  |            ]],
        [[            \_________________________________________________/            ]],
        [[                   \___________________________________/                   ]],
        [[                ___________________________________________                ]],
        [[             _-'    .-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.  --- `-_             ]],
        [[          _-'.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.--.  .-.-.`-_          ]],
        [[       _-'.-.-.-. .---.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-`__`. .-.-.-.`-_       ]],
        [[    _-'.-.-.-.-. .-----.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-----. .-.-.-.-.`-_    ]],
        [[ _-'.-.-.-.-.-. .---.-. .-------------------------. .-.---. .---.-.-.-.`-_ ]],
        [[:-------------------------------------------------------------------------:]],
        [[`---._.-------------------------------------------------------------._.---']],
      }

      local logo4 = {
        [[                                                     ]],
        [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        [[                                                     ]],
      }

      math.randomseed(os.time())

      local function pick_color()
        local colors = {
          "String",
          "Identifier",
          "Keyword",
          "Number",
        }
        return colors[math.random(#colors)]
      end

      --    opts.section.header.val = logo2
      opts.section.header.opts.hl = pick_color()
    end,
  },
}
