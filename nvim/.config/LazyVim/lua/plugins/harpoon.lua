return {
  {
    "ThePrimeagen/harpoon",
    opts = function(_, opts)
      local mark = require("harpoon.mark")
      local ui = require("harpoon.ui")

      vim.keymap.set("n", "<leader>hm", mark.add_file, { desc = "Harpoon Mark" })
      vim.keymap.set("n", "<leader>uH", ui.toggle_quick_menu, { desc = "Harpoon Menu Toggle" })

      vim.keymap.set("n", "<A-1>", function()
        ui.nav_file(1)
      end)
      vim.keymap.set("n", "<A-2>", function()
        ui.nav_file(2)
      end)
      vim.keymap.set("n", "<A-3>", function()
        ui.nav_file(3)
      end)
      vim.keymap.set("n", "<A-4>", function()
        ui.nav_file(4)
      end)
    end,
  },
}
