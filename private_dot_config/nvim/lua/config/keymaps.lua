require('config.keymaps.disable_lazyvim_keymaps')
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = require('util.keymaps')

vim.g.mapleader = ' '

-- redo
vim.keymap.set('n', 'U', '<C-r>', opts('Redo'))

-- paste/delete and not copy
vim.keymap.set(
  'x',
  '<leader>p',
  '"_dP',
  opts('Paste and delete without yanking')
)
vim.keymap.set('n', 'x', '"_x', opts('Delete char without yanking'))
vim.keymap.set('n', 'X', '"_x', opts('Delete char backwards without yanking'))

-- redo
vim.keymap.set('n', 'U', '<C-r>', opts('Redo'))

-- paste/delete and not copy
vim.keymap.set(
  'x',
  '<leader>p',
  '"_dP',
  opts('Paste and delete without yanking')
)
vim.keymap.set(
  { 'n', 'v' },
  '<leader>d',
  [["_d]],
  opts('Delete without yanking')
)
vim.keymap.set('n', 'x', '"_x', opts('Delete char without yanking'))
vim.keymap.set('n', 'X', '"_x', opts('Delete char backwards without yanking'))

-- -- allows to move selected code up and down
-- vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts('Move selection down'))
-- vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts('Move selection up'))

-- concats strings but leaves cursor in place
-- vim.keymap.set(
--   'n',
--   'J',
--   'J<C-o>',
--   opts('Join lines and restore cursor position')
-- )

-- half page down/up, but centers page
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', opts('Half page down and center'))
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', opts('Half page up and center'))

-- next/previous search result, but centers page and folded code unfolds
vim.keymap.set('n', 'n', 'nzzzv', opts('Next search result with centering'))
vim.keymap.set('n', 'N', 'Nzzzv', opts('Previous search result with centering'))

-- disable Q
vim.keymap.set('n', 'Q', '<nop>', opts('Disable Q'))

-- -- swap between projects in one window
-- vim.keymap.set(
--   'n',
--   '<C-f>',
--   '<cmd>silent !tmux neww tmux-sessionizer<CR>',
--   opts('Swap projects in tmux')
-- )

-- turns off highlight
vim.keymap.set('n', '<Esc><Esc>', ':noh<CR>', opts('Turn off search highlight'))

-- Open new line on ctrl enter in insert mode
vim.keymap.set(
  'i',
  '<C-CR>',
  '<Esc>o',
  opts('Ctrl-Enter in insert mode: open new line')
)

-- auto regex search & replace
vim.keymap.set(
  'n',
  '<leader>rs',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  opts('Select word for a search & replace')
)

-- makes file executable
vim.keymap.set(
  'n',
  '<leader>fx',
  '<cmd>!chmod +x %<CR>',
  opts('Make file executable')
)
vim.keymap.set(
  'n',
  '<leader>fX',
  '<cmd>!chmod -x %<CR>',
  opts('Make file NOT executable')
)

local wk = require('which-key')
wk.register({
  fc = {
    name = 'Copy',
  },
}, { prefix = '<leader>' })

vim.keymap.set(
  'n',
  '<leader>fcr',
  ":call setreg('+', expand('%'))<CR>",
  opts('Relative file path')
)

vim.keymap.set('v', '<leader>d', function()
  -- Get the start and end of the visual selection
  local start_line, _, end_line, _ = unpack(vim.fn.getpos("'<"), 2, 5)

  -- Iterate through the selected lines
  for i = start_line, end_line do
    -- Generate the new line text with the line number prefix
    local new_line_text = tostring(i - start_line + 1)
      .. '. '
      .. vim.fn.getline(i)
    -- Replace the line with the new text
    vim.fn.setline(i, new_line_text)
  end
end, opts('Number visual selection'))

vim.api.nvim_create_user_command('OpenGitHubRepo', function()
  local word_under_cursor = vim.fn.expand('<cWORD>')
  local github_identifier = word_under_cursor:sub(2, -3)

  vim.notify(github_identifier)
  local url = 'https://github.com/' .. github_identifier
  vim.fn.system('open ' .. url)
end, {})
vim.api.nvim_set_keymap(
  'n',
  '<leader>gB',
  ':OpenGitHubRepo<CR>',
  opts('Open plugin in browser')
)

function CdToGit()
  -- Find the .git directory starting from the current file's directory
  local git_root = vim.fn.finddir('.git', vim.fn.expand('%:p:h') .. ';')

  -- If a .git directory is found, change the directory to it
  if git_root ~= '' then
    -- Remove the .git from the path to get the root
    local project_root = vim.fn.fnamemodify(git_root, ':h')
    -- Change the directory to .git
    vim.cmd('cd ' .. project_root)
    print('Changed dir to ' .. project_root)
  else
    lazyvim_root = LazyVim.root()
    vim.cmd('cd ' .. lazyvim_root)
    print('Changed dir to ' .. lazyvim_root)
  end
end

vim.keymap.set('n', '<leader>fC', CdToGit, opts('Change cd'))

function Close_diff_buffers()
  local bufnr1 = vim.fn.bufnr('%') -- Get the buffer number of the current window
  vim.cmd('wincmd w') -- Move to the next window
  local bufnr2 = vim.fn.bufnr('%')
  vim.cmd('bd ' .. bufnr1)
  vim.cmd('bd ' .. bufnr2)
end

local function compare_to_clipboard()
  local ftype = vim.api.nvim_eval('&filetype')
  vim.cmd(string.format(
    [[
    execute "normal! \"xy"
    vsplit
    enew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
		lua LazyVim.format({ force = true })
		lua vim.bo.buflisted = false
		lua vim.keymap.set("n", "q", "<cmd>lua Close_diff_buffers()<cr>", { buffer = 0, silent = true })
    diffthis
    execute "normal! \<C-w>\<C-w>"
    enew
    set filetype=%s
    normal! "xP
		setlocal buftype=nowrite
    lua LazyVim.format({ force = true })
    lua vim.bo.buflisted = false
    lua vim.keymap.set("n", "q", "<cmd>lua Close_diff_buffers()<cr>", { buffer = 0, silent = true })
    diffthis
  ]],
    ftype,
    ftype
  ))
end

vim.keymap.set('x', '<leader>xC', compare_to_clipboard)

vim.keymap.set('n', '<leader>cS', function()
  local input = vim.fn.input('Enter URL endpoint: ')
  local response =
    vim.fn.system('json2struct -s "$(curl -s \'' .. input .. '\')"')
  local buf = vim.api.nvim_get_current_buf()
  local lines = {}
  for line in response:gmatch('[^\r\n]+') do
    table.insert(lines, line)
  end
  local newLines = {}
  for i = 3, #lines do
    table.insert(newLines, lines[i])
  end
  local current_cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1
  vim.api.nvim_buf_set_lines(
    buf,
    current_cursor_line,
    current_cursor_line,
    false,
    newLines
  )
end, opts('Json to struct'))

vim.keymap.set('n', '<leader>qt', ':tabclose<CR>')

if vim.fn.executable('lazydocker') == 1 then
  vim.keymap.set('n', '<leader>D', function()
    LazyVim.terminal('lazydocker', { esc_esc = false, ctrl_hjkl = false })
  end, opts('Lazydocker'))
end
