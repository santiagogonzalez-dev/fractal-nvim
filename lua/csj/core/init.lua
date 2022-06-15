pcall(require, 'impatient')
local utils = require('csj.utils')

require('csj.disabled')
vim.opt.shadafile = 'NONE'

require('csj.autocommands')
vim.api.nvim_cmd({ cmd = 'colorscheme', args = { 'jetjbp' } }, {}) -- vim.cmd('colorscheme jetjbp')

vim.schedule(function()
   if not vim.opt.loadplugins then
      vim.cmd('runtime plugin/**/*.vim plugin/**/*.lua')
   end
   require('csj.plugins')
   require('csj.netrw')
   require('csj.core.settings')
   require('csj.core.folds')
   require('csj.core.virt-column').setup() -- Moded version of Lukas Reineke's virt-column.nvim
   require('csj.manners')
   vim.notify = require('csj.core.notifications').notify_send
   vim.opt.statusline = '%!v:lua.require("csj.core.statusline").init()'

   utils.conditionals()
   utils.session()
end)
