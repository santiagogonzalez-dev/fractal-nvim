M = {}

-- Create command to format files using null-ls formatters
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync()' ]])

-- Smart quit, if only 1 buffer loaded, quit neovim, if more than 2 quit the focused buffer
function M.close_or_quit()
    local bufNum = #require('bufferline.utils').get_valid_buffers()
    if bufNum <= 1 then
        vim.cmd([[ :q ]])
    end
    vim.cmd([[ :bd ]])
end

-- Defer plugins
function M.load_plugins()
    vim.cmd([[
        PackerLoad surround.nvim
        PackerLoad bufferline.nvim
        PackerLoad gitsigns.nvim
        PackerLoad hop.nvim
        PackerLoad nvim-tree.lua
        PackerLoad pretty-fold.nvim
        PackerLoad null-ls.nvim
    ]])

    require('csj.keymaps').general_keybinds()
    require('csj.core.cmp')
    require('csj.lsp')
end

-- Load plugins
vim.cmd([[
    augroup _load_plugins
        autocmd!
        autocmd VimEnter * lua vim.defer_fn(M.load_plugins, 3)
    augroup END
]])

return M
