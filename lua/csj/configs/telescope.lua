local M = {}

local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    return
end
local previewers = require('telescope.previewers')

local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then
            return
        end
        if stat.size > 100000 then
            return
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end

M.project_files = function()
    local opts = require('telescope.themes').get_dropdown({ previewer = false })
    local ok = pcall(require('telescope.builtin').git_files, opts)
    if not ok then
        require('telescope.builtin').find_files(opts)
    end
end

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--column',
            '--hidden',
            '--line-number',
            '--no-heading',
            '--smart-case',
            '--vimgrep',
            '--with-filename',
            '--color=never',
            '--line-number',
            '--trim',
        },
        path_display = { 'smart' },
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        color_devicons = true,
        prompt_prefix = ' ',
        selection_caret = ' ',
        entry_prefix = '  ',
        selection_strategy = 'reset',
        initial_mode = 'insert',
        buffer_previewer_maker = new_maker, -- Ignore big files
        sorting_strategy = 'ascending',
        winblend = 9,
    },
    pickers = {
        find_files = {
            find_files = {
                find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix', '-H' },
            },
        },
    },
})

return M
