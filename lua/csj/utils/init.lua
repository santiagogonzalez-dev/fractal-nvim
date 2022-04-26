local utils = {}

function utils.close_or_quit()
    -- Close or quit buffer
    local count_bufs_by_type = function(loaded_only)
        loaded_only = (loaded_only == nil and true or loaded_only)
        local count = {
            normal = 0,
            acwrite = 0,
            help = 0,
            nofile = 0,
            nowrite = 0,
            quickfix = 0,
            terminal = 0,
            prompt = 0,
        }
        for _, bufname in pairs(vim.api.nvim_list_bufs()) do
            if not loaded_only or vim.api.nvim_buf_is_loaded(bufname) then
                local buf_type = vim.api.nvim_buf_get_option(bufname, 'buftype')
                buf_type = buf_type ~= '' and buf_type or 'normal'
                count[buf_type] = count[buf_type] + 1
            end
        end
        return count
    end

    if count_bufs_by_type().normal <= 1 then
        vim.ui.select({ 'Delete the buffer', 'Quit neovim' }, {}, function(_, prompt)
            if tonumber(prompt) == 1 then
                return vim.cmd('bd')
            elseif tonumber(prompt) == 2 then
                return vim.cmd('q')
            end
        end)
    else
        return vim.cmd('bp | sp | bn | bd')
    end
end

function utils.toggle_diagnostics()
    -- Toggle diagnostics
    if not vim.g.diagnostics_active then
        vim.g.diagnostics_active = not vim.g.diagnostics_active
        vim.diagnostic.hide()
        vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
    else
        vim.g.diagnostics_active = not vim.g.diagnostics_active
        vim.cmd([[exe "normal ii\<Esc>x"]])
        vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            signs = true,
            underline = true,
            update_in_insert = false,
        })
    end
end

function utils.rename()
    -- Rename
    local function post(rename_old)
        vim.cmd('stopinsert!')
        local new = vim.api.nvim_get_current_line()
        vim.schedule(function()
            vim.api.nvim_win_close(0, true)
            vim.lsp.buf.rename(vim.trim(new))
        end)
        vim.notify(rename_old .. '  ' .. new)
    end
    local rename_old = vim.fn.expand('<cword>')
    local created_buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(created_buffer, true, {
        relative = 'cursor',
        style = 'minimal',
        border = 'rounded',
        row = -3,
        col = 0,
        width = 20,
        height = 1,
    })
    vim.cmd('startinsert')

    vim.keymap.set('i', '<ESC>', function()
        vim.cmd('q')
        vim.cmd('stopinsert')
    end, { buffer = created_buffer })

    vim.keymap.set('i', '<CR>', function()
        return post(rename_old)
    end, { buffer = created_buffer })
end

function utils.get_yanked_text()
    -- Yanked text
    return print(vim.fn.getreg('"'))
end

function utils.hide_at_term_width()
    -- Conditional for width of the terminal
    return vim.opt.columns:get() > 90
end

function utils.set_hl(mode, table)
    -- Highlights
    if type(mode) == 'table' then
        for _, groups in pairs(mode) do
            vim.api.nvim_set_hl(0, groups, table)
        end
    else
        vim.api.nvim_set_hl(0, mode, table)
    end
end

function utils.setup_session()
    -- Function to setup the initial load and maintain some settings between buffers
    local save_sessions = vim.api.nvim_create_augroup('save_sessions', {})
    vim.api.nvim_create_autocmd('UIEnter', {
        desc = 'Open file at the last position it was edited earlier',
        group = save_sessions,
        callback = function()
            if vim.tbl_contains(vim.api.nvim_list_bufs(), vim.api.nvim_get_current_buf()) then
                if not vim.tbl_contains({ 'gitcommit', 'help', 'packer', 'toggleterm' }, vim.bo.ft) then
                    -- Check if mark `"` is inside the current file (can be false if at end of file and stuff got deleted outside
                    -- neovim) if it is go to it
                    -- TODO use lua in here
                    vim.cmd([[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]])
                    local cursor = vim.api.nvim_win_get_cursor(0) -- Get cursor position
                    if vim.fn.foldclosed(cursor[1]) ~= -1 then -- If there are folds under the cursor open them
                        vim.cmd('silent normal! zO')
                    end
                end
            end
        end,
    })

    vim.api.nvim_create_autocmd('BufWinLeave', {
        desc = 'Save the view of the buffer',
        group = save_sessions,
        callback = function()
            return vim.cmd('silent! mkview')
        end,
    })

    vim.api.nvim_create_autocmd('BufWinEnter', {
        desc = 'Load the view of the buffer',
        group = save_sessions,
        callback = function()
            return vim.cmd('silent! loadview')
        end,
    })
end

function utils.not_interfere_on_float()
    -- Do not open floating windows if there's already one open
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
            vim.notify('There is a floating window open already', vim.log.levels.WARN)
            return false
        end
    end
    return true
end

function utils.table_lenght(T)
    -- Get the lenght of a table
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

function utils.append_by_random(option, T)
    -- Random set of items
    return option:append(T[math.random(1, utils.table_lenght(T))])
end

function utils.wrap(function_pointer, ...)
    -- Wrapper for functions, it works like pcall
    -- Varargs can't be used as an upvalue, so store them
    -- in this table first.
    local params = { ... }

    return function()
        return function_pointer(unpack(params))
    end
end

function utils.is_empty(str)
    return str == '' or str == nil
end

function utils.is_bigger_than(filepath, size_in_kilobytes)
    -- Fail if filepath is bigger than the provided size in kilobytes
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then
            return
        end
        if stat.size > size_in_kilobytes then
            return
        else
            return true
        end
    end)
end

function utils.is_git()
    local is_git = vim.api.nvim_exec('!git rev-parse --is-inside-work-tree', true)
    if is_git:match('true') then
        return vim.cmd('doautocmd User IsGit')
    else
        return
    end
end

function utils.h_motion()
    local cursor_position = vim.api.nvim_win_get_cursor(0)

    vim.cmd('normal ^')
    local first_non_blank_char = vim.api.nvim_win_get_cursor(0)

    if cursor_position[2] <= first_non_blank_char[2] then
        return vim.cmd('normal 0')
    else
        vim.api.nvim_win_set_cursor(0, cursor_position)
        return vim.cmd('normal! h')
    end
end

function utils.l_motion()
    local cursor_position = vim.api.nvim_win_get_cursor(0)

    vim.cmd('normal ^')
    local first_non_blank_char = vim.api.nvim_win_get_cursor(0)

    if cursor_position[2] < first_non_blank_char[2] then
        return vim.cmd('normal ^')
    else
        vim.api.nvim_win_set_cursor(0, cursor_position)
        return vim.cmd('normal! l')
    end
end

function utils.better_eol()
    -- Better eol
    local show_eol_nm = vim.api.nvim_create_namespace('show_eol')
    local function show_eol()
        local line_num = vim.api.nvim_win_get_cursor(0)[1] - 1

        local opts_virtualtext = {
            id = 1,
            -- virt_text = { { '↴', 'LineNr' } },
            -- virt_text = { { '⏎', 'LineNr' } },
            virt_text = { { '', 'LineNr' } },
            virt_text_pos = 'eol',
        }

        vim.g.show_eol_mark = vim.api.nvim_buf_set_extmark(vim.fn.bufnr('%'), show_eol_nm, line_num, 0, opts_virtualtext)
    end

    show_eol()

    return vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        desc = 'Show the eol of the current line the cursor is on',
        group = 'session_opts',
        callback = show_eol,
    })
end

-- local show_gi_nm = vim.api.nvim_create_namespace('show_gi_mark')

-- local function show_gi_and_jump()
--     if vim.tbl_contains(vim.api.nvim_list_bufs(), vim.api.nvim_get_current_buf()) then
--         if vim.tbl_contains({ 'gitcommit', 'help', 'packer', 'toggleterm' }, vim.bo.ft) then
--             return
--         end

--         local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Get actual position

--         -- gi or `.
--         local ok_gi, _ = pcall(vim.cmd, 'normal `.')
--         if ok_gi then
--             Mark_gi = vim.api.nvim_win_get_cursor(0) -- Get the position of gi
--         else
--             return
--         end

--         vim.api.nvim_win_set_cursor(0, cursor_pos) -- Restore position

--         local line_num_gi = Mark_gi[1] - 1

--         vim.api.nvim_set_hl(0, 'ShowgiContents', { fg = '#c4a7e7' })
--         -- vim.api.nvim_set_hl(0, 'ShowgiBorders', { fg = '#44415a' })
--         -- vim.api.nvim_set_hl(0, 'ShowgiContents', { bg = '#44415a', fg = '#191724' })
--         local opts_gi = {
--             end_line = 0,
--             id = 1,
--             -- virt_text = { { '', 'ShowgiBorders' }, { ' `.', 'ShowgiContents' }, { '', 'ShowgiBorders' } },
--             virt_text = { { ' `.', 'ShowgiContents' } },
--             virt_text_pos = 'eol',
--         }

--         vim.g.show_gi_mark = vim.api.nvim_buf_set_extmark(vim.fn.bufnr('%'), show_gi_nm, line_num_gi, 0, opts_gi)
--     end
-- end

-- vim.api.nvim_create_autocmd('InsertLeave', {
--     group = 'session_opts',
--     callback = show_gi_and_jump,
-- })

-- vim.api.nvim_create_autocmd('BufModifiedSet', {
--     group = 'session_opts',
--     callback = function()
--         if vim.api.nvim_get_mode().mode == 'n' then
--             show_gi_and_jump()
--         else
--             return
--         end
--     end,
-- })

-- vim.api.nvim_create_autocmd('InsertEnter', {
--     callback = function()
--         vim.api.nvim_buf_del_extmark(0, show_gi_nm, vim.g.show_gi_mark)
--     end,
-- })

-- show_gi_and_jump()

-- local show_gi_nm = vim.api.nvim_create_namespace('show_gi_mark')

local function show_gi_mark(mode)
    if mode then
        local cursor_pos = vim.api.nvim_win_get_cursor(0) -- Get actual position

        local ok_gi, _ = pcall(vim.cmd, 'normal `.')
        if ok_gi then
            Mark_gi = vim.api.nvim_win_get_cursor(0) -- Get the position of gi
        else
            return
        end

        vim.api.nvim_win_set_cursor(0, cursor_pos) -- Restore position
        vim.fn.sign_define('show_gi_mark', { text = '', texthl = 'Question' })
        vim.fn.sign_place(Mark_gi[1], '', 'show_gi_mark', vim.fn.expand('%:p'), { lnum = Mark_gi[1] })
    else
        -- vim.fn.sign_unplace
        return
    end
end
-- vim.keymap.set('n', '<Leader><Leader>', show_gi_mark)

vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
        return show_gi_mark(false) and show_gi_mark(true) -- toehute
    end,
})

return utils
