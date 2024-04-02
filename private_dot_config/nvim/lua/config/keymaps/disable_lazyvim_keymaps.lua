-- lazyterm
vim.api.nvim_del_keymap('n', '<c-/>')
vim.api.nvim_del_keymap('t', '<c-/>')
vim.api.nvim_del_keymap('n', '<c-_>')
vim.api.nvim_del_keymap('t', '<C-_>')

-- next/prev buffer
vim.keymap.del('n', '<S-h>')
vim.keymap.del('n', '<S-l>')
