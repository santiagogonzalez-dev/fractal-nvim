local path = string.format('%s%s', vim.fn.stdpath('config'), '/lua/user/settings.json')
local user = vim.json.decode(table.concat(vim.fn.readfile(path), '\n')) -- User table
local start = require('csj.core.utils.startup')

start.colorscheme(user.colorscheme) -- Apply colorscheme.
start.conditionals(user.conditionals) -- Conditionals to load plugins and modules.
start.opts(user.opts) -- Set some settings.
start.modules(user.modules) -- Load modules specified by the user.
start.session(user.restore) -- Restore cursor and view.

require('csj.core.general') -- General settings.
require('csj.core.autocmds') -- General autocommands.
