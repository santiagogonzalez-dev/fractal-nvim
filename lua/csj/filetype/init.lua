local M = {}

function M.filetype_settings()
    if vim.bo.filetype == 'lua' then
        return require('csj.filetype.lua')
    end

    if vim.bo.filetype == 'python' then
        return require('csj.filetype.python')
    end

    local twospaces = {
        'css',
        'haskell',
        'html',
        'javascript',
        'json',
        'xml',
    }

    if twospaces[vim.bo.filetype] then
        local tab_lenght = 2
        vim.opt.tabstop = tab_lenght
        vim.opt.shiftwidth = tab_lenght
    end
end

M.filetype_settings()

vim.api.nvim_create_autocmd('BufEnter', {
    command = 'lua require("csj.filetype").filetype_settings()'
})

return M
