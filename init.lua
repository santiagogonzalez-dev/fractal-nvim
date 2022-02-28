vim.cmd([[
    syntax off
    filetype off
    filetype plugin indent off
]])

vim.opt.shadafile = "NONE"

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

require('csj.settings') -- General settings
require('csj.colors') -- Color settings
require('csj.autocmd') -- Autocommands
require('csj.keymaps').general_keybinds() -- General keybinds

vim.defer_fn(function()
    vim.opt.shadafile = ''

    -- Functions
    require('csj.functions')

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
