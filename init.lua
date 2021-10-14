                            -- DISABLED SETTINGS --

-- Disable certain sections in :checkhealth
vim.tbl_map(
    function(p)
        vim.g['loaded_' .. p] = vim.endswith(p, 'provider') and 0 or 0
    end,
    {
        'perl_provider',
        'python_provider',
        'ruby_provider',
    }
)

-- Disable certain builtin plugins
local disabled_built_ins = {
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'zip',
    'zipPlugin',
    'logipat',
    'matchit', 'matchparen',
    'netrw',
    'netrwPlugin',
    'netrwFileHandlers',
    'netrwSettings',
    'remote_plugins',
    'tar',
    'rrhelper',
    'tarPlugin',
    'shada_plugin',
    'spec',
    'tutor_mode_plugin',
    'vimball',
    'vimballPlugin',
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g['loaded_' .. plugin] = 1
end

-- Plugins, configs and keymappings, some will have them in lua/configs
require('plugins')

-- Most of the settings
require('settings')

-- Keymappings native to Neovim
require('keymappings')

-- Autocammands and stuff that should be done automatically
require('automation')
