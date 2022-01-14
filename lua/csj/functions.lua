M = {}

-- Create command to format files using null-ls formatters
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync()' ]])

-- Defer plugins
function M.load_plugins()
    vim.cmd([[
        PackerLoad gitsigns.nvim
        PackerLoad hop.nvim
        PackerLoad telescope.nvim
        PackerLoad indent-blankline.nvim
        PackerLoad surround.nvim
        PackerLoad pretty-fold.nvim
        PackerLoad bufferline.nvim
    ]])

    vim.cmd([[ doautocmd User PluginsLoaded ]])
    require('csj.keymaps').tele_keybinds()
end

-- Smart quit, if only 1 buffer loaded, quit neovim, if more than 2 quit the focused buffer
function M.close_or_quit()
    local bufNum = #require('bufferline.utils').get_valid_buffers()
    if bufNum <= 1 then
        vim.cmd([[ :q ]])
    end
    vim.cmd([[ :bd ]])
end

IskeywordActualState = false
function M.iskeyword_rotate()
    if IskeywordActualState == false then
        vim.opt.iskeyword:append('_')
        IskeywordActualState = true
    else
        vim.opt.iskeyword:remove('_')
    end
end

NumberColumnState = 1
function M.cycle_numbering()
    local number_column_states = {
        'set relativenumber     | set nonumber',
        'set norelativenumber   | set nonumber',
        'set norelativenumber   | set number',
        'set relativenumber     | set number',
    }
    vim.cmd(number_column_states[NumberColumnState])
    NumberColumnState = NumberColumnState + 1
    if NumberColumnState == 5 then
        NumberColumnState = 1
    end
end

return M
