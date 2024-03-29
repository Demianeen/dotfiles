return {
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      local cmp = require('cmp')

      opts.auto_brackets = { 'python' }

      opts.window = {
        documentation = {
          winhighlight = 'FloatBorder:CmpDocFloat,NormalFloat:CmpDocFloat',
          border = { '', '', '', ' ', '', '', '', ' ' },
        },
      }

      opts.enabled = function()
        -- '' for normal buffers
        -- 'acwrite' for buffers with autocommands that write to a file
        -- 'help' for help buffers
        -- 'prompt' for buffers used in command-line or search prompt windows.
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = 0 })

        -- no autocompletion in vim prompts
        if buftype == 'prompt' then return false end

        local context = require('cmp.config.context')

        -- no autocompletion in comments
        return not context.in_treesitter_capture('comment')
          and not context.in_syntax_group('Comment')
      end

      opts.sorting = {
        ---@type cmp.ComparatorFunction
        comparators = {
          -- function(entry1, entry2)
          --   local kind1 = entry1:get_kind()
          --   local kind2 = entry2:get_kind()
          --   local completionItem = require('cmp.types').lsp.CompletionItemKind
          --
          --   -- prioritize snippets over keywords
          --   if
          --     completionItem[kind1] == 'Snippet'
          --     and completionItem[kind2] == 'Keyword'
          --   then
          --     return true
          --   elseif
          --     completionItem[kind1] == 'Keyword'
          --     and completionItem[kind2] == 'Snippet'
          --   then
          --     return false
          --   end
          -- end,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,

          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find('^_+')
            local _, entry2_under = entry2.completion_item.label:find('^_+')

            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0

            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,

          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
        },
      }

      opts.sources = cmp.config.sources({
        {
          name = 'nvim_lsp',
          -- removes all keywords autocompletion (def, const, export)
          entry_filter = function(entry, _)
            return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()]
              ~= 'Keyword'
          end,
        },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip', keyword_length = 1 },
      }, {
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'buffer', keyword_length = 3 },
      })
    end,
  },
}
