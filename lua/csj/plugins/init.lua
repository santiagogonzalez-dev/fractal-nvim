-- LSP, Completion with CMP, Treesitter, Telescope, autopairs, comments and all
-- the other plugins that I use.

local ok, _ = pcall(require, 'csj.plugins.packer')
local ok_compiled, _ = pcall(require, 'csj.plugins.packer_compiled')

if ok and ok_compiled then vim.api.nvim_cmd({
  cmd = 'doautocmd',
  args = { 'User', 'LoadPlugins' },
}, {}) end
