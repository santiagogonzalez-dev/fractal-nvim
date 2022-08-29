local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
return
end

local previewers = require('telescope.previewers')
local previewers_utils = require('telescope.previewers.utils')

-- Themes
local clean_dropdown = require('telescope.themes').get_dropdown {
previewer = false,
} -- Dropdown Theme

local function project_files()
local opts = vim.deepcopy(clean_dropdown)
local ok = pcall(require('telescope.builtin').git_files, opts)
if not ok then
return require('telescope.builtin').find_files(opts)
end
end

telescope.setup {
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
-- buffer_previewer_maker = function(filepath, bufnr, opts)
--     -- Do not preview binaries
--     filepath = vim.fn.expand(filepath)
--     require('plenary.job'):new {
--         command = 'file',
--         args = { '--mime-type', '-b', filepath },
--         on_exit = function(j)
--             local mime_type = vim.split(j:result()[1], '/')[1]
--             if mime_type == 'text' then
--                 previewers.buffer_previewer_maker(filepath, bufnr, opts)
--             else
--                 -- maybe we want to write something to the buffer here
--                 vim.schedule(function()
--                     vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
--                 end)
--             end
--         end,
--     }
-- end,
preview = {
filesize_hook = function(filepath, bufnr, opts)
-- If the file is very big only print the head of the it
local cmd = { 'head', '-c', 1000000, filepath }
previewers_utils.job_maker(cmd, bufnr, opts)
end,
},
sorting_strategy = 'ascending',
winblend = 9,
},
}

telescope.load_extension('projects')

vim.keymap.set('n', '<Leader>gr', '<CMD>Telescope lsp_references theme=dropdown<CR>')
vim.keymap.set('n', '<Leader>t/', '<CMD>Telescope live_grep theme=dropdown<CR>')
vim.keymap.set('n', '<Leader>t//', '<CMD>Telescope current_buffer_fuzzy_find theme=dropdown<CR>')
vim.keymap.set('n', '<Leader>tf', project_files)
vim.keymap.set('n', '<Leader>tg', '<CMD>Telescope grep_string<CR>')
vim.keymap.set('n', '<Leader>tp', '<CMD>Telescope projects<CR>')
vim.keymap.set('n', '<Leader>tt', '<CMD>Telescope<CR>')
