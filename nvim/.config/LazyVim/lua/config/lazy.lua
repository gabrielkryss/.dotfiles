local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Language Support
    { import = "lazyvim.plugins.extras.lang.git" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    -- { import = "lazyvim.plugins.extras.lang.typst" },
    -- { import = "lazyvim.plugins.extras.lang.sql" },
    -- { import = "lazyvim.plugins.extras.lang.nix" },
    -- { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.zig" },
    { import = "lazyvim.plugins.extras.lang.clangd" },
    { import = "lazyvim.plugins.extras.lang.cmake" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    -- { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.astro" },
    -- { import = "lazyvim.plugins.extras.lang.tailwind" },
    -- { import = "lazyvim.plugins.extras.lang.svelte" },
    -- { import = "lazyvim.plugins.extras.lang.vue" },
    -- { import = "lazyvim.plugins.extras.lang.dotnet" },
    -- { import = "lazyvim.plugins.extras.lang.go" },
    -- { import = "lazyvim.plugins.extras.lang.yml" },
    -- { import = "lazyvim.plugins.extras.lang.angular" },
    -- { import = "lazyvim.plugins.extras.lang.ansible" },
    -- { import = "lazyvim.plugins.extras.lang.clojure" },
    -- { import = "lazyvim.plugins.extras.lang.dart" },
    -- { import = "lazyvim.plugins.extras.lang.elixir" },
    -- { import = "lazyvim.plugins.extras.lang.elm" },
    -- { import = "lazyvim.plugins.extras.lang.ember" },
    -- { import = "lazyvim.plugins.extras.lang.erlang" },
    -- { import = "lazyvim.plugins.extras.lang.gleam" },
    -- { import = "lazyvim.plugins.extras.lang.haskell" },
    -- { import = "lazyvim.plugins.extras.lang.hel" },
    -- { import = "lazyvim.plugins.extras.lang.java" },
    -- { import = "lazyvim.plugins.extras.lang.julia" },
    -- { import = "lazyvim.plugins.extras.lang.kotlin" },
    -- { import = "lazyvim.plugins.extras.lang.lean" },
    -- { import = "lazyvim.plugins.extras.lang.nushell" },
    -- { import = "lazyvim.plugins.extras.lang.ocaml" },
    -- { import = "lazyvim.plugins.extras.lang.php" },
    -- { import = "lazyvim.plugins.extras.lang.prisma" },
    -- { import = "lazyvim.plugins.extras.lang.r" },
    -- { import = "lazyvim.plugins.extras.lang.rego" },
    -- { import = "lazyvim.plugins.extras.lang.ruby" },
    -- { import = "lazyvim.plugins.extras.lang.scala" },
    -- { import = "lazyvim.plugins.extras.lang.solidity" },
    -- { import = "lazyvim.plugins.extras.lang.terraform" },
    -- { import = "lazyvim.plugins.extras.lang.tex" },
    -- { import = "lazyvim.plugins.extras.lang.thrift" },
    -- { import = "lazyvim.plugins.extras.lang.twig" },

    -- Coding
    { import = "lazyvim.plugins.extras.coding.luasnip" },
    { import = "lazyvim.plugins.extras.coding.mini-comment" },
    { import = "lazyvim.plugins.extras.coding.mini-snippets" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    { import = "lazyvim.plugins.extras.coding.blink" },
    -- { import = "lazyvim.plugins.extras.coding.neogen" },

    -- AI
    { import = "lazyvim.plugins.extras.ai.avante" },
    -- { import = "lazyvim.plugins.extras.ai.claudecode" },
    -- { import = "lazyvim.plugins.extras.ai.codeium" },
    -- { import = "lazyvim.plugins.extras.ai.copilot" },
    -- { import = "lazyvim.plugins.extras.ai.copilot-chat" },
    -- { import = "lazyvim.plugins.extras.ai.copilot-native" }, -- Native Copilot LSP integration. Requires Neovim >= 0.12
    -- { import = "lazyvim.plugins.extras.ai.sidekick" }, -- Next edit suggestions with the Copilot LSP server
    -- { import = "lazyvim.plugins.extrasai.supermaven" },
    -- { import = "lazyvim.plugins.extrasai.tabnine" },

    -- Debugging
    { import = "lazyvim.plugins.extras.dap.core" },

    -- Testing
    { import = "lazyvim.plugins.extras.test.core" },

    -- Editor
    { import = "lazyvim.plugins.extras.editor.dial" },
    { import = "lazyvim.plugins.extras.editor.harpoon2" },
    { import = "lazyvim.plugins.extras.editor.illuminate" },
    { import = "lazyvim.plugins.extras.editor.inc-rename" },
    { import = "lazyvim.plugins.extras.editor.leap" },
    { import = "lazyvim.plugins.extras.editor.mini-diff" },
    { import = "lazyvim.plugins.extras.editor.mini-files" },
    { import = "lazyvim.plugins.extras.editor.mini-move" },
    { import = "lazyvim.plugins.extras.editor.navic" },
    { import = "lazyvim.plugins.extras.editor.refactoring" },
    { import = "lazyvim.plugins.extras.editor.snacks_explorer" },
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    { import = "lazyvim.plugins.extras.editor.overseer" },

    -- LSP & Language Tools
    { import = "lazyvim.plugins.extras.lsp.neoconf" },
    { import = "lazyvim.plugins.extras.lsp.none-ls" },

    -- UI
    -- { import = "lazyvim.plugins.extras.ui.dashboard" }, Note: dashboard is the default so explicitly ebaling will trigger a warning message
    -- { import = "lazyvim.plugins.extras.ui.alpha" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "lazyvim.plugins.extras.ui.edgy" },
    { import = "lazyvim.plugins.extras.ui.indent-blankline" },
    { import = "lazyvim.plugins.extras.ui.mini-indentscope" },
    { import = "lazyvim.plugins.extras.ui.smear-cursor" },
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    -- { import = "lazyvim.plugins.extras.ui.mini-starter" },

    -- Utilities
    { import = "lazyvim.plugins.extras.util.chezmoi" },
    { import = "lazyvim.plugins.extras.util.gh" },
    -- { import = "lazyvim.plugins.extras.util.gitui" },
    -- { import = "lazyvim.plugins.extras.util.project" },
    { import = "lazyvim.plugins.extras.util.startuptime" },
    { import = "lazyvim.plugins.extras.util.dot" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.util.octo" },
    { import = "lazyvim.plugins.extras.util.rest" },

    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
