vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])

vim.opt.shadafile = 'NONE'

-- Disable default plugins
local disabled_built_ins = {
   '2html_plugin',
   'getscript',
   'getscriptPlugin',
   'gzip',
   'logipat',
   'man',
   'netrw',
   'netrwFileHandlers',
   'netrwPlugin',
   'netrwSettings',
   'perl_provider',
   'python_provider',
   'remote_plugins',
   'rrhelper',
   'ruby_provider',
   'shada_plugin',
   'spec',
   'tar',
   'tarPlugin',
   'vimball',
   'vimballPlugin',
   'zip',
   'zipPlugin',
}

for plugin in pairs(disabled_built_ins) do
   vim.g['loaded_' .. plugin] = 0
end

-- Enable opt-in plugins
vim.g.do_filetype_lua = 1 -- Enable filetype detection in lua

-- Color settings, load first so that it looks pretty while all other settings get loaded
require('csj.colors')

-- Autocommands
require('csj.autocmd')

-- Functions
require('csj.functions')

vim.defer_fn(function()
   vim.opt.shadafile = ''

   -- General keybinds
   require('csj.keymaps').general_keybinds()

   -- Plugins
   require('packer_compiled')
   require('csj.plugins')
   require('csj.core.cmp')

   -- LSP
   require('csj.lsp')
   require('csj.lsp.null-ls')

   vim.cmd([[
        rshada!
        doautocmd BufRead
        syntax on
        filetype on
        filetype plugin indent on
    ]])
end, 0)

-- Deferred configs
function M.load_settings()
   vim.cmd([[
      PackerLoad bufferline.nvim
      PackerLoad gitsigns.nvim
      " PackerLoad lualine.nvim
      PackerLoad nvim-tree.lua
      PackerLoad telescope.nvim
      PackerLoad indent-blankline.nvim

      PackerLoad nvim-colorizer.lua
      PackerLoad vim-hexokinase
      HexokinaseTurnOn
      ColorizerToggle
   ]])

   -- General settings
   require('csj.settings')
end

-- Deferred loading of configs:
-- Load the config after the entirety of Neovim has started
vim.api.nvim_create_autocmd('VimEnter', {
   callback = function()
      vim.defer_fn(M.load_settings, 6)
   end,
})
