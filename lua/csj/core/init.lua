local config_path = vim.fn.stdpath('config')
local utils = require('csj.core.utils')
local user

-- Some settings are stored under `./user`, so add it to the lua path
package.path = table.concat {
  package.path,
  ';',
  config_path,
  '/user/?.lua;',
  config_path,
  '/user/?/init.lua;',
}

-- This should define some user settings and return a table with user configs
user = dofile(string.format('%s%s', config_path, '/user/init.lua'))

utils.disable(user.disable_builtins) -- Whether or not to disable builtin plugins.
utils.colorscheme(user.colorscheme) -- Apply colorscheme.

-- Load plugins
require('csj.plugins')

utils.conditionals() -- Conditionals to load plugins and modules.

-- Load core modules
require('csj.core.autocmds') -- Some common autocommands.
require('csj.core.status') -- Simple pure lua statusline, winbar and other indicators.
require('csj.core.sdmog') -- Show where the . mark is in the file with an icon on the sign column(gutter).
require('csj.core.strict_cursor') -- Adds a second mode cursor.
require('csj.core.afiolb') -- Ask user for input if there is only one active normal buffer.

-- Load modules and settings specified by the user
utils.settings(user.opts) -- Set some settings.
utils.session(user.restore) -- Restore cursor and view.

for k, v in pairs(user.modules) do
  utils.load(v, k)
end
