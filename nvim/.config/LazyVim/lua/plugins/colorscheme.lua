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
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    }
}