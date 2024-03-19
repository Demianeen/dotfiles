local node_close_or_goto_parent = function(state)
  local node = state.tree:get_node()

  if
    (node.type == 'directory' or node:has_children()) and node:is_expanded()
  then
    state.commands.toggle_node(state)
  else
    require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
  end
end

local node_open_or_file_open = function(state)
  local node = state.tree:get_node()

  if node.type == 'directory' or node:has_children() then
    if not node:is_expanded() then
      state.commands.toggle_node(state)
    else
      require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
    end
  else
    state.commands.open(state)
  end
end

local copy_selector = function(state)
  local node = state.tree:get_node()
  local filepath = node:get_id()
  local filename = node.name
  local messages = { { '\nChoose to copy to clipboard:\n', 'Normal' } }
  local modify = vim.fn.fnamemodify

  local results = {
    e = { val = modify(filename, ':e'), msg = 'Extension only' },
    f = { val = filename, msg = 'Filename' },
    F = { val = modify(filename, ':r'), msg = 'Filename w/o extension' },
    h = { val = modify(filepath, ':~'), msg = 'Path relative to Home' },
    c = { val = modify(filepath, ':.'), msg = 'Path relative to CWD' },
    a = { val = filepath, msg = 'Absolute path' },
  }

  for i, result in pairs(results) do
    if result.val and result.val ~= '' then
      vim.list_extend(messages, {
        { ('%s.'):format(i), 'Identifier' },
        { (' %s: '):format(result.msg) },
        { result.val, 'String' },
        { '\n' },
      })
    end
  end

  vim.api.nvim_echo(messages, false, {})

  local result = results[vim.fn.getcharstr()]

  if result and result.val and result.val ~= '' then
    vim.notify('Copied: ' .. result.val)
    vim.fn.setreg('+', result.val)
  end
end

local system_open = function(state)
  local node = state.tree:get_node()
  local path = node:get_id()

  vim.fn.jobstart({ 'open', path }, { detach = true })
end

return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      show_scrolled_off_parent_node = true,
      use_popups_for_input = true,
      popup_border_style = 'rounded',

      event_handlers = {
        {
          -- event = 'neo_tree_buffer_leave', -- then on each vtsls
          -- reinitialization the neo tree is closed
          event = 'file_opened',
          handler = function(_)
            vim.cmd('Neotree close')
          end,
        },
        {
          event = 'neo_tree_popup_input_ready',
          handler = function(state)
            vim.notify(vim.inspect(state))
            vim.cmd('stopinsert')
          end,
        },
      },
      commands = {
        node_open_or_file_open = node_open_or_file_open,
        node_close_or_goto_parent = node_close_or_goto_parent,
        copy_selector = copy_selector,
        system_open = system_open,
      },
      filesystem = {
        filtered_items = {
          never_show = { '.DS_Store', '.git' },
        },
      },
      window = {
        mappings = {
          ['<space>'] = false,
          ['h'] = 'node_close_or_goto_parent',
          ['l'] = 'node_open_or_file_open',
          ['Y'] = 'copy_selector',
          ['O'] = 'system_open',
          -- fzf content of files in the dir under the cursor
          ['g'] = function(state)
            -- get the current node
            local node = state.tree:get_node()
            -- if the node is not a directory, walk up the tree until we find one
            while node and node.type ~= 'directory' do
              local parent_id = node:get_parent_id()
              if parent_id == nil then
                -- we must have reached the root node
                -- this should not happen because the root node is always a directory
                -- but just in case...
                node = nil
                break
              end
              node = state.tree:get_node(parent_id)
            end
            -- if we somehow didn't find a directory, just use the root node
            local path = node and node.path or state.path
            require('telescope.builtin').live_grep({
              search_dirs = { path },
              prompt_title = string.format(
                'Grep in [%s]',
                vim.fs.basename(path)
              ),
            })
          end,
        },
      },
    },
  },
  {
    {
      'antosha417/nvim-lsp-file-operations',
      optional = true,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-neo-tree/neo-tree.nvim',
      },
      opts = {},
    },
  },
}
