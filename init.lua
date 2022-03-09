pcall(require, 'impatient') -- Load impatient

vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])
vim.opt.shadafile = 'NONE'

local plugins_list = {
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logipat',
    'man',
    'matchit',
    'matchparen',
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

for plugin in pairs(plugins_list) do
    vim.g['loaded_' .. plugin] = 1
end

require('csj.colors') -- Color settings
require('csj.autocmd') -- Autocommands
require('csj.functions') -- Functions
require('csj.keymaps').general_keybinds() -- General keybinds
vim.g.do_filetype_lua = 1 -- FileType detection in lua

vim.defer_fn(function()
    vim.opt.shadafile = ''
    vim.cmd([[
        rshada!
        syntax on
        filetype on
        filetype plugin indent on
    ]])
    require('csj.plugins') -- Plugins
    require('packer_compiled') -- Compiled file for packer
    require('csj.core.cmp') -- CMP
    require('csj.lsp') -- Language Server Protocol
end, 0)

-- Deferred configs
function M.load_settings()
    vim.cmd([[
        PackerLoad bufferline.nvim
        PackerLoad gitsigns.nvim
        PackerLoad nvim-treesitter
        PackerLoad indent-blankline.nvim
        PackerLoad nvim-colorizer.lua
        PackerLoad vim-hexokinase
        HexokinaseTurnOn
        ColorizerToggle
    ]])

    require('csj.settings') -- General settings
end

-- Deferred loading of configs
vim.api.nvim_create_autocmd('UIEnter', {
    group = '_first_load',
    once = true,
    callback = function()
        vim.defer_fn(M.load_settings, 3)
    end,
})
