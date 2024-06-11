return {
  {
    'shortcuts/no-neck-pain.nvim',
    event = 'BufEnter',
    opts = {
      width = 80,
      --- @type table
      mappings = {
        -- When `true`, creates all the mappings that are not set to `false`.
        --- @type boolean
        enabled = true,
        -- Sets a global mapping to Neovim, which allows you to toggle the plugin.
        --- @type string
        toggle = '<Leader>uNp',
        -- Sets a global mapping to Neovim, which allows you to toggle the left side buffer.
        --- @type string
        toggleLeftSide = '<Leader>uNql',
        -- Sets a global mapping to Neovim, which allows you to toggle the right side buffer.
        --- @type string
        toggleRightSide = '<Leader>uNqr',
        --- @type string | { mapping: string, value: number }
        widthUp = { mapping = '<Leader>uN=', value = 20 },
        --- @type string | { mapping: string, value: number }
        widthDown = { mapping = '<Leader>uN-', value = 20 },
        -- Sets a global mapping to Neovim, which allows you to toggle the scratchpad feature.
        --- @type string
        scratchPad = '<Leader>uNs',
      },
      autocmds = {
        enableOnVimEnter = false,
        -- When `true`, reloads the plugin configuration after a colorscheme change.
        -- skipEnteringNoNeckPainBuffer = true,
      },
      -- buffers = {
      --   scratchPad = {
      --     enabled = false,
      --     fileName = 'NeovimNotes',
      --     -- set to `nil` to default
      --     -- to current working directory
      --     location = '~/Documents/',
      --   },
      --   bo = {
      --     filetype = 'markdown',
      --   },
      -- },
    },
  },
  {
    'folke/which-key.nvim',
    opts = function(_, _)
      local wk = require('which-key')
      wk.register({
        uN = {
          name = 'Neck pain',
        },
        unq = {
          name = 'Toggle sides',
        },
      }, { prefix = '<leader>' })
    end,
  },
}
