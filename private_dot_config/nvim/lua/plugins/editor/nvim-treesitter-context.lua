return {
  'nvim-treesitter/nvim-treesitter-context',
  opts = {
    on_attach = function(buf)
      local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })

      if ft == '' or ft == 'svelte' then return false end

      return true
    end,
  },
  keys = {
    {
      '[T',
      [[<cmd>lua require("treesitter-context").go_to_context()<cr>]],
      desc = 'Treesitter context',
    },
  },
}
