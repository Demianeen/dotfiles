local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	-- stylua: ignore
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false,
  },
  spec = {
    -- lazyvim default plugins
    {
      'LazyVim/LazyVim',
      import = 'lazyvim.plugins',
      opts = function()
        table.insert(require('lazyvim.util.extras').sources, {
          name = '󰬟',
          desc = 'My lazyvim extra',
          module = 'extras',
        })

        return {
          news = {
            lazyvim = true,
            neovim = true,
          },
          colorscheme = 'catppuccin-frappe',
        }
      end,
    },
    -- core
    { import = 'lazyvim.plugins.extras.test.core' },
    { import = 'lazyvim.plugins.extras.dap.core' },
    { import = 'lazyvim.plugins.extras.util.dot' },
    -- { import = 'lazyvim.plugins.extras.util.chezmoi' },
    { import = 'lazyvim.plugins.extras.util.project' },
    { import = 'lazyvim.plugins.extras.editor.dial' },
    { import = 'lazyvim.plugins.extras.coding.luasnip' },
    { import = 'lazyvim.plugins.extras.ui.edgy' },
    { import = 'lazyvim.plugins.extras.coding.mini-surround' },
    { import = 'lazyvim.plugins.extras.editor.inc-rename' },
    -- git
    { import = 'lazyvim.plugins.extras.lang.git' },
    { import = 'lazyvim.plugins.extras.util.octo' },
    -- { import = 'lazyvim.plugins.extras.editor.refactoring' },
    -- -- typescript
    { import = 'lazyvim.plugins.extras.linting.eslint' },
    { import = 'lazyvim.plugins.extras.formatting.prettier' },
    -- { import = 'lazyvim.plugins.extras.lang.typescript-vscode' },
    { import = 'lazyvim.plugins.extras.lang.typescript' },
    -- json
    { import = 'lazyvim.plugins.extras.lang.json' },
    -- markdown
    { import = 'lazyvim.plugins.extras.lang.markdown' },
    -- python
    { import = 'lazyvim.plugins.extras.lang.python' },
    { import = 'lazyvim.plugins.extras.formatting.black' },
    -- yaml
    { import = 'lazyvim.plugins.extras.lang.yaml' },
    -- docker
    { import = 'lazyvim.plugins.extras.lang.docker' },
    -- lua
    { import = 'lazyvim.plugins.extras.dap.nlua' },
    -- nix
    { import = 'lazyvim.plugins.extras.lang.nix' },
    -- go
    { import = 'lazyvim.plugins.extras.lang.go' },
    -- sql
    { import = 'lazyvim.plugins.extras.lang.sql' },

    --- My configurations
    -- general
    { import = 'plugins' },
    -- coding enhancements
    { import = 'plugins/coding' },
    { import = 'plugins/coding/mini' },

    -- coding related functionality, but not coding
    { import = 'plugins/editor' },
    { import = 'plugins/editor/git' },
    { import = 'plugins/editor/telescope' },

    -- lsp
    { import = 'plugins/lsp' },

    -- ui enhancements
    { import = 'plugins/ui' },

    -- language-specific settings and plugins
    { import = 'plugins/lang/css' },
    { import = 'plugins/lang/json' },
    { import = 'plugins/lang/lua' },
    { import = 'plugins/lang/markdown' },
    { import = 'plugins/lang/sql' },
    { import = 'plugins/lang/toml' },
    { import = 'plugins/lang/typescript' },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
    keys = {
      silent = true,
      noremap = true,
    },
  },
  install = { colorscheme = { 'catppuccin-frappe' } },
  checker = { enabled = true, notify = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        -- 'gzip',
        -- "matchit",
        -- 'matchparen',
        'netrwPlugin',
        -- 'tarPlugin',
        -- 'tohtml',
        -- 'tutor',
        -- 'zipPlugin',
      },
    },
  },
})
