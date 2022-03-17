pcall(require, 'impatient') -- Load impatient

vim.g.did_load_filetypes = 0 -- Disable filetype.vim
vim.g.do_filetype_lua = 1 -- Enable filetype.lua

-- Disable builtin plugins
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

require('csj.core.colors') -- Color settings
require('csj.core.autocmd') -- Autocommands
require('csj.core.functions') -- Functions
require('csj.core.keymaps').general_keybinds() -- General keybinds
require('csj.plugins') -- Plugins

function M.load_settings()
    vim.cmd([[
        PackerLoad gitsigns.nvim
        PackerLoad nvim-treesitter
        PackerLoad nvim-treehopper
        PackerLoad indent-blankline.nvim
        PackerLoad nvim-colorizer.lua
        PackerLoad vim-hexokinase
        HexokinaseTurnOn
        ColorizerToggle
    ]])
    require('csj.core.settings') -- General settings
end

-- Deferred loading of configs
vim.api.nvim_create_autocmd('UIEnter', {
    group = '_first_load',
    once = true,
    callback = function()
        vim.defer_fn(M.load_settings, 3)
    end,
})
