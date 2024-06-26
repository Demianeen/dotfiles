return {
  'moyiz/git-dev.nvim',
  event = 'VeryLazy',

  opts = {
    cd_type = 'tab',
    opener = function(dir, repo_uri)
			-- stylua: ignore start
			local to_open = vim.iter({ "README.md", "readme.md", "README", "README.txt", "readme.txt" })
				:map(function(f) return vim.fs.joinpath(dir, f) end)
				:find(vim.uv.fs_stat)
      -- stylua: ignore end

      local cmd = to_open and 'e ' .. to_open .. ' | Neotree show'
        or 'Neotree dir=' .. dir

      vim.cmd('tabnew | ' .. cmd)

      vim.schedule(function()
        vim.print('Opening ' .. repo_uri)
      end)
    end,
  },

  keys = {
    {
      '<leader>gr',
      function()
        local url = vim.fn.expand('<cfile>')
        print(url)

        if not url or url == '' then return end

        local gdev_path = vim.fn.stdpath('cache') .. '/git-dev'
        print('gdev', gdev_path)
        local is_gdev = vim.startswith(vim.fn.expand('%:p'), gdev_path)
        local opener = is_gdev
            and vim.bo.filetype == 'markdown'
            and require('git-dev').open
          or vim.ui.open

        opener(url)
      end,
      desc = 'Open a remote git repository; open (tab)',
    },

    {
      '<leader>gR',
      function()
        local uri = vim.fn.input('uri (author/repo): ')

        if uri == '' then return end

        vim.ui.select(
          { 'gitdev', 'browser' },
          { prompt = 'Select opener' },
          function(choice)
            if choice == 'gitdev' then
              vim.cmd('GitDevOpen ' .. uri)
            elseif choice == 'browser' then
              vim.ui.open(uri)
            end
          end
        )
      end,
      desc = 'Enter a remote git repository; open (tab)',
    },
  },
}
