-- LSP, Completion with CMP, Treesitter, Telescope, autopairs, comments and all
-- the other plugins that I use.

require("plugins.packer").setup()
pcall(require, "plugins.packer_compiled")

-- vim.api.nvim_create_autocmd('UIEnter', {
--    callback = function()
--       vim.defer_fn(function()
--          vim.cmd.doautocmd('User LoadPlugins')
--          vim.cmd(':e')
--       end, 30)
--    end,
-- })

vim.cmd.doautocmd "User LoadPlugins"
