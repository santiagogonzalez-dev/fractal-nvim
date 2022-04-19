local utils = {}

-- Close or quit buffer
function utils.close_or_quit()
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
            Trouble = 0,
            NvimTree = 0,
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

-- Toggle diagnostics
vim.g.diagnostics_active = true
utils.toggle_diagnostics = function()
    if vim.g.diagnostics_active then
        vim.g.diagnostics_active = false
        vim.diagnostic.hide()
        vim.lsp.handlers['textDocument/publishDiagnostics'] = function() end
    else
        vim.g.diagnostics_active = true
        vim.cmd([[exe "normal ii\<Esc>x"]])
        vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            signs = true,
            underline = true,
            update_in_insert = false,
        })
    end
end

-- Rename
function utils.rename()
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

-- Yanked text
function utils.get_yanked_text()
    return print(vim.fn.getreg('"'))
end

-- Conditional for width of the terminal
function utils.hide_at_vp()
    return vim.opt.columns:get() > 90
end

-- Highlights
function utils.set_hl(mode, table)
    if type(mode) == 'table' then
        for _, groups in pairs(mode) do
            vim.api.nvim_set_hl(0, groups, table)
        end
    else
        vim.api.nvim_set_hl(0, mode, table)
    end
end

-- Function to setup the initial load and maintain some settings between buffers
function utils.setup_session()
    -- vim.opt.shadafile = ''
    -- vim.cmd('rshada!')
    -- vim.opt.runtimepath = _G.rtp
    -- vim.cmd([[
    --     runtime! plugin/**/*.vim
    --     runtime! plugin/**/*.lua
    -- ]])

    vim.api.nvim_create_augroup('_save_sessions', { clear = true })
    vim.api.nvim_create_autocmd('BufReadPost', {
        desc = 'Open file at the last position it was edited earlier',
        group = '_save_sessions',
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
        group = '_save_sessions',
        callback = function()
            return vim.cmd('silent! mkview')
        end,
    })

    vim.api.nvim_create_autocmd('BufWinEnter', {
        desc = 'Load the view of the buffer',
        group = '_save_sessions',
        callback = function()
            return vim.cmd('silent! loadview')
        end,
    })
end

-- Don't open floating windows if there's already one open
function utils.not_interfere_on_float(conditional_function)
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
            vim.notify('There is a floating window open already', vim.log.levels.WARN)
            return
        end
    end
    return conditional_function()
end

-- Get the lenght of a table
function utils.table_lenght(T)
    local count = 0
    for _ in pairs(T) do
        count = count + 1
    end
    return count
end

-- Random set of items
function utils.append_by_random(option, T)
    return option:append(T[math.random(1, utils.table_lenght(T))])
end

-- -- Git project or not
-- -- TODO finish this
-- function utils.inside_git_project()
--   local val = vim.api.nvim_exec('!git rev-parse --is-inside-work-tree', true)
--   if val:match('true') then
--     return true
--   else
--     return false
--   end
-- end

-- vim.api.nvim_create_augroup('project_git', {})
-- vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
--   group = 'project_git',
--   callback = function ()
--     if utils.inside_git_project() then
--       vim.api.nvim_exec_autocmd()
--     end
--   end,
-- })

return utils
