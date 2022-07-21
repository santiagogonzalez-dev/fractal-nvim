local user = {}
local config_path = vim.fn.stdpath('config')


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

---@param location string @ Most of the time it's going to be `./user/user_settings.json`
---@return table @ Table with all the user preferences
function user.get_config(location)
  local path = string.format('%s%s', config_path, location)
  return vim.json.decode(table.concat(vim.fn.readfile(path), '\n'))
end

---This function has two parts, one that loads the lua files under `./user`
---and the second part where we get the table with all the settings and
---preferences from the user.
---@return table @ Table with all the user preferences
function user.load_userspace()
  user.load_user_init() -- First part
  return user.get_config('/user/user_settings.json') -- Second part
end

return user
