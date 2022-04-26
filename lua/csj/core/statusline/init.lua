local statusline = {}

-- local modes = {
--     ['n'] = 'NORMAL',
--     ['no'] = 'NORMAL',
--     ['v'] = 'VISUAL',
--     ['V'] = 'VISUAL LINE',
--     [''] = 'VISUAL BLOCK',
--     ['s'] = 'SELECT',
--     ['S'] = 'SELECT LINE',
--     [''] = 'SELECT BLOCK',
--     ['i'] = 'INSERT',
--     ['ic'] = 'INSERT',
--     ['R'] = 'REPLACE',
--     ['Rv'] = 'VISUAL REPLACE',
--     ['c'] = 'COMMAND',
--     ['cv'] = 'VIM EX',
--     ['ce'] = 'EX',
--     ['r'] = 'PROMPT',
--     ['rm'] = 'MOAR',
--     ['r?'] = 'CONFIRM',
--     ['!'] = 'SHELL',
--     ['t'] = 'TERMINAL',
-- }

-- local function mode()
--     local current_mode = vim.api.nvim_get_mode().mode
--     return string.format(' %s ', modes[current_mode]):upper()
-- end

local function filepath()
    local fpath = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.:h')
    if fpath == '' or fpath == '.' then
        return ' '
    end

    return string.format(' %%<%s/', fpath)
end

local vcs = function()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == '' then
        return ''
    end
    local added = git_info.added and ('%#GitSignsAdd#+' .. git_info.added .. ' ') or ''
    local changed = git_info.changed and ('%#GitSignsChange#~' .. git_info.changed .. ' ') or ''
    local removed = git_info.removed and ('%#GitSignsDelete#-' .. git_info.removed .. ' ') or ''
    if git_info.added == 0 then
        added = ''
    end
    if git_info.changed == 0 then
        changed = ''
    end
    if git_info.removed == 0 then
        removed = ''
    end
    return table.concat {
        ' ',
        added,
        changed,
        removed,
        ' ',
        '%#GitSignsAdd# ',
        git_info.head,
        ' %#Normal#',
    }
end

local function filename()
    local fname = vim.fn.expand('%:t')
    if fname == '' then
        return ''
    end
    return fname .. ' '
end

local function lsp()
    local count = {}
    local levels = {
        errors = 'Error',
        warnings = 'Warn',
        info = 'Info',
        hints = 'Hint',
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ''
    local warnings = ''
    local hints = ''
    local info = ''

    if count['errors'] ~= 0 then
        errors = ' %#LspDiagnosticsSignError# ' .. count['errors']
    end
    if count['warnings'] ~= 0 then
        warnings = ' %#LspDiagnosticsSignWarning# ' .. count['warnings']
    end
    if count['hints'] ~= 0 then
        hints = ' %#LspDiagnosticsSignHint# ' .. count['hints']
    end
    if count['info'] ~= 0 then
        info = ' %#LspDiagnosticsSignInformation# ' .. count['info']
    end

    return errors .. warnings .. hints .. info .. '%#Normal#'
end

local function filetype()
    return string.format(' %s ', vim.bo.filetype):upper()
end

local function lineinfo()
    return '%P %l:%c '
end

statusline.main = function()
    -- This is the statusline that gets shown most of the time
    return table.concat {
        -- '%#StatusLine#',
        -- mode(),
        lineinfo(),
        '%#StatusLineNC# ',
        lsp(),
        ' ',
        '%=%#StatusLineNC#',
        -- filepath(),
        filename(),
        filetype(),
        vcs(),
    }
end

function statusline.netrw_opened()
    return '%#StatusLineNC#  NetRW'
end

vim.api.nvim_create_augroup('_statusline', {})

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufReadPre' }, {
    group = '_statusline',
    callback = function()
        vim.opt.statusline = '%!v:lua.require("csj.core.statusline").main()'
    end,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'FileType', 'BufReadPre' }, {
    pattern = 'netrw',
    group = '_statusline',
    callback = function()
        vim.opt.statusline = '%!v:lua.require("csj.core.statusline").netrw_opened()'
    end,
})

vim.opt.statusline = '%!v:lua.require("csj.core.statusline").main()'

-- TODO (santigo-zero): Fetch the buffer list, check if they are valid, get their names and show

return statusline
