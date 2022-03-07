pcall(require, 'impatient') -- Load impatient
require('csj.sectioning').disable_builtins(true) -- Disable builtins
require('csj.colors') -- Color settings
require('csj.autocmd') -- Autocommands
require('csj.functions') -- Functions

vim.defer_fn(function()
   require('csj.keymaps').general_keybinds() -- General keybinds
   require('packer_compiled') -- Compiled file for packer
   require('csj.plugins') -- Plugins
   require('csj.core.cmp') -- CMP
   require('csj.lsp') -- Language Server Protocol
   require('csj.lsp.null-ls') -- Null-LS
   vim.g.do_filetype_lua = 1 -- FileType detection in lua
   require('csj.sectioning').disable_builtins(false) -- Enable builtin plugins again
end, 1)

-- Deferred configs
function M.load_settings()
   vim.cmd([[
      PackerLoad bufferline.nvim
      PackerLoad gitsigns.nvim
      PackerLoad nvim-tree.lua
      PackerLoad indent-blankline.nvim
      " PackerLoad lsp_lines.nvim
      PackerLoad nvim-colorizer.lua
      PackerLoad vim-hexokinase
      HexokinaseTurnOn
      ColorizerToggle
   ]])
   require('csj.settings') -- General settings
end

-- Deferred loading of configs
vim.api.nvim_create_autocmd('VimEnter', {
   callback = function()
      vim.defer_fn(M.load_settings, 1)
   end,
})
