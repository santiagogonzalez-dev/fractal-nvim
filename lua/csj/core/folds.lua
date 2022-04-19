 local folds = {}

-- Folds text
function folds.foldtext_expression()
    -- Match the characters at the start of the line
    local function starts_with(string_to_search, pattern_to_match)
        return string.sub(string_to_search, 1, string.len(pattern_to_match)) == pattern_to_match
    end

    local fold_end = function()
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

-- Fold settings
vim.opt.foldtext = 'v:lua.require("csj.core.folds").foldtext_expression()'
vim.opt.foldcolumn = 'auto:3' -- Folds column
vim.opt.foldmethod = 'manual'
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.opt.fillchars:append {
    fold = ' ', -- Filling foldtext
    -- foldsep = '🮍',
}

require('csj.utils').append_by_random(vim.opt.fillchars, {
    {
        foldclose = '▾',
        foldopen = '▴',
        foldsep = '│',
    },
    {
        foldclose = 'ᐉ',
        foldopen = '▎',
        foldsep = '▎',
    },
})

return folds
