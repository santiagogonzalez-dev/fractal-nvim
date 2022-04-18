-- Disable builtins
vim.cmd([[
  filetype off
  filetype indent off
  syntax off
]])
RuntimePath = vim.api.nvim_get_option('runtimepath')
vim.opt.runtimepath = ''
vim.opt.shadafile = 'NONE'

vim.g.loadplugins = false
vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logipat = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchParen = 1
vim.g.loaded_perl_provider = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_spec = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

-- Disable providers
vim.g.loaded_python3_provider = 1
vim.g.loaded_node_provider = 1
vim.g.loaded_ruby_provider = 1
vim.g.loaded_perl_provider = 1

-- Filetype
vim.g.did_load_filetypes = 0 -- Disable filetype.vim
vim.g.do_filetype_lua = 1 -- Enable filetype.lua

require('impatient') -- Impatient.nvim
require('csj.colors') -- Highlight groups modifications
require('csj.core.utils').setup_session() -- Setup the session and load other settings
require('csj.core.netrw')
require('csj.keymaps')
require('csj.autocommands')

-- Async load
local async_load
async_load = vim.loop.new_async(vim.schedule_wrap(function()
    vim.cmd('filetype on')
    vim.cmd('syntax on')

    -- Plugins
    local ok, _ = pcall(require, 'csj.plugins')
    if ok then
        require('csj.plugins.packer_compiled')
    end

    for _, plugins in ipairs {
        'nvim-treesitter',
        'gitsigns.nvim',
        'project.nvim',
        'vim-hexokinase',
        'telescope-ui-select.nvim',
        'telescope.nvim',
        'indent-blankline.nvim',
        'nvim-lspconfig',
        'nvim-cmp',
    } do
        vim.cmd('PackerLoad ' .. plugins)
    end

    require('csj.core')
    require('csj.core.bettertf')
    require('csj.core.folds')
    require('csj.core.virt-column') -- Moded version of Lukas Reineke's virt-column.nvim
    require('csj.filetype')

    vim.api.nvim_create_autocmd('BufWinEnter', {
        group = '_save_sessions',
        desc = 'Persistent configs for all buffers',
        callback = function()
            _G.all_buffers_settings()
        end,
    })
    _G.all_buffers_settings()

    return async_load:close()
end))
async_load:send()
