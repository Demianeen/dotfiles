return {
  'linux-cultist/venv-selector.nvim',
  cmd = 'VenvSelect',
  opts = {
    changed_venv_hooks = { require('venv-selector').hooks.pyright },
  },
  keys = {
    { '<leader>cv', '<cmd>:VenvSelect<cr>', desc = 'Select VirtualEnv' },
  },
}
