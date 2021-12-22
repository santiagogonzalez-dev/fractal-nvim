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
        border = 'curved',
        winblend = 0,
        width = 120,
        height = 35,
        highlights = {
            border = 'FloatBorder',
            background = 'NormalFloat',
        },
    },
})

local files = {
    python = 'python -i ' .. vim.fn.expand '%:t',
    lua = 'lua ' .. vim.fn.expand '%:t',
    c = 'gcc -o temp ' .. vim.fn.expand '%:t' .. ' && ./temp && rm ./temp',
    java = 'javac ' .. vim.fn.expand '%:t' .. ' && java ' .. vim.fn.expand '%:t:r' .. ' && rm *.class',
    rust = 'cargo run',
    javascript = 'node ' .. vim.fn.expand '%:t',
    typescript = 'tsc ' .. vim.fn.expand '%:t' .. ' && node ' .. vim.fn.expand '%:t:r' .. '.js',
}

function Run_file()
    local command = files[vim.bo.filetype]
    if command ~= nil then
        require('toggleterm.terminal').Terminal:new({ cmd = command, close_on_exit = false }):toggle()
        print('Running: ' .. command)
    end
end

-- If you change the mapping you also need to enable it in your packer conf
vim.api.nvim_buf_set_keymap( vim.api.nvim_get_current_buf(), 'n', '<Leader>R', ':w<Cr>:lua Run_file()<Cr>', { noremap = true, silent = true })
