-- LSP, Completion with CMP, Treesitter, Telescope, autopairs, comments and all
-- the other plugins that I use.

local ok, _ = pcall(require, 'user.plugins.packer')
local ok_compiled, _ = pcall(require, 'user.plugins.packer_compiled')

if ok and ok_compiled then
  vim.cmd.doautocmd('User LoadPlugins')
end
