pcall(require, 'impatient')
local utils = require('csj.utils')

require('csj.disabled')
vim.opt.shadafile = 'NONE'

require('csj.autocommands')
vim.api.nvim_cmd({ cmd = 'colorscheme', args = { 'jetjbp' } }, {})

vim.schedule(function()
   if not vim.opt.loadplugins then
      return vim.api.nvim_cmd({
         cmd = 'runtime',
         args = {
            'plugin/**/*.lua',
            'plugin/**/*.vim',
         },
         bang = true,
      }, {})
   end

   require('csj.plugins')
   require('csj.manners')
   require('csj.netrw')
   require('csj.core.settings')
   require('csj.core.folds')
   require('csj.core.virt-column').setup() -- Moded version of Lukas Reineke's virt-column.nvim
   vim.notify = require('csj.core.notifications').notify_send
   vim.opt.statusline = '%!v:lua.require("csj.core.statusline").init()'

   utils.conditionals()
   utils.session()
end)
