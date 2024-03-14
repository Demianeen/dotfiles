return {
  'nvim-telescope/telescope.nvim',
  keys = {
    {
      '<leader>sp',
      function()
        require('telescope.builtin').find_files({
          cwd = require('lazy.core.config').options.root,
          prompt_title = 'Find in plugins',
        })
      end,
      desc = 'Find Plugin File',
    },
    {
      '<leader>fc',
      false,
    },
  },
  opts = {
    defaults = {
      --   layout_strategy = "horizontal",
      --   layout_config = { prompt_position = "top" },
      --   sorting_strategy = "ascending",
      --   winblend = 0,
      path_display = { 'truncate' },
    },
  },
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
}
