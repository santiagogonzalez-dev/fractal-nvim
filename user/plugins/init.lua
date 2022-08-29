-- LSP, Completion with CMP, Treesitter, Telescope, autopairs, comments and all
-- the other plugins that I use.

require 'plugins.packer'.setup()
pcall(require, 'plugins.packer_compiled')
vim.cmd.doautocmd 'User LoadPlugins'
