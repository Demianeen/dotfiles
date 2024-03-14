return {
  'folke/which-key.nvim',
  opts = function(_, _)
    local wk = require('which-key')
    wk.register({
      fc = {
        name = 'copy',
      },
    }, { prefix = '<leader>' })
  end,
}
