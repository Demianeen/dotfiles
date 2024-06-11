local wk = require('which-key')
wk.register({
  fc = {
    name = 'Copy',
  },
}, { prefix = '<leader>' })

return {
  'LazyVim/LazyVim',
  keys = {
    {
      '<leader>fcr',
      ":call setreg('+', expand('%'))<CR>",
      desc = 'Relative file path',
    },
  },
}
