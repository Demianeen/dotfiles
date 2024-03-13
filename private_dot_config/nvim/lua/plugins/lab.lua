return {
  'nvim-cmp',
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources, 1, {
      name = 'lab.quick_data',
      keyword_length = 4,
    })
  end,
  dependencies = {
    '0x100101/lab.nvim',
    build = 'cd js && npm ci',
    dependencies = {
      {
        'folke/which-key.nvim',
        opts = function(_, _)
          local wk = require('which-key')
          wk.register({
            L = {
              name = 'Lab',
            },
          }, { prefix = '<leader>c' })
        end,
      },
    },
    keys = {
      { '<leader>cLs', ':Lab code stop<CR>', desc = 'Stop', silent = true },
      { '<leader>cLr', ':Lab code run<CR>', desc = 'Run', silent = true },
      { '<leader>cLp', ':Lab code panel<CR>', desc = 'Panel', silent = true },
      { '<leader>cLc', ':Lab code config<CR>', desc = 'Config', silent = true },
    },
    opts = {
      code_runner = {
        enabled = true,
      },
      quick_data = {
        enabled = true,
      },
    },
  },
}
