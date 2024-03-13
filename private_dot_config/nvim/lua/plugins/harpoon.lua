return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    keys = {
      {
        '<leader>ha',
        function()
          require('harpoon'):list():append()
        end,
        desc = 'Add file to harpoon',
      },
      {
        '<leader>he',
        function()
          require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
        end,
        desc = 'See all harpooned files',
      },
      {
        '<leader>h1',
        function()
          require('harpoon'):list():select(1)
        end,
        desc = 'Open first harpooned file',
      },
      {
        '<leader>h2',
        function()
          require('harpoon'):list():select(2)
        end,
        desc = 'Open second harpooned file',
      },
      {
        '<leader>h3',
        function()
          require('harpoon'):list():select(3)
        end,
        desc = 'Open third harpooned file',
      },
      {
        '<leader>h4',
        function()
          require('harpoon'):list():select(4)
        end,
        desc = 'Open fourth harpooned file',
      },
    },
    config = function()
      local harpoon = require('harpoon')

      harpoon:setup({})
    end,
  },
  {
    'folke/which-key.nvim',
    opts = function(_, _)
      local wk = require('which-key')
      wk.register({
        h = {
          name = 'harpoon',
        },
      }, { prefix = '<leader>' })
    end,
  },
}
