return {
  "folke/snacks.nvim",
  priority = 1000,
  ---@type snacks.Config
  opts = {
    terminal = {
      win = {
        -- terminal
        -- float
        -- style = "terminal",
        style = {
          -- this is custom from float style
          position = "float",
          border = "rounded",
          backdrop = 60,
          height = 0.65,
          width = 0.54,
          zindex = 50,
        },
      },
    },
    scroll = {
      enabled = false,
    },
    picker = {
      layouts = {
        my_custom_layout = {
          layout = { -- 👈 this wrapper is required
            box = "vertical",
            backdrop = false,
            row = 1,
            width = 0.7,
            min_width = 80,
            height = 0.9,
            border = "none",
            {
              win = "preview",
              title = "{preview}",
              height = 0.7,
              border = "rounded",
            },
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
              {
                win = "list",
                border = "none",
              },
            },
            {
              win = "input",
              height = 1,
              border = "rounded",
            },
          },
        },
        my_custom_layout_2 = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = 0,
            col = 0,
            width = vim.o.columns,
            height = vim.o.lines,
            min_width = 0,
            border = "none",
            {
              win = "preview",
              title = "{preview}",
              height = 0.7,
              border = "rounded",
            },
            {
              box = "vertical",
              border = "rounded",
              height = 0.257,
              title = "{title} {live} {flags}",
              title_pos = "center",
              {
                win = "list",
                border = "none",
              },
            },
            {
              win = "input",
              height = 1,
              border = "rounded",
            },
          },
        },
        custom_ivy_plit_layout = {
          preset = "ivy_split", -- start from ivy_split
          layout = {
            box = "vertical",
            backdrop = false,
            width = 0,
            height = 0.3,
            position = "bottom",
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "center",
            {
              box = "horizontal",
              { win = "list", border = "rounded", align = "bottom" },
              { win = "preview", border = "rounded", title = "{preview}", width = 0.6 },
            },
            { win = "input", height = 1, border = "rounded" },
          },
        },
      },
      -- ivy
      -- bottom
      -- top
      -- telescope
      -- dropdown
      -- select
      -- vertical
      -- sidebar
      -- telescope
      -- ivy_split
      -- vscode
      layout = "my_custom_layout",
      sources = {
        files = {
          layout = "select",
          hidden = true,
        },
        command_history = {
          layout = "select",
        },
        notifications = {
          layout = "my_custom_layout",
        },
        explorer = {
          hidden = true,
          layout = {
            hidden = { "input" },
            layout = {
              position = "right",
            },
          },
        },
        grep = { layout = "my_custom_layout_2" },
        git_grep = { layout = "my_custom_layout_2" },
        colorschemes = { layout = "my_custom_layout_2" },
        git_log_line = { layout = "custom_ivy_plit_layout" },
        git_log_files = { layout = "custom_ivy_plit_layout" },
      },
    },
  },
}
