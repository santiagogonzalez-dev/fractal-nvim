-- WIP
vim.cmd('hi clear')

if 1 == vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
end

vim.opt.termguicolors = true
vim.g.colors_name = 'csjcolors'

vim.cmd(':ColorizerToggle')
vim.api.nvim_create_autocmd('CursorMoved', {
    command = ':ColorizerReloadAllBuffers',
})

vim.fn.matchadd('IncSearch', '\\s\\+$') -- Show trail spaces(whitespaces), IncSearch is used to not create another hl group

-- Color palette
local p = {
    accent = '#FA9336',

    bg = '#191724', -- Base background
    bg_as_fg = '#191724',
    bg_reg = '#1f1d2e',
    bg_high = '#26233a',

    fg = '#6e6a86', -- Base foreground
    fg_reg = '#908caa',
    fg_high = '#c1bfd5', -- My plasma theme uses the same text color -- fg_300 = '#e0def4',

    dm = '#3d3b51',
    dm_blue = '#575279',
    dm_grey_blue = '#708090',
    dm_steel = '#B1B6B7',

    -- blues
    blue = '#5485d3',
    blue_alt = '#326285',
    blue_td = '#A093C7', -- tonned down
    blue_light = '#A4B9EF',

    -- purples
    purple = '#B57EDC',

    -- yellows
    yellow = '#F1B642',
    yellow_march = '#F1D48A',

    -- pinky = '#BB9AF7',

    -- Diagnostics
    -- error = '#C9646E',
    -- error = '#B31942',
    error = '#eb6f92',
    error_bg = '#3C2636',

    warn = '#f6c177',
    warn_bg = '#3E3332',

    hint = '#2EA18C',
    hint_bg = '#1D2E35',

    info = '#9d86b9',
    info_bg = '#2F2A3D',
}

local h = function(...)
    return vim.api.nvim_set_hl(0, ...)
end

-- Interface
h('CursorColumn', { bg = p.bg_high })
h('CursorLine', { bg = p.bg_high })
h('CursorLineNr', { bg = p.bg_high, fg = p.fg_high })

h('WarningMsg', { fg = p.warn })
h('ErrorMsg', { fg = p.error })
h('MsgArea', { fg = p.fg_high })
h('IncSearch', { bg = p.accent, fg = p.bg_as_fg })
h('LineNr', { bg = p.bg, fg = p.fg })
h('FoldColumn', { bg = p.bg, fg = p.dm })
h('Folded', { bg = p.bg_reg, fg = p.dm_blue })
h('ColorColumn', { bg = p.bg_reg })
h('MatchParen', { bg = p.accent, fg = p.bg_as_fg })
h('NonText', { fg = p.dm })
h('Normal', { bg = p.bg, fg = p.fg })

h('Pmenu', { bg = p.bg_reg, fg = p.fg_reg })
h('PmenuSbar', { bg = p.bg_high })
h('PmenuSel', { bg = p.bg_high, fg = p.text })
h('PmenuThumb', { bg = p.fg })

h('Question', { fg = p.fg_reg })
h('Search', { bg = p.accent, fg = p.bg_as_fg })
h('IncSearch', { fg = p.accent, bg = p.bg })
h('SignColumn', { bg = p.bg })
h('StatusLine', { bg = p.bg_reg, fg = p.fg })
h('Title', { fg = p.fg_high })
h('VertSplit', { fg = p.bg_reg })
h('Visual', { bg = p.bg_high, reverse = true })
h('WinSeperator', { link = 'VertSplit' })

-- Syntax
h('Boolean', { fg = p.fg_reg })
h('Character', { fg = p.fg })
h('Comment', { fg = p.dm_blue, italic = true })
h('Conditional', { fg = p.fg })
h('Constant', { fg = p.fg_reg })
h('Debug', { fg = p.fg })
h('Define', { fg = p.fg })
h('Delimiter', { fg = p.fg })
h('Directory', { fg = p.fg_reg })
h('Error', { fg = p.error })
h('Exception', { fg = p.fg })
h('Float', { fg = p.fg })
h('Function', { fg = p.blue })
h('Identifier', { fg = p.fg_reg })
h('Include', { fg = p.fg })
h('Include', { fg = p.fg_reg })
h('Keyword', { fg = p.p_grey_blue })
h('Label', { fg = p.fg_reg })
h('Macro', { fg = p.fg })
h('Number', { fg = p.fg_reg })
h('Operator', { fg = p.fg })
h('PreCondit', { fg = p.fg_reg })
h('PreProc', { fg = p.fg_reg })
h('Repeat', { fg = p.fg })
h('Special', { fg = p.fg_high })
h('SpecialChar', { fg = p.fg })
h('SpecialComment', { fg = p.fg })
h('SpecialKey', { fg = p.fg_high })
h('Statement', { fg = p.fg })
h('StorageClass', { fg = p.fg })
h('String', { fg = p.fg })
h('Structure', { fg = p.fg })
h('Tag', { fg = p.fg_high })
h('Todo', { fg = p.info })
h('Type', { fg = p.fg })
h('Typedef', { fg = p.fg })

-- Treesitter syntax
h('TSBoolean', { link = 'Boolean' })
h('TSConstant', { link = 'Constant' })
h('TSField', { fg = p.fg_reg })
h('TSInclude', { link = 'Include' })
h('TSFunction', { link = 'Function' })

h('TSKeyword', { link = 'Keyword' })
h('TSKeywordFunction', { link = 'Keyword' })
h('TSConditional', { link = 'Keyword' })
h('TSFuncBuiltin', { link = 'Keyword' })
h('TSRepeat', { link = 'Keyword' })

h('TSLabel', { link = 'Label' })
h('TSMethod', { fg = p.fg_reg })
h('TSNote', { fg = p.accent })
h('TSNumber', { link = 'Number' })
h('TSParameter', { fg = p.yellow_march })
h('TSProperty', { link = 'TSField' })

h('TSPunctBracket', { fg = p.fg })
h('TSConstructor', { fg = p.fg_reg })

h('TSPunctDelimiter', { link = 'Delimiter' })
h('TSPunctSpecial', { link = 'Special' })
h('TSString', { link = 'String' })
h('TSStringEscape', { link = 'String' })
h('TSTag', { link = 'Tag' })
h('TSTagDelimiter', { link = 'Delimiter' })
h('TSTitle', { link = 'Title' })
h('TSType', { link = 'Type' })
h('TSURI', { link = 'String' })

h('TSVariable', { fg = p.dm_grey_blue })
h('TSVariableBuiltin', { link = 'TSVariable' })

h('TSWarning', { link = 'Todo' }) -- I use the info group instead of warn group

-- Diagnostics
h('DiagnosticError', { fg = p.error, bg = p.error_bg })
h('DiagnosticHint', { fg = p.hint, bg = p.hint_bg })
h('DiagnosticInfo', { fg = p.info, bg = p.info_bg })
h('DiagnosticWarn', { fg = p.warn, bg = p.warn_bg })
h('DiagnosticUnderlineError', { undercurl = true, sp = p.error })
h('DiagnosticUnderlineHint', { undercurl = true, sp = p.hint })
h('DiagnosticUnderlineInfo', { undercurl = true, sp = p.info })
h('DiagnosticUnderlineWarn', { undercurl = true, sp = p.warn })

-- LSP
h('PounceAcceptBest', { bg = p.warn_bg, fg = p.warn })

-- Plugins
h('GitSignsChange', { fg = p.info })
h('GitSignsAdd', { fg = p.hint })
h('GitSignsDelete', { fg = p.error })

-- TODO(santigo-zero):
-- The paramater shouldn't be the same color as variables, check that
-- and maybe use some orange color
