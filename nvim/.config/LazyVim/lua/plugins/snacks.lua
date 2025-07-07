return {
  "folke/snacks.nvim",
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
          backdrop = false,
          row = 1,
          width = 0.4,
          min_width = 80,
          height = 0.8,
          border = "none",
          box = "vertical",
          { win = "preview", title = "{preview}", height = 0.4, border = "rounded" },
          {
            box = "vertical",
            border = "rounded",
            title = "{title} {live} {flags}",
            title_pos = "center",
            { win = "list", border = "none" },
            { win = "input", height = 1, border = "bottom" },
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
      layout = "select",
      sources = {
        notifications = {
          layout = "dropdown",
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
