return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'sqlfluff',
      })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        sql = { 'sqlfluff' },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        sql = { 'sqlfluff' },
      },
    },
  },
}
