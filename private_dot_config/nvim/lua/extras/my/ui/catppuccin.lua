return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      highlight_overrides = {
        all = function(c)
          return {
            ['@character.printf'] = {
              link = 'SpecialChar',
            },
          }
        end,
      },
      integrations = {
        telescope = {
          enabled = true,
          style = 'nvchad',
        },
      },
    },
  },

  {
    'folke/tokyonight.nvim',
    enabled = false,
  },
}
