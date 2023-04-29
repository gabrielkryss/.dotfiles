-- so that transparent plugin works 
require("notify").setup({
    background_colour = "#000000",
})

return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "poimandres",
        }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            window = {
                position = "right",
                width = 27,
            }
        }
    },
    {
        "goolord/alpha-nvim",
        -- opts = function(_, opts)
            
        -- end
    },
}