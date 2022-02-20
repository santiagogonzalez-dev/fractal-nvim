local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = [[<C-t>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = false,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = 'rounded',
        winblend = 9,
        highlights = {
            border = 'Normal',
            background = 'Normal',
        },
    },
})

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({ cmd = 'lazygit', hidden = true })

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

local node = Terminal:new({ cmd = 'node', hidden = true })

function _NODE_TOGGLE()
    node:toggle()
end

local ncdu = Terminal:new({ cmd = 'ncdu', hidden = true })

function _NCDU_TOGGLE()
    ncdu:toggle()
end

local htop = Terminal:new({ cmd = 'htop', hidden = true })

function _HTOP_TOGGLE()
    htop:toggle()
end

local python = Terminal:new({ cmd = 'python', hidden = false })

function _PYTHON_TOGGLE()
    python:toggle()
end

local files = {
    python = 'python -i ' .. vim.fn.expand('%:r') .. '.py', -- Start the REPL
    java = 'javac ' .. vim.fn.expand('%:t') .. ' && java ' .. vim.fn.expand('%:t:r') .. ' && rm *.class',
    javascript = 'node ' .. vim.fn.expand('%:p'),
    typescript = 'tsc ' .. vim.fn.expand('%:r') .. ' && node ' .. vim.fn.expand('%:r') .. '.js',
    html = os.getenv('BROWSER') .. ' ' .. vim.fn.expand('%:r') .. '.html',
    haskell = 'ghci ' .. vim.fn.expand('%:r') .. '.hs', -- Start the REPL
    markdown = 'okular' .. ' ' .. vim.fn.expand('%:r') .. '.md',
}

function Run_file()
    local command = files[vim.bo.filetype]
    if command ~= nil then
        require('toggleterm.terminal').Terminal:new({ cmd = command, close_on_exit = false }):toggle()
    end
end
