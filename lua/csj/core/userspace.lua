local config_path = vim.fn.stdpath('config')
local user

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

-- Get user settings
user = dofile(string.format('%s%s', config_path, '/user/init.lua'))

return user
