local getcwd = function()
  local file = vim.fn.expand('%:p')
  -- to run inside a package root if exist
  if string.find(file, '/packages/') then
    return string.match(file, '(.-/[^/]+/)src')
  end
  return vim.fn.getcwd()
end

return {
  'nvim-neotest/neotest',
  dependencies = {
    'haydenmeade/neotest-jest',
  },
  opts = function(_, opts)
    table.insert(
      opts.adapters,
      require('neotest-jest')({
        -- jestCommand = function()
        --   local package_json_path = getcwd() .. '/package.json'
        --
        --   local package_json_content = vim.fn.readfile(package_json_path)
        --
        --   -- If the file is not empty
        --   if next(package_json_content) ~= nil then
        --     package_json_content = table.concat(package_json_content, '')
        --     local decoded_json = vim.fn.json_decode(package_json_content)
        --
        --     if
        --       decoded_json
        --       and decoded_json.scripts
        --       and decoded_json.scripts['test:unit']
        --     then
        --       return 'npm run test:unit --'
        --     end
        --   end
        --   return 'npm test --'
        -- end,
        jestCommand = 'npm test --',
        -- jestConfigFile = function()
        --   local cwd = vim.fn.getcwd()
        --   local package_json_path = cwd .. '/package.json'
        --   local package_json_content = vim.fn.readfile(package_json_path)
        --
        --   -- Check if the file read is successful
        --   if next(package_json_content) == nil then
        --     print('package.json is empty or does not exist')
        --     return cwd .. 'jest.config.ts'
        --   end
        --
        --   package_json_content = table.concat(package_json_content, '')
        --   local decoded_json = vim.fn.json_decode(package_json_content)
        --
        --   -- Check if scripts exists and specifically test script
        --   if
        --     decoded_json
        --     and decoded_json.scripts
        --     and decoded_json.scripts.test
        --   then
        --     local test_script = decoded_json.scripts.test
        --
        --     -- Pattern to match the --config argument
        --     local config_arg_pattern = '%-%-config%s([%w%./_-]+)'
        --     local config_path = test_script:match(config_arg_pattern)
        --
        --     if config_path then return config_path end
        --   end
        --
        --   print('No test script/config path found in package.json')
        --   return cwd .. 'jest.config.ts'
        -- end,
        env = { CI = true },
        cwd = getcwd,
      })
    )
  end,
}
