return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        sqls = {
          on_attach = function(client, bufnr)
            require('sqls').on_attach(client, bufnr)
          end,
        },
      },
    },
  },
}
