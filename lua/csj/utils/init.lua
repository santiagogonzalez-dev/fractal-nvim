local utils = {}

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

    vim.api.nvim_create_autocmd('BufReadPost', {
        desc = 'Correctly restore the cursor position',
        group = save_sessions,
        callback = function()
            if vim.tbl_contains({ 'TelescopePrompt', 'gitcommit', 'gitdiff', 'netrw' }, vim.bo.filetype) then
                return
            end

            local markpos = vim.api.nvim_buf_get_mark(0, '"') -- Get position of last saved edit
            local line = markpos[1]
            local col = markpos[2]
            -- If the cursor line position is less than 1, but not bigger than the lines of the buffer then
            if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
                vim.api.nvim_win_set_cursor(0, { line, col }) -- Set the position
                if vim.fn.foldclosed(line) ~= -1 then -- And check if there's a closed fold
                    vim.cmd('silent normal! zo') -- To open it
                end
            end
        end,
    })

    vim.api.nvim_create_autocmd('BufWinEnter', {
        desc = 'Load the view of the buffer',
        group = save_sessions,
        callback = function()
            return vim.cmd('silent! loadview')
        end,
    })

    vim.api.nvim_create_autocmd('BufWinLeave', {
        desc = 'Save the view of the buffer',
        group = save_sessions,
        callback = function()
            return vim.cmd('silent! mkview')
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

function utils.append_by_random(option, T)
    -- Random set of items
    return option:append(T[math.random(1, #T)])
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

function utils.is_git()
    local is_git = vim.api.nvim_exec('!git rev-parse --is-inside-work-tree', true)
    if is_git:match('true') then
        return vim.cmd('doautocmd User IsGit')
    else
        return
    end
end

function utils.better_eol()
    -- Better eol
    local show_eol_nm = vim.api.nvim_create_namespace('show_eol')
    local function show_eol()
        if vim.tbl_contains({ 'TelescopePrompt', 'gitcommit', 'gitdiff', 'netrw', 'help' }, vim.bo.filetype) then
            vim.api.nvim_buf_del_extmark(0, show_eol_nm, 1)
            return
        end

        local cursor_position = vim.api.nvim_win_get_cursor(0)
        local line_num = cursor_position[1] - 1
        local dolar_pos = #vim.api.nvim_get_current_line()

        local get_hl = vim.api.nvim_get_hl_by_name
        if vim.api.nvim_get_option_value('cursorline', {}) then
            utils.set_hl('BetterEOL', { fg = get_hl('NonText', true).foreground, bg = get_hl('CursorLine', true).background })
        else
            utils.set_hl('BetterEOL', { fg = get_hl('NonText', true).foreground, bg = get_hl('Normal', true).background })
        end

        local opts = {
            id = 1,
            virt_text = { { ' ' .. dolar_pos .. ' ', 'BetterEOL' } },
            virt_text_pos = 'eol',
            virt_text_win_col = dolar_pos,
        }

        return vim.api.nvim_buf_set_extmark(vim.fn.bufnr('%'), show_eol_nm, line_num, 0, opts)
    end

    show_eol() -- Run the function the first line that we call better_eol() but without autocmds

    return vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        desc = 'Show the eol of the current line the cursor is on',
        group = 'session_opts',
        callback = show_eol,
    })
end

-- TODO(santigo-zero): Am I going to use this?
-- function utils.show_dot_mark_on_gutter()
--     local dot_mark_ns = vim.api.nvim_create_namespace('dot_mark_ns')
--     function utils.show_dot()
--         local mark_pos = vim.api.nvim_buf_get_mark(0, '.') -- Get the position of the . mark

--         local get_hl = vim.api.nvim_get_hl_by_name
--         utils.set_hl('ShowDotMarkOnGutter', { fg = get_hl('CursorLineNr', true).foreground, bg = get_hl('Normal', true).background })
--         vim.g.dot_mark_extmark = vim.api.nvim_buf_set_extmark(0, dot_mark_ns, mark_pos[1] - 1, 0, { sign_text = ' ', sign_hl_group = 'ShowDotMarkOnGutter' })
--         return vim.g.dot_mark_extmark
--     end

--     function utils.remove_dot()
--         if vim.g.dot_mark_extmark then
--             return pcall(vim.api.nvim_buf_del_extmark, 0, dot_mark_ns, vim.g.dot_mark_extmark)
--         end
--     end

--     local dot_mark_group = vim.api.nvim_create_augroup('dot_mark_group', {})
--     vim.api.nvim_create_autocmd('InsertLeave', {
--         group = dot_mark_group,
--         callback = function()
--             utils.remove_dot()
--             return utils.show_dot()
--         end,
--     })

--     vim.api.nvim_create_autocmd('InsertEnter', {
--         group = dot_mark_group,
--         callback = function()
--             return utils.remove_dot()
--         end,
--     })

--     vim.api.nvim_create_autocmd('CursorHold', {
--         group = dot_mark_group,
--         once = true,
--         callback = function()
--             utils.remove_dot()
--             return utils.show_dot()
--         end,
--     })

--     vim.api.nvim_create_autocmd('BufModifiedSet', {
--         group = dot_mark_group,
--         callback = function()
--             -- We check the mode because BufModifiedSet gets triggered on insert and we don't want that
--             if vim.api.nvim_get_mode().mode == 'n' then
--                 utils.remove_dot()
--                 return utils.show_dot()
--             end
--         end,
--     })
-- end

-- function utils.is_bigger_than(filepath, size_in_kilobytes)
--     -- Fail if filepath is bigger than the provided size in kilobytes
--     vim.loop.fs_stat(filepath, function(_, stat)
--         if not stat then
--             return
--         end
--         if stat.size > size_in_kilobytes then
--             return
--         else
--             return true
--         end
--     end)
-- end

-- function utils.get_yanked_text()
--     -- Yanked text
--     return print(vim.fn.getreg('"'))
-- end

-- function utils.hide_at_term_width()
--     -- Conditional for width of the terminal
--     return vim.opt.columns:get() > 90
-- end

return utils
