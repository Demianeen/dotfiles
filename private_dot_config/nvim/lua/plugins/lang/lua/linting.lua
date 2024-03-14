return {
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        'selene',
      })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        lua = { 'selene' },
      },
      linters = {
        -- Example of using selene only when a selene.toml file is present
        selene = {
          -- `condition` is another LazyVim extension that allows you to
          -- dynamically enable/disable linters based on the context.
          condition = function(ctx)
            local result = vim.fs.find(
              { 'selene.toml' },
              { path = ctx.filename, upward = true }
            )[1]
            return result
          end,
        },
      },
    },
  },
}
