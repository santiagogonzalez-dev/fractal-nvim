local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
    return
end

toggleterm.setup({
    size = 100,
    open_mapping = [[<C-t>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 0,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = false,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'rounded',
        winblend = 33,
        width = 120,
        height = 35,
    },
})

local exp = vim.fn.expand
local files = {
    python = 'python -i ' .. exp('%:r') .. '.py', -- Start the REPL
    java = 'javac ' .. exp('%:t') .. ' && java ' .. exp('%:t:r') .. ' && rm *.class',
    javascript = 'node ' .. exp('%:p'),
    typescript = 'tsc ' .. exp('%:r') .. ' && node ' .. exp('%:r') .. '.js',
    html = os.getenv('BROWSER') .. ' ' .. exp('%:r') .. '.html',
    haskell = 'ghci ' .. exp('%:r') .. '.hs', -- Start the REPL
}

function Run_file()
    local command = files[vim.bo.filetype]
    if command ~= nil then
        require('toggleterm.terminal').Terminal:new({ cmd = command, close_on_exit = false }):toggle()
    end
end

-- If you change the mapping you also need to enable it in your packer conf
vim.api.nvim_buf_set_keymap(
    vim.api.nvim_get_current_buf(),
    'n',
    '<Leader>R',
    ':w<Cr>:lua Run_file()<Cr>',
    { noremap = true, silent = true }
)
