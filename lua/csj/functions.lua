M = {}

-- Create command to format files using null-ls formatters
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync()' ]])

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
    if bufTable.normal <= 1 then
        vim.ui.select(
            { 'Quit neovim', 'Delete the buffer' },
            { prompt = 'What to do?' },
            function(_, prompt_option)
                if tonumber(prompt_option) == 1 then
                    vim.cmd([[ :q ]])
                else
                    vim.cmd([[ :bd ]])
                end
            end
        )
    else
        vim.cmd([[ :bd ]])
    end
end

-- Defer plugins
function M.load_plugins()
    vim.cmd([[
        PackerLoad surround.nvim
        PackerLoad bufferline.nvim
        PackerLoad gitsigns.nvim
        PackerLoad nvim-tree.lua
        PackerLoad pretty-fold.nvim
        PackerLoad null-ls.nvim
        PackerLoad lualine.nvim
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

return M

-- -- Smart quit, if only 1 buffer loaded, quit neovim, if more than 2 quit the focused buffer
-- -- Using utils fro bufferline
-- function M.close_or_quit()
--     local bufNum = #require('bufferline.utils').get_valid_buffers()
--     if bufNum <= 1 then
--         vim.cmd([[ :q ]])
--     end
--     vim.cmd([[ :bd ]])
-- end
