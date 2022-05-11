-- vim.o.termguicolors = true -- Enable colors in the terminal

-- vim.cmd([[
--     set background=dark
--     colorscheme csjcolors
-- ]])

vim.cmd('highlight clear')

if 1 == vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
end

vim.opt.termguicolors = true
vim.g.colors_name = 'csjcolors'

vim.fn.matchadd('ErrorMsg', '\\s\\+$') -- Extra whitespaces will be highlighted

-- Color palette
local p = {
    -- Background
    bg = '#1a1724',
    bg2 = '#211f2c',

    -- Foreground
    fg = '#aeacc0',
    fg2 = '#c1bfd5',
    fg_dim = '#3d3a56',
    fg_dim2 = '#534f79', -- Used for comments, foldtext and identation/whitespaces spaces

    -- Red
    red = '#eb6f92', -- Used in errors and diagnostics too

    -- Pink
    pink = '#FF99C9', -- Used in strings

    -- Orange
    orange = '#FA9336', -- Give accent to things that need attention

    -- Yellow
    yellow = '#f6c177', -- Used in warnings and diagnostics too

    -- Green
    green = '#339899',

    -- LightBlue
    light_blue = '#73CEF4',
    light_blue2 = '#B4E6F8',

    -- Blue
    blue_alt = '#7AA2F7',
    teal = '#28728F',

    -- Purple
    purple = '#BB9AF7', -- Used for information, some things that need to be highlighted
    purple_td = '#9d86b9', -- Used in info and diagnostics too

    -- Background colors for colors
    -- TODO(santigo-zero): Outdated colors
    red_bg = '#3C2636', -- bg for red
    yellow_bg = '#3E3332', -- bg for yellow
    purple_td_bg = '#2F2A3D', -- bg for purple
    green_bg = '#1D2E35', -- bg for green
}

local h = function(...)
    return vim.api.nvim_set_hl(0, ...)
end

-- Interface
h('CursorColumn', { bg = p.bg2 }) -- The column of the crosshair of the cursor
h('CursorLine', { bg = p.bg2 }) -- The line of the crosshair of the cursor
h('CursorLineNr', { bg = p.bg2, fg = p.fg2 }) -- Current position of the cursor but in the gutter
h('Cursor', { bg = p.fg2, fg = p.bg }) -- This doesn't seem to do anything
h('lCursor', { bg = p.fg2, fg = p.bg }) -- This doesn't seem to do anything
h('WarningMsg', { fg = p.yellow }) -- Warning messages
h('ErrorMsg', { link = 'Error' }) -- Error messages on the command line
h('MsgArea', { fg = p.fg }) -- Area for messages and cmdline, / and :
h('ModeMsg', { fg = p.fg }) -- The 'showmode' message (e.g., '-- INSERT --') uses this
h('LineNr', { bg = p.bg, fg = p.fg_dim2 }) -- The gutter, where relativenumbers and numbers show
h('FoldColumn', { bg = p.bg, fg = p.fg_dim }) -- Column to the right of the gutter, shows folds present
h('Folded', { fg = p.fg_dim2 }) -- Line that shows foldtext, TODO: Do we want folds to be just like comments?
h('ColorColumn', {}) -- Column that shows limit of characters
h('Conceal', {}) -- Replacement hl group for concealed characters
h('MatchParen', { bg = p.orange, fg = p.bg }) -- The character under the cursor or just before it, if it is a paired bracket, and its match
h('NonText', { fg = p.fg_dim }) -- Used in showbreak, listchars and virtualtext
h('Whitespace', { bg = p.bg, fg = p.fg_dim2 }) -- Whitespaces
h('Normal', { bg = p.bg, fg = p.fg }) -- Normal text
h('NormalFloat', { bg = p.bg, fg = p.fg }) -- Normal text in floating windows
h('InactiveWindow', { bg = p.bg2, fg = p.fg }) -- Check why this works and NormalNC doesn't
h('NormalNC', { bg = p.bg2, fg = p.fg }) -- Normal text in non-current windows
h('EndOfBuffer', { bg = p.bg, fg = p.fg }) -- Where ~ appear
h('Question', { fg = p.fg }) -- hit-enter prompts and yes/no questions
h('IncSearch', { fg = p.fg2, bold = true }) -- Current search pattern when searching with /
h('CurSearch', { link = 'IncSearch' }) -- Current search match under the cursor
h('Search', { bg = p.orange, fg = p.fg_dim }) -- Last search pattern
h('Substitute', { fg = p.orange, bold = true, underline = true }) -- :substitute or :s///gc replacement text highlighting
h('SignColumn', { bg = p.bg }) -- Where linting and errors popup
h('StatusLine', { bg = p.bg, fg = p.fg }) -- The statusline
h('StatusLineNC', { bg = p.bg, fg = p.fg }) -- The non-current statusline
h('Title', { fg = p.fg }) -- Titles for output from ':set all', ':autocmd' etc.
h('Visual', { reverse = true }) -- Visual mode uses this
h('VisualNOS', { reverse = true }) -- When vim is not owning the selection
h('VertSplit', { fg = p.fg_dim }) -- The column separating vertically split windows
h('WinSeperator', { fg = p.fg_dim }) -- The line separating split windows
h('Ignore', {})
h('Bold', { bold = true })
h('Italic', { italic = true })
h('Underline', { underline = true })
-- h('Pmenu', { bg = p.bg_reg, fg = p.fg_reg })
-- h('PmenuSbar', { bg = p.bg_high })
-- h('PmenuSel', { bg = p.bg_high, fg = p.text })
-- h('PmenuThumb', { bg = p.fg })

-- Syntax
h('Character', { fg = p.fg2 }) -- A character constant: 'c', '\n'
h('Boolean', { fg = p.yellow, italic = true }) -- true-false True-False If not setup it uses Constant fg colors
h('Comment', { fg = p.fg_dim2, italic = true })
h('Constant', { fg = p.red }) -- NOTE: to self, this changes the name in -> TODO(santigo-zero):
h('String', { fg = p.pink })
h('Number', { fg = p.red })
h('Float', { fg = p.red })
h('Keyword', { fg = p.purple_td }) -- Like function, or local
h('Conditional', { fg = p.purple_td }) -- if, then, else, endif, switch, etc.
h('Repeat', { fg = p.purple_td }) -- for, while
-- h('Debug', { fg = p.fg })
-- h('Define', { fg = p.fg })
h('Delimiter', { fg = p.fg2 }) -- . and ,
-- h('Directory', { fg = p.fg_reg })
-- h('Exception', { fg = p.fg })
h('Error', { bg = p.red_bg, fg = p.red }) -- Errors
h('Function', { fg = p.blue_alt, italic = true }) -- The name of the function, my_func(), not the keyword
-- h('Identifier', { fg = p.fg_reg })
h('Include', { fg = p.fg2 }) -- from ... import ...
-- h('Label', { fg = p.fg_reg })
-- h('Macro', { fg = p.fg })
-- h('Operator', { fg = p.fg })
-- h('PreCondit', { fg = p.fg_reg })
-- h('PreProc', { fg = p.fg_reg })
-- h('Special', { fg = p.fg_high })
-- h('SpecialChar', { fg = p.fg })
-- h('SpecialComment', { fg = p.fg })
-- h('SpecialKey', { fg = p.fg_high })
-- h('Statement', { fg = p.fg })
-- h('StorageClass', { fg = p.fg })
-- h('Structure', { fg = p.fg })
-- h('Tag', { fg = p.fg_high })
h('Todo', { fg = p.purple, bold = true }) -- INUPPERCASE: FIXME / TODO(santigo-zero):
h('Type', { fg = p.purple }) -- The name of a class, not the class keyword
-- h('Typedef', { fg = p.fg })
h('Statement', { fg = p.fg }) -- The = and ==

vim.api.nvim_create_autocmd('UIEnter', {
    callback = function()
        if not package.loaded['nvim-treesitter'] then
            return
        end

        -- Treesitter syntax
        h('TSBoolean', { link = 'Boolean' })
        h('TSCharacter', { link = 'Character' })
        h('TSConstant', { link = 'Constant' })
        h('TSConstBuiltin', { fg = p.red })
        h('TSComment', { link = 'Comment' })
        h('TSField', { fg = p.light_blue }) -- Elements of a table or api in vim.api and ui in vim.ui, or bold in bold = true
        h('TSInclude', { link = 'Include' })
        h('TSFunction', { link = 'Function' }) -- The name of the function, my_func(), not the keyword
        -- h('TSKeyword', { link = 'Keyword' })
        h('TSKeywordReturn', { fg = p.purple_td, bold = true }) -- The return keyword
        h('TSKeywordFunction', { link = 'Keyword' }) -- The function or def keyword
        h('TSConditional', { link = 'Conditional' }) -- If, then, else, endif, switch, case, etc.
        h('TSRepeat', { link = 'Repeat' }) -- for, while
        h('TSFuncBuiltin', { link = 'Keyword' }) -- Try use a purple color in here
        h('TSVariableBuiltin', { fg = p.purple })
        -- h('TSLabel', { link = 'Label' })
        -- h('TSMethod', { fg = p.fg_reg })
        -- h('TSNote', { fg = p.accent })
        h('TSNumber', { link = 'Number' })
        h('TSParameter', { fg = p.purple })
        -- h('TSProperty', { link = 'TSField' })
        h('TSPunctBracket', { fg = p.fg })
        h('TSConstructor', { fg = p.yellow })
        h('TSPunctDelimiter', { link = 'Delimiter' })
        h('TSPunctSpecial', { link = 'Special' })
        h('TSString', { link = 'String' })
        h('TSFuncMacro', { link = 'String' })
        h('TSStringSpecial', { link = 'String' })
        h('TSStringEscape', { link = p.green })
        -- h('TSTag', { link = 'Tag' })
        h('TSTagDelimiter', { link = 'Delimiter' })
        h('TSTitle', { link = 'Title' })
        h('TSType', { link = 'Type' }) -- The name of a class, not the class keyword
        h('TSURI', { link = 'String' }) -- Links
        h('TSVariable', { fg = p.purple_td })
        -- h('TSWarning', { link = 'Todo' }) -- Is this actually a treesitter hl group?
        h('TSKeywordOperator', { fg = p.purple })
    end
})

-- Diagnostics
-- LspCodeLens LspCodeLensSeparator
h('LspDocumentHighlight', { bg = p.yellow_bg, fg = p.yellow })
h('DiagnosticError', { bg = p.red_bg, fg = p.red })
h('DiagnosticHint', { bg = p.green_bg, fg = p.green })
h('DiagnosticInfo', { bg = p.purple_td_bg, fg = p.purple_td })
h('DiagnosticWarn', { bg = p.yellow_bg, fg = p.yellow })
h('DiagnosticUnderlineError', { undercurl = true, sp = p.red })
h('DiagnosticUnderlineHint', { undercurl = true, sp = p.green })
h('DiagnosticUnderlineInfo', { undercurl = true, sp = p.purple_td })
h('DiagnosticUnderlineWarn', { undercurl = true, sp = p.yellow })
h('GitSignsChange', { fg = p.purple_td }) -- Don't set up a background for GitSigns
h('GitSignsAdd', { fg = p.green })
h('GitSignsDelete', { fg = p.red })
