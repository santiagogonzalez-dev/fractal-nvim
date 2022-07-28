local start = require('csj.core.start')
local user = require('csj.core.userspace').load_userspace() -- Load userspace and return a table with user settings.

require('csj.plugins') -- Load plugins and package manager.
require('csj.core.general') -- General and common settings.
require('csj.core.autocmds') -- Some common autocommands.

start.disable(user.disable_builtins)
start.colorscheme(user.colorscheme) -- Apply colorscheme.
start.modules_load(user.early_modules) -- Some modules can't be lazyloaded.

vim.schedule(function()
  start.session(user.restore) -- Restore cursor and view.
  start.conditionals(user.conditionals) -- Conditionals to load plugins and modules.
  start.settings(user.opts) -- Set some settings.
  start.modules_load(user.modules) -- Load modules specified by the user.
end)
