return {
    {
        "ThePrimeagen/harpoon",
        opts = function(_, opts)
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")
            
            vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon Mark" })
            vim.keymap.set("n", "<leader>uh", ui.toggle_quick_menu, { desc = "Harpoon Menu Toggle" })
            
            vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
            vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end)
            vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end)
            vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end)
        end
    },
}
