M = {}

-- Create command to format files using null-ls formatters
vim.api.nvim_add_user_command('Format', vim.lsp.buf.formatting_sync, {})

-- Close or quit buffer
-- If there's more than two buffers open, wipe the working buffer
-- If there's only one buffer close neovim
local CountBufsByType = function(loaded_only)
    loaded_only = (loaded_only == nil and true or loaded_only)
    Count = { normal = 0, acwrite = 0, help = 0, nofile = 0, nowrite = 0, quickfix = 0, terminal = 0, prompt = 0 }
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

function M.close_or_quit()
    local bufTable = CountBufsByType()
    print('bufTable ->', bufTable)
    -- if bufTable.normal <= 1 then
    --     vim.ui.select({ 'Quit neovim', 'Delete the buffer' }, { prompt = 'What to do?' }, function(_, prompt_option)
    --         if tonumber(prompt_option) == 1 then
    --             return vim.cmd([[ :q ]])
    --         elseif tonumber(prompt_option) == 2 then
    --             return vim.cmd([[ :bw ]])
    --         else
    --             return
    --         end
    --     end)
    --     vim.cmd([[ :q ]])
    -- else
    --     vim.cmd([[ :bd ]])
    -- end
end

-- Defer plugins
function M.load_plugins()
    vim.cmd([[
        PackerLoad bufferline.nvim
        PackerLoad gitsigns.nvim
        PackerLoad nvim-colorizer.lua
        PackerLoad nvim-tree.lua
        PackerLoad pretty-fold.nvim
        PackerLoad telescope.nvim
    ]])
end

-- Load plugins
vim.cmd([[
    augroup _load_plugins
        autocmd!
        autocmd VimEnter * lua vim.defer_fn(M.load_plugins, 3)
    augroup END
]])

-- Compare the buffer to the contents of the clipboard
function _G.compare_to_clipboard()
    local ftype = vim.api.nvim_eval('&filetype')
    vim.cmd('vsplit')
    vim.cmd('enew')
    vim.cmd('normal! P')
    vim.cmd('setlocal buftype=nowrite')
    vim.cmd('set filetype=' .. ftype)
    vim.cmd('diffthis')
    vim.cmd([[execute "normal! \<C-w>h"]])
    vim.cmd('diffthis')
end

-- Insert character at the end of the last edited line
function M.char_at_eol()
    vim.ui.input(
        { prompt = 'What character do you want to insert at eol? ' },
        function(prompt_option)
            vim.cmd(':norm mt`.A' .. prompt_option)
            vim.cmd([[ :norm 't]])
        end
    )
end

return M
