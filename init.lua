pcall(require, 'impatient')
require('csj.keymaps')
require('csj.colors')

vim.g.did_load_filetypes = 0 -- Disable filetype.vim
vim.g.do_filetype_lua = 1 -- Enable filetype.lua

local ok_plugins, _ = pcall(require, 'csj.plugins')
if ok_plugins then
    require('csj.plugins.packer_compiled')
    for _, plugin in ipairs {
        'nvim-treesitter',
        'gitsigns.nvim',
        'project.nvim',
        'telescope.nvim',
        'indent-blankline.nvim',
        'vim-hexokinase',
        'nvim-lspconfig',
        'nvim-cmp',
    } do
        vim.cmd('PackerLoad ' .. plugin)
    end
end

require('csj.disabled')
require('csj.autocommands')
require('csj.core')
require('csj.utils').setup_session() -- Setup the session and load other settings
require('csj.filetype') -- FTPlugin casero
