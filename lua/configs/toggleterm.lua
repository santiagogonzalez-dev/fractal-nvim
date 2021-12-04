require('toggleterm').setup({
    hide_numbers = true,
    start_in_insert = true,
    insert_mappings = true,
    open_mapping = [[<C-t>]],
    shade_terminals = true,
    shading_factor = '3',
    persist_size = true,
    close_on_exit = true,
    -- direction = 'vertical',
    size = 60,
    direction = 'float',
    float_opts = {
        winblend = 16,
        width = 100,
        height = 24,
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

-- function Run_file()
-- 	local command = files[vim.bo.filetype]
-- 	if command ~= nil then
-- 		require('toggleterm.terminal').Terminal:new({ cmd = command, close_on_exit = true }):toggle()
-- 		print('Running: ' .. command)
-- 	end
-- end

function Run_file()
    local command = files[vim.bo.filetype]
    if command ~= nil then
        require('toggleterm.terminal').Terminal:new({ cmd = command, close_on_exit = false }):toggle()
        print('Running: ' .. command)
    end
end

-- If you change the mapping you also need to enable it in your packer conf
vim.api.nvim_buf_set_keymap( vim.api.nvim_get_current_buf(), 'n', '<Leader>r', ':w<CR>:lua Run_file()<CR>', { noremap = true, silent = true })
