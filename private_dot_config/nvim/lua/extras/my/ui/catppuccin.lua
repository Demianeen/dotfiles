local function dec2hex(n_value)
  if type(n_value) == 'string' then n_value = tonumber(n_value) end

  local n_hex_val = string.format('%X', n_value)
  local s_hex_val = n_hex_val .. ''

  if n_value < 16 then
    return '0' .. tostring(s_hex_val)
  else
    return s_hex_val
  end
end

local function blend(color_first, color_second, percentage)
  local r1, g1, b1 = string.upper(color_first):match(
    '#([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])'
  )
  local r2, g2, b2 = string.upper(color_second):match(
    '#([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])'
  )

  local r3 = tonumber(r1, 16) * (100 - percentage) / 100.0
    + tonumber(r2, 16) * percentage / 100.0
  local g3 = tonumber(g1, 16) * (100 - percentage) / 100.0
    + tonumber(g2, 16) * percentage / 100.0
  local b3 = tonumber(b1, 16) * (100 - percentage) / 100.0
    + tonumber(b2, 16) * percentage / 100.0

  return '#' .. dec2hex(r3) .. dec2hex(g3) .. dec2hex(b3)
end

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
            MiniIconsAzure = { fg = blend(c.sapphire, c.mantle, 25) },
            MiniIconsBlue = { fg = blend(c.blue, c.mantle, 25) },
            MiniIconsCyan = { fg = blend(c.teal, c.mantle, 25) },
            MiniIconsGreen = { fg = blend(c.green, c.mantle, 25) },
            MiniIconsGrey = { fg = blend(c.text, c.mantle, 25) },
            MiniIconsOrange = { fg = blend(c.peach, c.mantle, 25) },
            MiniIconsPurple = { fg = blend(c.mauve, c.mantle, 25) },
            MiniIconsRed = { fg = blend(c.red, c.mantle, 25) },
            MiniIconsYellow = { fg = blend(c.yellow, c.mantle, 25) },
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
