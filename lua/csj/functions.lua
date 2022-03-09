M = {}

-- Create command to format files using null-ls formatters
vim.api.nvim_add_user_command('Format', vim.lsp.buf.formatting_sync, {})

-- Close or quit buffer
function M.close_or_quit()
    local CountBufsByType = function(loaded_only)
        loaded_only = (loaded_only == nil and true or loaded_only)
        Count = {
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
                BufType = vim.api.nvim_buf_get_option(bufname, 'buftype')
                BufType = BufType ~= '' and BufType or 'normal'
                Count[BufType] = Count[BufType] + 1
            end
        end
        return Count
    end

    if CountBufsByType().normal <= 1 then
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

-- Format only if the buffer has unsaved changes
function M.format_if_updating()
    local format_on_write = vim.api.nvim_create_autocmd('BufWritePre', {
        desc = 'Format on save',
        group = '_session_opts',
        callback = function()
            vim.lsp.buf.formatting_sync()
        end,
    })
    vim.cmd([[ :update ]])
    vim.api.nvim_del_autocmd(format_on_write)
end

return M
