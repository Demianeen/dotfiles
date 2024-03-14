local LUAROCK_PATH =
  '/opt/homebrew/Cellar/luarocks/3.9.2/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?.lua;/opt/homebrew/share/lua/5.4/?/init.lua;/opt/homebrew/lib/lua/5.4/?.lua;/opt/homebrew/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;/Users/demian/.luarocks/share/lua/5.4/?.lua;/Users/demian/.luarocks/share/lua/5.4/?/init.lua'
local LUAROCK_CPATH =
  '/opt/homebrew/lib/lua/5.4/?.so;/opt/homebrew/lib/lua/5.4/loadall.so;./?.so;/Users/demian/.luarocks/lib/lua/5.4/?.so'
local LUAROCK_41_PATH =
  '/opt/homebrew/Cellar/luarocks/3.9.2/share/lua/5.1/?.lua;/opt/homebrew/share/lua/5.1/?.lua;/opt/homebrew/share/lua/5.1/?/init.lua;/opt/homebrew/lib/lua/5.1/?.lua;/opt/homebrew/lib/lua/5.1/?/init.lua;./?.lua;./?/init.lua;/Users/demian/.luarocks/share/lua/5.1/?.lua;/Users/demian/.luarocks/share/lua/5.1/?/init.lua'
local LUAROCK_41_CPATH =
  '/opt/homebrew/lib/lua/5.1/?.so;/opt/homebrew/lib/lua/5.1/loadall.so;./?.so;/Users/demian/.luarocks/lib/lua/5.1/?.so'

package.path = package.path .. ';' .. LUAROCK_PATH .. ';' .. LUAROCK_41_PATH
package.cpath = package.cpath .. ';' .. LUAROCK_CPATH .. ';' .. LUAROCK_41_CPATH

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
  spec = {
    -- lazyvim default plugins
    {
      'LazyVim/LazyVim',
      import = 'lazyvim.plugins',
    },
    -- core
    { import = 'lazyvim.plugins.extras.test.core' },
    { import = 'lazyvim.plugins.extras.dap.core' },
    { import = 'lazyvim.plugins.extras.util.dot' },
    { import = 'lazyvim.plugins.extras.util.project' },
    -- typescript
    { import = 'lazyvim.plugins.extras.linting.eslint' },
    { import = 'lazyvim.plugins.extras.formatting.prettier' },
    -- { import = 'lazyvim.plugins.extras.lang.vtsls' },
    -- json
    { import = 'lazyvim.plugins.extras.lang.json' },
    -- python
    { import = 'lazyvim.plugins.extras.lang.python' },
    { import = 'lazyvim.plugins.extras.formatting.black' },
    -- yaml
    { import = 'lazyvim.plugins.extras.lang.yaml' },
    -- docker
    { import = 'lazyvim.plugins.extras.lang.docker' },
    -- lua
    { import = 'lazyvim.plugins.extras.dap.nlua' },

    --- My configurations
    -- general
    { import = 'plugins' },
    -- coding enhancements
    { import = 'plugins/coding' },
    { import = 'plugins/coding/mini' },

    -- coding related functionality, but not coding
    { import = 'plugins/editor' },
    { import = 'plugins/editor/git' },

    -- lsp
    { import = 'plugins/lsp' },

    -- ui enhancements
    { import = 'plugins/ui' },

    -- language-specific settings and plugins
    { import = 'plugins/lang/lua' },
    { import = 'plugins/lang/markdown' },
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
  install = { colorscheme = { 'tokyonight', 'habamax' } },
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
