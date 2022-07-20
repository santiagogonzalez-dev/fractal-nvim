local config_path = vim.fn.stdpath('config')
local utils = require('csj.core.utils')
local user

-- Load plugins
require('csj.plugins')

-- Load core modules: An attempt to override some defaults, like fold settings,
-- notifications, netrw settings, colorcolumn and other behavior.
require('csj.core.netrw') -- NetRW config.
require('csj.core.autocmds') -- Some common autocommands.
require('csj.core.general') -- Some general settings
require('csj.core.keymaps') -- Common keybinds and remappings.
require('csj.core.status') -- Simple pure lua statusline, winbar and other indicators.
require('csj.core.sdmog') -- Show where the . mark is in the file with an icon on the sign column(gutter).
require('csj.core.strict_cursor') -- Adds a second mode cursor.
require('csj.core.afiolb') -- Ask user for input if there is only one active normal buffer.

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

utils.colorscheme(user.colorscheme) -- Apply colorscheme.
utils.settings(user.opts) -- Set some settings.
utils.disable(user.restore) -- Disable builtin plugins.
utils.session() -- Restore cursor and view.
utils.conditionals() -- Conditionals to load plugins and modules.

-- Load modules specified by the user
for k, v in pairs(user.modules) do
  utils.load(v, k)
end
