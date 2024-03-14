return {
  {
    'jmbuhr/otter.nvim',
    event = { 'VeryLazy' },
    dependencies = {
      {
        'hrsh7th/nvim-cmp',
        opts = function(_, opts)
          -- add tsx and treesitter
          vim.list_extend(opts.sources, {
            {
              group_index = 1,
              name = 'otter',
            },
          })
        end,
      },
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      lsp = {
        hover = {
          border = {
            '╭',
            '─',
            '╮',
            '│',
            '╯',
            '─',
            '╰',
            '│',
          },
        },
        -- `:h events` that cause the diagnostics to update.
        -- { "BufWritePost", "InsertLeave", "TextChanged" } less performant
        -- but more instant diagnostic updates. Otherwise just use { "BufWritePost" }
        diagnostic_update_events = {
          'BufWritePost',
          'InsertLeave',
          'TextChanged',
        },
      },
      buffers = {
        -- if set to true, the filetype of the otterbuffers will be set.
        -- otherwise only the autocommand of lspconfig that attaches
        -- the language server will be executed without setting the filetype
        set_filetype = true,
        -- write <path>.otter.<embedded language extension> files
        -- to disk on save of main buffer.
        -- usefule for some linters that require actual files
        -- otter files are deleted on quit or main buffer close
        write_to_disk = false,
      },
      strip_wrapping_quote_characters = { "'", '"', '`' },
      -- Otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
      -- When true, otter handles these cases fully. This is a (minor) performance hit
      handle_leading_whitespace = false,
    },
    config = function(_, opts)
      local ot = require('otter')
      print(opts)

      ot.setup(opts)

      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Activate otter for filetypes with injections.',
        group = vim.api.nvim_create_augroup('OtterActivate', {}),
        pattern = { 'markdown', 'norg', 'org' },
        callback = function(info)
          -- Enable completion only, disable diagnostics
          ot.activate(
            { 'python', 'bash', 'lua', 'typescript', 'tsx' },
            true,
            false
          )
						-- stylua: ignore start
						vim.api.nvim_buf_create_user_command(buf, 'OtterRename', ot.ask_rename, {})
						vim.api.nvim_buf_create_user_command(buf, 'OtterHover', ot.ask_hover, {})
						vim.api.nvim_buf_create_user_command(buf, 'OtterReferences', ot.ask_references, {})
						vim.api.nvim_buf_create_user_command(buf, 'OtterTypeDefinition', ot.ask_type_definition, {})
						vim.api.nvim_buf_create_user_command(buf, 'OtterDefinition', ot.ask_definition, {})
						vim.api.nvim_buf_create_user_command(buf, 'OtterDocumentSymbols', ot.ask_document_symbols, {})
						vim.keymap.set('n', '<leader>R', ot.ask_rename, { buffer = buf })
						vim.keymap.set('n', 'K', ot.ask_hover, { buffer = buf })
						vim.keymap.set('n', 'g/', ot.ask_references, { buffer = buf })
						vim.keymap.set('n', 'gD', ot.ask_type_definition, { buffer = buf })
						vim.keymap.set('n', 'gd', ot.ask_definition, { buffer = buf })
          -- stylua: ignore end
        end,
      })
    end,
  },
}
