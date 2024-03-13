-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.opt.clipboard = ''

-- tabs
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt.smartindent = true -- Tries to guess and adds intend when start a new line
vim.opt.autoindent = true -- Remembers indent from previous lines
vim.opt.expandtab = false

-- vim.opt.textwidth = 80 -- text width. Used for example for comments max length
vim.opt.wrap = true
vim.opt.wrapmargin = 100
vim.opt.linebreak = true -- line breaks only on special characters instead of any char

vim.opt.undofile = true -- Sets persistent undo

vim.opt.conceallevel = 2 -- conceal level

-- vim.opt.hlsearch = false -- no highlight during search

vim.opt.scrolloff = 8 -- Always would be at least n characters in the bottom/ at the top of screen unless the end of the file
vim.opt.signcolumn = 'yes' -- Always show columns for sign at the left part of the window

vim.opt.report = 1000

vim.opt.spell = true -- enables spelling
vim.opt.spelloptions = 'camel'

vim.filetype.add({
  --  extension = {
  --   foo = 'fooscript',
  --   bar = function(path, bufnr)
  --     if some_condition() then
  --       return 'barscript', function(bufnr)
  --         -- Set a buffer variable
  --         vim.b[bufnr].barscript_version = 2
  --       end
  --     end
  --     return 'bar'
  --   end,
  -- },
  filename = {
    ['.eslintrc.json'] = 'jsonc',
    ['.lintstagedrc'] = 'json',
  },
  pattern = {
    ['.*/.husky/.*'] = 'bash',
    ['.*/.vscode/.*json'] = 'jsonc',
    -- -- Using an optional priority
    -- ['.*/etc/foo/.*%.conf'] = { 'dosini', { priority = 10 } },
    -- -- A pattern containing an environment variable
    -- ['${XDG_CONFIG_HOME}/foo/git'] = 'git',
    -- ['README.(%a+)$'] = function(path, bufnr, ext)
    --   if ext == 'md' then
    --     return 'markdown'
    --   elseif ext == 'rst' then
    --     return 'rst'
    --   end
    -- end,
  },
})

-- vim.opt.hint.paramType = true -- enables inline parameter hints
