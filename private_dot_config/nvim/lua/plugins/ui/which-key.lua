return {
  'folke/which-key.nvim',
  opts = function(_, opts)
    local wk = require('which-key')
    wk.register({
      fc = {
        name = 'copy',
      },
    }, { prefix = '<leader>' })
    local lmu = require('langmapper.utils')

    opts.triggers_blacklist = {
      o = lmu.trans_list({ ';', '.', '"', "'", 'j', 'k', 'D', 's', 'S' }),
      i = lmu.trans_list({ ';', '.', '"', "'", 'j', 'k', 'D', 's', 'S' }),
      n = lmu.trans_list({ ';', '.', '"', "'", 'j', 'k', 'D', 's', 'S' }),
      v = lmu.trans_list({ ';', '.', '"', "'", 'j', 'k', 'D', 's', 'S' }),
    }

    opts.plugins = { spelling = false }
    opts.icons = { group = ' ' }
    opts.layout = { spacing = 5 }
    opts.window = { winblend = 15 }
  end,
}
