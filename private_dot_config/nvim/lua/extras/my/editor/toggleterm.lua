vim.api.nvim_create_autocmd('FileType', {
  pattern = 'toggleterm',
  command = 'setlocal nospell',
})

function _open_multiple_terminals(n)
  for i = 1, n do
    vim.cmd(i .. 'ToggleTerm')
  end
end

for i = 1, 9 do
  vim.api.nvim_set_keymap(
    'n',
    'g' .. i .. '<c-\\>',
    '<cmd>lua _open_multiple_terminals(' .. i .. ')<CR>',
    { noremap = true, silent = true }
  )
end

return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return vim.o.lines * 0.5 -- Take up half of the screen's height
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4 -- Keep 40% of the screen's width as is
      end
    end,
    open_mapping = [[<c-\>]],
    -- winbar = {
    --   enabled = true,
    --   name_formatter = function(term) --  term: Terminal
    --     return term.name
    --   end,
    -- },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*toggleterm#*',
      callback = function()
        local keymap_ops = require('util.keymaps')

        -- del buffer
        vim.api.nvim_buf_set_keymap(
          0,
          't',
          '<C-q>',
          '<Cmd>lua require("mini.bufremove").delete(0)<CR>',
          keymap_ops('Terminate terminal')
        )

        -- clear terminal
        vim.api.nvim_buf_create_user_command(0, 'ClearTerminal', function()
          local term = require('toggleterm.terminal')
          local termid = term.get_focused_id()

          if termid then
            local current_terminal = term.get(termid)
            if current_terminal then
              current_terminal:clear()
            else
              print('No terminal found with this ID.')
            end
          end
        end, { desc = 'Clear the current ToggleTerm terminal' })
        -- vim.api.nvim_buf_set_keymap(
        --   0,
        --   't',
        --   '<C-l>',
        --   '<CMD>ClearTerminal<CR>',
        --   keymap_ops('Clear terminal')
        -- )
      end,
    })
  end,
}
