return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'typescript', 'tsx' })
      end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      vim.list_extend(opts.servers, {
        -- ---@type lspconfig.options.vtsls
        vtsls = {
          settings = {
            vtsls = {
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            javascript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
              inlayHints = {
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              updateImportsOnFileMove = {
                enabled = 'always',
              },
              -- referencesCodeLens = {
              --   enabled = true,
              --   showOnAllFunctions = true,
              -- },
            },
            typescript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
              inlayHints = {
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              updateImportsOnFileMove = {
                enabled = 'always',
              },
              -- cool feature, but increases ram usage like two times with showOnAllFunctions
              -- referencesCodeLens = {
              --   enabled = true,
              --   showOnAllFunctions = true,
              -- },
            },
          },
        },
      })
    end,
    dependencies = {
      'yioneko/nvim-vtsls',
    },
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'vtsls',
      })
    end,
  },
}
