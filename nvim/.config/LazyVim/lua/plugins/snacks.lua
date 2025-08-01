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
        -- this doesn't seem to work
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
      },
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
            auto_hide = { "input" },
            layout = {
              position = "right",
            },
          },
        },
      },
    },
  },
}
