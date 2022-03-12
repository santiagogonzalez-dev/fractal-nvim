M = {}

-- Create command to format files using null-ls formatters
vim.api.nvim_add_user_command('Format', vim.lsp.buf.formatting_sync, {})

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
        vim.ui.select({ 'Quit neovim', 'Delete the buffer' }, { prompt = '' }, function(_, prompt_option)
            if tonumber(prompt_option) == 1 then
                return vim.cmd([[ :q ]])
            elseif tonumber(prompt_option) == 2 then
                return vim.cmd([[ :bd ]])
            else
                return
            end
        end)
    else
        vim.cmd([[ :bd ]])
    end
end

-- Compare the buffer to the contents of the clipboard
function _G.compare_to_clipboard()
    vim.cmd('vsplit')
    vim.cmd('enew')
    vim.cmd('normal! P')
    vim.opt.buftype = 'nowrite'
    vim.opt.filetype = vim.api.nvim_eval('%filetype')
    vim.cmd('diffthis')
    vim.cmd([[execute "normal! \<C-w>h"]])
    vim.cmd('diffthis')
end

-- Insert character at the end of the last edited line
function M.char_at_eol()
    vim.ui.input({ prompt = 'What character do you want to insert at eol? ' }, function(prompt_option)
        vim.cmd(':norm mt`.A' .. prompt_option)
        vim.cmd([[ :norm 't ]])
    end)
end

JumpToBuf = 0
function M.jump_between_two_buffers()
    if JumpToBuf == 0 then
        vim.cmd([[:bprevious]])
        JumpToBuf = 1
    elseif JumpToBuf == 1 then
        vim.cmd([[:bnext]])
        JumpToBuf = 0
    end
end

return M
