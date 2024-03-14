-- nvim tree auto rename on didRename
local path_sep = package.config:sub(1, 1)

local function trim_sep(path)
  return path:gsub(path_sep .. '$', '')
end

local function uri_from_path(path)
  local uri = vim.uri_from_fname(trim_sep(path))
  return uri
end

local function is_sub_path(path, folder)
  path = trim_sep(path)
  folder = trim_sep(folder.name)
  if path == folder then
    return true
  else
    return path:sub(1, #folder + 1) == folder .. path_sep
  end
end

local function check_folders_contains(folders, path)
  for _, folder in pairs(folders) do
    if is_sub_path(path, folder) then return true end
  end

  return false
end

local function match_file_operation_filter(filter, name, type)
  if filter.scheme and filter.scheme ~= 'file' then
    -- we do not support uri scheme other than file
    return false
  end
  local pattern = filter.pattern
  local matches = pattern.matches

  if type ~= matches then return false end

  local regex_str = vim.fn.glob2regpat(pattern.glob)
  if vim.tbl_get(pattern, 'options', 'ignoreCase') then
    regex_str = '\\c' .. regex_str
  end

  local match = vim.regex(regex_str):match_str(name) ~= nil
  return match
end

return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.event_handlers, {
        {
          event = 'file_renamed',
          handler = function(args)
            local old_name = args.source
            local new_name = args.destination
            local stat = vim.loop.fs_stat(new_name)
            if not stat then return end
            local type = ({ file = 'file', directory = 'folder' })[stat.type]
            local clients = vim.lsp.get_active_clients({})
            for _, client in ipairs(clients) do
              if check_folders_contains(client.workspace_folders, old_name) then
                local filters = vim.tbl_get(
                  client.server_capabilities,
                  'workspace',
                  'fileOperations',
                  'didRename',
                  'filters'
                ) or {}
                for _, filter in pairs(filters) do
                  if
                    match_file_operation_filter(filter, old_name, type)
                    and match_file_operation_filter(filter, new_name, type)
                  then
                    client.notify('workspace/didRenameFiles', {
                      files = {
                        {
                          oldUri = uri_from_path(old_name),
                          newUri = uri_from_path(new_name),
                        },
                      },
                    })
                  end
                end
              end
            end
          end,
        },
      })
    end,
  },
}
