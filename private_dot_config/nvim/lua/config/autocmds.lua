-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- resetting options
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove('r')
    vim.opt_local.formatoptions:remove('o')
  end,
})

vim.api.nvim_del_augroup_by_name('lazyvim_json_conceal')

--- Automatically applies chezmoi on quit
local chezmoi_dir = vim.fn.expand('~/.local/share/chezmoi')
local chezmoi_active = false

-- set flag when entering before saving
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = chezmoi_dir .. '/*',
  callback = function()
    chezmoi_active = true
  end,
})

vim.api.nvim_create_user_command('ChezmoiApply', function()
  vim.fn.system('chezmoi apply')
  -- we don't need to do that again if we already applied chezmoi
  chezmoi_active = false
end, {})

-- check the flag on VimLeave and run `chezmoi apply` if true
vim.api.nvim_create_autocmd('VimLeave', {
  pattern = '*',
  callback = function()
    if chezmoi_active then vim.cmd('ChezmoiApply') end
  end,
})
