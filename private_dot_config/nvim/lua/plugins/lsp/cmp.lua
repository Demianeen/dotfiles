return {
  'nvim-cmp',
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    opts.completion.keyword_length = 2
  end,
}
