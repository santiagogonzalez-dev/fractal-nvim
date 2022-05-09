local folds = {}
-- local utils = require('csj.utils')

-- Text for fold line
function folds.foldtext_expression()
    -- Match the characters at the start of the line
    local function starts_with(string_to_search, pattern_to_match)
        return string.sub(string_to_search, 1, string.len(pattern_to_match)) == pattern_to_match
    end

    local fold_end = function()
        -- TODO use the api
        local fe = vim.trim(vim.fn.getline(vim.v.foldend))
        local fae = vim.trim(vim.fn.getline(vim.v.foldend - 1))
        if starts_with(fae, 'return') then
            return ('  ' .. fae)
        elseif starts_with(fe, 'return') then
            return ('  ' .. fe)
        else
            return ''
        end
    end

    local start_line = function()
        -- imports for most languages
        if starts_with(vim.trim(vim.fn.getline(vim.v.foldstart)), 'import') then
            return 'imports'
        elseif starts_with(vim.trim(vim.fn.getline(vim.v.foldstart)), 'class ') then
            return vim.fn.getline(vim.v.foldstart):gsub('class ', '')
        elseif starts_with(vim.trim(vim.fn.getline(vim.v.foldstart)), 'def ') then
            return vim.fn.getline(vim.v.foldstart):gsub('def ', '')
        else
            return vim.fn.getline(vim.v.foldstart):gsub('\t', ('\t'):rep(vim.o.tabstop))
        end
    end
    return start_line() .. fold_end()
end

function folds.fold_this_block()
    local ok_ts, ts = pcall(require, 'vim.treesitter')
    local ok_get_parser, parser = pcall(ts.get_parser, 0, vim.bo.filetype)
    if not ok_ts or not ok_get_parser or not parser then
        -- If treesitter or the parser are not installed just use the ip motion
        vim.api.nvim_feedkeys('zfip', 'n', 'v:false')
        return
    end

    local ts_utils = require("nvim-treesitter.ts_utils") -- Treesitter utilities
    local node = ts_utils.get_node_at_cursor() -- Get the node under cursor

    local NODES = {
        'if_statement',
        'for_statement',
        'function_declaration',
        'function_definition',
        'class_definition',
    }

    local function create_fold_on_node()
        local start_line, _, end_line, _ = ts_utils.get_node_range(node)
        start_line = start_line + 1 -- Treesitter reads lines from 0 instead of 1 like in neovim
        end_line = end_line + 1

        vim.api.nvim_win_set_cursor(0, { start_line, 0 }) -- Move to the start of the function
        vim.cmd('norm {') -- And we get the comments or whatever that it is on top of the function

        local start_block = vim.api.nvim_win_get_cursor(0)

        vim.api.nvim_win_set_cursor(0, { end_line, 0 }) -- Now we move to the end of the function
        vim.cmd('norm }') -- And we get whatever it is that it's under the function
        local end_block = vim.api.nvim_win_get_cursor(0)

        vim.notify('Fold created from ' .. start_block[1] + 1 .. ' to ' .. end_block[1] - 1, vim.log.levels.INFO)
        vim.cmd(':' .. start_block[1] + 1 .. ',' .. end_block[1] - 1 .. 'fold') -- Create the fold
        return vim.api.nvim_win_set_cursor(0, { start_line, 0 }) -- And put the cursor on the fold line
    end

    for _, current_node in ipairs(NODES) do
        if current_node == node:type() then
            create_fold_on_node()
            break
        elseif current_node == node:parent():type() then
            node = node:parent()
            create_fold_on_node()
        end
    end
end
vim.keymap.set('n', 'zfib', function()
    return folds.fold_this_block()
end)

-- Fold settings
vim.opt.foldtext = 'v:lua.require("csj.core.folds").foldtext_expression()'
vim.opt.foldcolumn = 'auto:3' -- Folds column
vim.opt.foldmethod = 'manual'

vim.opt.fillchars:append {
    fold = ' ', -- Filling foldtext
    -- foldsep = '🮍',
    foldclose = '▴',
    foldsep = '▎',
    foldopen = '▾',
}

return folds
