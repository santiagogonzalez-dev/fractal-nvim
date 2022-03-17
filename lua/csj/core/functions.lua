M = {}

-- Create command to format files using null-ls formatters
vim.api.nvim_add_user_command('Format', vim.lsp.buf.formatting_sync, {})

-- Fold Text
function M.foldtext_expression()
    return vim.fn.getline(vim.v.foldstart)
    -- return vim.fn.getline(vim.v.foldstart) .. ' ... ' .. vim.fn.getline(vim.v.foldend):gsub('^%s*', '')
end

-- Close or quit buffer
function M.close_or_quit()
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
        BufTypes = vim.api.nvim_list_bufs()
        for _, bufname in pairs(BufTypes) do
            if not loaded_only or vim.api.nvim_buf_is_loaded(bufname) then
                local buf_type = vim.api.nvim_buf_get_option(bufname, 'buftype')
                buf_type = buf_type ~= '' and buf_type or 'normal'
                count[buf_type] = count[buf_type] + 1
            end
        end
        return count
    end

    if count_bufs_by_type().normal <= 1 then
        vim.cmd([[PackerLoad telescope.nvim]])
        vim.ui.select({ 'Delete the buffer', 'Quit neovim' }, { prompt = '' }, function(_, prompt_option)
            if tonumber(prompt_option) == 1 then
                return vim.cmd([[ :bd ]])
            elseif tonumber(prompt_option) == 2 then
                return vim.cmd([[ :q ]])
            else
                return
            end
        end)
    else
        vim.cmd([[ :bp | sp | bn | bd ]])
    end
end

-- Compare the buffer to the contents of the clipboard
function _G.compare_to_clipboard()
    local ftype = vim.api.nvim_eval('&filetype')
    vim.cmd(string.format(
        [[
        vsplit
        enew
        normal! P
        setlocal buftype=nowrite
        set filetype=%s
        diffthis
        bprevious
        execute "normal! \<C-w>\<C-w>"
        diffthis
    ]],
        ftype
    ))
end

-- Insert character at the end of the last edited line
function M.char_at_eol()
    vim.ui.input({ prompt = 'What character do you want to insert at eol? ' }, function(prompt_option)
        vim.cmd(':norm mt`.A' .. prompt_option)
        vim.cmd([[ :norm 't ]])
    end)
end

return M
