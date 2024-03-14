return {
  'nvim-neo-tree/neo-tree.nvim',
  opts = {
    event_handlers = {
      {
        -- event = 'neo_tree_buffer_leave', -- then on each vtsls
        -- reinitialization the neo tree is closed
        event = 'file_opened',
        handler = function(_)
          vim.cmd('Neotree close')
        end,
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['n'] = 'add',
          ['N'] = 'add_directory',
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
          ['c'] = {},
          ['cf'] = {
            'copy',
            config = {
              show_path = 'relative', -- "none", "relative", "absolute"
            },
          },
          ['cp'] = function(state)
            local current_file_path = state.tree:get_node().path
            vim.fn.setreg('+', current_file_path)
          end,
          ['cn'] = function(state)
            local current_file_name = state.tree:get_node().name
            vim.fn.setreg('+', current_file_name)
          end,
          ['h'] = function(state)
            local node = state.tree:get_node()
            -- if node.type == 'directory' and node:is_expanded() then
            --   require('neo-tree.sources.filesystem').toggle_directory(
            --     state,
            --     node
            --   )
            -- else
            require('neo-tree.ui.renderer').focus_node(
              state,
              node:get_parent_id()
            )
            -- end
          end,
          ['l'] = function(state)
            local node = state.tree:get_node()
            if node.type == 'directory' then
              if not node:is_expanded() then
                require('neo-tree.sources.filesystem').toggle_directory(
                  state,
                  node
                )
              elseif node:has_children() then
                require('neo-tree.ui.renderer').focus_node(
                  state,
                  node:get_child_ids()[1]
                )
              end
            end
          end,
        },
      },
    },
  },
}
