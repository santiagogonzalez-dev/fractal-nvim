local set_hl = require('csj.core.utils').set_hl

require('ffi').cdef('int curwin_col_off(void);')

local M = {
    config = {
        -- char = '⌇',
        char = '┃',
        -- char = '▎',
        -- char = '│',
        virtcolumn = '',
    },
    buffer_config = {},
}

M.concat_table = function(t1, t2)
    for _, v in ipairs(t2) do
        t1[#t1 + 1] = v
    end
    return t1
end

M.command_refresh = function(bang)
    if bang then
        local win = vim.api.nvim_get_current_win()
        vim.cmd('noautocmd windo lua require("csj.core.virt-column").refresh()')
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_current_win(win)
            vim.cmd('lua require("csj.core.virt-column").refresh()')
        end
    else
        vim.cmd('lua require("csj.core.virt-column").refresh()')
    end
end

M.clear_buf = function(bufnr)
    if M.namespace then
        vim.api.nvim_buf_clear_namespace(bufnr, M.namespace, 0, -1)
    end
end

M.setup = function(config)
    M.config = vim.tbl_deep_extend('force', M.config, config or {})
    M.namespace = vim.api.nvim_create_namespace('virt-column')

    vim.api.nvim_create_user_command('VirtColumnRefresh', function()
        return M.command_refresh('<bang>' == '!')
    end, { bang = true })

    set_hl('VirtColumn', { link = 'Whitespace' })
    set_hl('Whitespace', { fg = '#1f1d2e' })
    set_hl('ColorColumn', {})

    vim.api.nvim_create_augroup('_virt-column', {})
    vim.api.nvim_create_autocmd('CursorHold', { group = '_virt-column', command = 'VirtColumnRefresh' })
end

M.setup_buffer = function(config)
    M.buffer_config[vim.api.nvim_get_current_buf()] = config
    M.refresh()
end

M.refresh = function()
    local bufnr = vim.api.nvim_get_current_buf()

    if not vim.api.nvim_buf_is_loaded(bufnr) then
        return
    end

    local config = vim.tbl_deep_extend('force', M.config, M.buffer_config[bufnr] or {})
    local winnr = vim.api.nvim_get_current_win()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local width = vim.api.nvim_win_get_width(winnr) - require('ffi').C.curwin_col_off()
    local textwidth = vim.opt.textwidth:get()
    local colorcolumn = M.concat_table(vim.opt.colorcolumn:get(), vim.split(config.virtcolumn, ','))

    for i, c in ipairs(colorcolumn) do
        if vim.startswith(c, '+') then
            if textwidth ~= 0 then
                colorcolumn[i] = textwidth + tonumber(c:sub(2))
            else
                colorcolumn[i] = nil
            end
        elseif vim.startswith(c, '-') then
            if textwidth ~= 0 then
                colorcolumn[i] = textwidth - tonumber(c:sub(2))
            else
                colorcolumn[i] = nil
            end
        else
            colorcolumn[i] = tonumber(c)
        end
    end

    table.sort(colorcolumn, function(a, b)
        return a > b
    end)

    M.clear_buf(bufnr)

    for i = 1, #lines, 1 do
        for _, column in ipairs(colorcolumn) do
            local line = lines[i]:gsub('\t', string.rep(' ', vim.opt.tabstop:get()))
            if width > column and vim.api.nvim_strwidth(line) < column then
                vim.api.nvim_buf_set_extmark(bufnr, M.namespace, i - 1, 0, {
                    virt_text = { { config.char, 'VirtColumn' } },
                    virt_text_pos = 'overlay',
                    hl_mode = 'combine',
                    virt_text_win_col = column - 1,
                    priority = 1,
                })
            end
        end
    end
end

M.setup()

return M
