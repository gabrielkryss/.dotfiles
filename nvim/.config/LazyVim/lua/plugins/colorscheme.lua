return {
    {'rose-pine/neovim'},
    { "ellisonleao/gruvbox.nvim" },
    { "olivercederborg/poimandres.nvim" },
    {'relastle/bluewery.vim'},
    {'EdenEast/nightfox.nvim'},
    {'sainnhe/everforest'},
    {
        "catppuccin/nvim",
        lazy = true,
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
        opts = {
            transparent = true,
            priority = 1000,
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
            transparent_background = true,
            nvim_tree_darker = true,
        }
    },
}