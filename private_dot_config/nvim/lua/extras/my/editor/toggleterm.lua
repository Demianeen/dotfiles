local function get_main_window_id()
  local current_window_id = vim.api.nvim_get_current_win()

  require('edgy').goto_main()
  local main_window_id = vim.api.nvim_get_current_win()

  vim.fn.win_gotoid(current_window_id)
  return main_window_id
end

local function open_path(buf, path)
  if vim.uv.fs_stat(vim.fn.fnamemodify(path, ':p')) then
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line =
      vim.api.nvim_buf_get_lines(buf, cursor[1] - 1, cursor[1], false)[1]

    local main_window_id = get_main_window_id()
    vim.fn.win_gotoid(main_window_id)
    vim.cmd('edit ' .. path)

    local row_col = string.match(line, path .. '%s(%d+:%d+)')

    if row_col then
      row_col = vim.iter(vim.split(row_col, ':')):map(tonumber):totable()
      vim.api.nvim_win_set_cursor(0, row_col)
    end

    return
  end

  local ok, msg = pcall(vim.ui.open, path)

  if not ok then vim.notify(string(msg), vim.log.levels.ERROR) end
end

return {
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  keys = function(_, keys)
    keys = keys or {}

    -- open n terminals
    for i = 1, 9 do
      vim.list_extend(keys, {
        {
          'g' .. i .. '<c-\\>',
          function()
            for j = 1, i do
              vim.schedule(function()
                vim.cmd(j .. 'ToggleTerm')
              end)
            end
          end,
        },
      })
    end

    -- toggle all terminals
    vim.list_extend(keys, {
      {
        '0<c-\\>',
        function()
          require('toggleterm').toggle_all()
        end,
      },
    })

    return keys
  end,
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return vim.o.lines * 0.5 -- Take up half of the screen's height
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4 -- Keep 40% of the screen's width as is
      end
    end,
    open_mapping = [[<c-\>]],
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*toggleterm#*',
      callback = function(event)
        local keymap_ops = require('util.keymaps')

        -- del buffer
        vim.api.nvim_buf_set_keymap(
          0,
          't',
          '<C-q>',
          '<Cmd>lua require("mini.bufremove").delete(0)<CR>',
          keymap_ops('Terminate terminal')
        )

        vim.keymap.set({ 'n' }, 'gf', function()
          local path = vim.fn.expand('<cfile>')

          if path ~= '' then open_path(event.buf, path) end
        end, { buffer = event.buf })
      end,
    })
  end,
}
