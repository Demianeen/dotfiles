return {
  'folke/which-key.nvim',
  opts = function(_, _)
    local wk = require('which-key')
    wk.register({
      n = {
        name = 'note',
      },
    }, { prefix = '<leader>' })
  end,
}
