pcall(require, 'impatient')

local utils = require('csj.utils')
require('csj.disabled')

vim.opt.shadafile = 'NONE'

require('csj.autocommands')
require('csj.manners')
utils.setup_session() -- Setup the session and load other settings
vim.api.nvim_cmd({ cmd = 'colorscheme', args = { 'jetjbp' } }, {}) -- vim.cmd('colorscheme jetjbp')

vim.schedule(function()
   if not vim.opt.loadplugins then
      return vim.api.nvim_cmd({
         cmd = 'runtime',
         args = {
            'plugin/**/*.vim',
            'plugin/**/*.lua',
         },
         bang = true,
      }, {}) -- vim.cmd('runtime! plugin/**/*.vim plugin/**/*.lua')
   end

   vim.opt.shadafile = ''
   vim.api.nvim_cmd({ cmd = 'rshada', bang = true }, {}) -- vim.cmd('rshada!')
   vim.api.nvim_exec_autocmds('BufEnter', {})

   local ok, packer = pcall(require, 'csj.plugins')
   local ok_comp, _ = pcall(require, 'csj.plugins.packer_compiled')

   if ok and ok_comp then
      packer.loader('nvim-treesitter')
      packer.loader('nvim-cmp')
      packer.loader('nvim-lspconfig')
      packer.loader('indent-blankline.nvim')
      packer.loader('nvim-colorizer.lua')
   end
   utils.is_git()

   return require('csj.core')
end)
