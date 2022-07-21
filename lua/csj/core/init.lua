local config_path = vim.fn.stdpath('config')
local utils = require('csj.core.utils')
local user = dofile(string.format('%s%s', config_path, '/user/init.lua'))

-- Some settings are stored under `./user`, so add it to the lua path
package.path = table.concat {
  package.path,
  ';',
  config_path,
  '/user/?.lua;',
  config_path,
  '/user/?/init.lua;',
}

utils.disable(user.disable_builtins) -- Whether or not to disable builtin plugins.
utils.colorscheme(user.colorscheme) -- Apply colorscheme.
utils.conditionals() -- Conditionals to load plugins and modules.

require('csj.plugins') -- Load plugins.
require('csj.core.autocmds') -- Some common autocommands.
require('csj.core.keymaps')
require('csj.core.afiolb') -- Ask user for input if there is only one active normal buffer.

-- Load modules and settings specified by the user
utils.settings(user.opts) -- Set some settings.
utils.session(user.restore) -- Restore cursor and view.

for k, v in pairs(user.modules) do
  utils.load(v, k)
end

local json = {}

json.show = function()
  return vim.fn.json_decode(table.concat(vim.fn.readfile('/home/st/.config/nvim/user/example.json'), '\n'))
end

return json
