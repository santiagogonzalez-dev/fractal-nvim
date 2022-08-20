local user = {}
local config_path = vim.fn.stdpath('config')

-- We now put `./user` under `./lua/user` so there's no need to load a file like
-- we do in this function
---@deprecated
function user.load_user_init()
  -- Some settings are stored under `./user`, add it to the lua path so that the
  -- user can require the files under there too.
  package.path = table.concat {
    package.path,
    ';',
    config_path,
    '/user/?.lua;',
    config_path,
    '/user/?/init.lua;',
  }

  -- Run the init.lua file for user specific actions
  dofile(string.format('%s%s', config_path, '/user/init.lua'))
end

-- Most of the time it's going to be `./lua/user/settings.json`, and we receive
-- a lua table with all the user preferences
---@param location string
---@return table @ Table with all the user preferences
function user.settings(location)
  local path = string.format('%s%s', config_path, location)
  return vim.json.decode(table.concat(vim.fn.readfile(path), '\n'))
end

return user
