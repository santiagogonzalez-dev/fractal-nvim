local M = {}

local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    return
end

local actions = require('telescope.actions')

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
        selection_strategy = 'reset',
        initial_mode = 'insert',
        sorting_strategy = 'ascending',
        file_ignore_patterns = {
            '.git/.*',
            '.next/.*',
            '.venv/.*',
            '__pycache__',
            'bin/.*',
            'dist/.*',
            'node_modules/.*',
            'target/.*',
            '*.egg-info',
        },
        set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
        color_devicons = true,
        use_less = false,
        winblend = 20,
        path_display = { 'smart' },
        prompt_prefix = ' ',
        selection_caret = ' ',
        entry_prefix = '  ',
        mappings = {
            i = {
                ['<C-n>'] = actions.cycle_history_next,
                ['<C-p>'] = actions.cycle_history_prev,

                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,

                ['<C-c>'] = actions.close,

                ['<Down>'] = actions.move_selection_next,
                ['<Up>'] = actions.move_selection_previous,

                ['<CR>'] = actions.select_default,
                ['<C-x>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-t>'] = actions.select_tab,

                ['<C-u>'] = actions.preview_scrolling_up,
                ['<C-d>'] = actions.preview_scrolling_down,

                ['<PageUp>'] = actions.results_scrolling_up,
                ['<PageDown>'] = actions.results_scrolling_down,

                ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                ['<C-l>'] = actions.complete_tag,
            },
            n = {
                ['<esc>'] = actions.close,
                ['<CR>'] = actions.select_default,
                ['<C-x>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-t>'] = actions.select_tab,

                ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

                ['j'] = actions.move_selection_next,
                ['k'] = actions.move_selection_previous,
                ['H'] = actions.move_to_top,
                ['M'] = actions.move_to_middle,
                ['L'] = actions.move_to_bottom,

                ['<Down>'] = actions.move_selection_next,
                ['<Up>'] = actions.move_selection_previous,
                ['gg'] = actions.move_to_top,
                ['G'] = actions.move_to_bottom,

                ['<C-u>'] = actions.preview_scrolling_up,
                ['<C-d>'] = actions.preview_scrolling_down,

                ['<PageUp>'] = actions.results_scrolling_up,
                ['<PageDown>'] = actions.results_scrolling_down,
            },
        },
    },
    pickers = {
        find_files = {
            find_files = {
                find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix', '-H' },
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        project = {
            hidden_files = true, -- default: false
        },
    },
})

telescope.load_extension('fzf')
telescope.load_extension('projects')

-- Themes
local little_centered_list = require('telescope.themes').get_dropdown({
    width = 0.5,
    results_height = 15,
    previewer = false,
})

-- Use git_files under git projects, else use find_files
M.project_files = function()
    local opts = vim.deepcopy(little_centered_list) -- define here if you want to define something
    local ok = pcall(require('telescope.builtin').git_files, opts)
    if not ok then
        require('telescope.builtin').find_files(opts)
    end
end

M.buffer_find = function()
    local opts = vim.deepcopy(little_centered_list) -- define here if you want to define something
    local ok = pcall(require('telescope.builtin').current_buffer_fuzzy_find, opts)
    if not ok then
        return
    end
end

M.load_project_nvim = function()
    local opts = vim.deepcopy(little_centered_list) -- define here if you want to define something
    local ok = pcall(require('telescope').extensions.projects.projects, opts)
    if not ok then
        return
    end
end

return M
