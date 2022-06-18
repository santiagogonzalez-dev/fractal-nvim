vim.api.nvim_cmd({
   cmd = 'highlight',
   args = { 'clear' },
}, {}) -- vim.cmd('highlight clear')

if 1 == vim.fn.exists('syntax_on') then
   vim.api.nvim_cmd({
      cmd = 'syntax',
      args = { 'reset' },
   }, {}) -- vim.cmd('syntax reset')
end

vim.opt.termguicolors = true
vim.g.colors_name = 'jetjbp'

vim.fn.matchadd('ErrorMsg', '\\s\\+$') -- Extra whitespaces will be highlighted

-- Color palette
-- :so $VIMRUNTIME/syntax/hitest.vim
local p = {
   bg_low = '#1a1724',
   bg_med = '#1f1d2e',
   bg_high = '#26233a',

   upper3 = '#C6D0F5',
   upper2 = '#B6BEE3',
   upper1 = '#A5ABD2',
   dimmed1 = '#74749C',
   dimmed2 = '#63618B',
   dimmed3 = '#534f79', -- Used for comments, foldtext and identation/whitespaces spaces
   fg_dim = '#3d3a56',

   red = '#eb6f92',
   maroon = '#EBA0AC',
   orange = '#FAB387',
   yellow = '#f6c177',
   accent = '#FA9336', -- Give accent to things that need attention
   green = '#93c88e',
   strong_green = '#559a8b',
   blue = '#87B0F9',
   purple = '#8689b9',
   violet = '#9d86b9', -- Used in info and diagnostics too
}

local h = function(...)
   return vim.api.nvim_set_hl(0, ...)
end

-- Interface
h('CursorColumn', { bg = p.bg_med }) -- The column of the crosshair of the cursor
h('CursorLine', { bg = p.bg_med }) -- The line of the crosshair of the cursor
h('CursorLineNr', { bg = p.bg_med, fg = p.dimmed2 }) -- Current position of the cursor but in the gutter
h('Cursor', { bg = p.upper2, fg = p.bg_low }) -- This doesn't seem to do anything
h('lCursor', { bg = p.upper2, fg = p.bg_low }) -- This doesn't seem to do anything
h('WarningMsg', { fg = p.yellow }) -- Warning messages
h('ErrorMsg', { link = 'Error' }) -- Error messages on the command line
h('MsgArea', { fg = p.upper1 }) -- Area for messages and cmdline, / and :
h('ModeMsg', { fg = p.upper1 }) -- The 'showmode' message (e.g., '-- INSERT --') uses this
h('LineNr', { bg = p.bg_low, fg = p.fg_dim }) -- The gutter, where relativenumbers and numbers show
h('FoldColumn', { bg = p.bg_low, fg = p.fg_dim }) -- Column to the right of the gutter, shows folds present
h('Folded', { fg = p.dimmed3 }) -- Line that shows foldtext
h('ColorColumn', {}) -- Column that shows limit of characters
h('Conceal', {}) -- Replacement hl group for concealed characters
h('MatchParen', { bg = p.accent, fg = p.bg_low }) -- The character under the cursor or just before it, if it is a paired bracket, and its match
h('NonText', { fg = p.fg_dim }) -- Used in showbreak, listchars and virtualtext
h('Whitespace', { fg = p.fg_dim }) -- Whitespaces, listchars, etc etc.
h('Normal', { bg = p.bg_low, fg = p.upper1 }) -- Normal text
h('NormalFloat', { bg = p.bg_low, fg = p.upper1 }) -- Normal text in floating windows
h('InactiveWindow', { bg = p.bg_med, fg = p.fg }) -- Check why this works and NormalNC doesn't
h('NormalNC', { bg = p.bg_med, fg = p.fg }) -- Normal text in non-current windows
h('EndOfBuffer', { bg = p.bg_low, fg = p.upper1 }) -- Where ~ appear
h('Question', { fg = p.upper1 }) -- hit-enter prompts and yes/no questions
h('IncSearch', { fg = p.orange }) -- Current search pattern when searching with /
h('CurSearch', { link = 'IncSearch' }) -- Current search match under the cursor
h('Search', { bg = p.bg_high, fg = p.orange }) -- Last search pattern
h('Substitute', { fg = p.upper3, bold = true, underline = true }) -- :substitute or :s///gc replacement text highlighting
h('SignColumn', { bg = p.bg_low }) -- Where linting and errors popup
h('StatusLine', { bg = p.bg_med, fg = p.dimmed2 }) -- The statusline
h('StatusLineAccent', { bg = p.bg_high }) -- The same as Visual
h('Title', { fg = p.upper1 }) -- Titles for output from ':set all', ':autocmd' etc.
h('Visual', { bg = p.bg_high }) -- Visual mode uses this
h('VisualNOS', { reverse = true }) -- When vim is not owning the selection
h('VertSplit', { fg = p.fg_dim }) -- The column separating vertically split windows
h('WinSeperator', { fg = p.fg_dim }) -- The line separating split windows
h('Ignore', {})
h('Bold', { bold = true })
h('Italic', { italic = true })
h('Underline', { underline = true })
h('Pmenu', { bg = p.bg_low, fg = p.upper1 })
h('PmenuSbar', { bg = p.dimmed3 })
h('PmenuThumb', { bg = p.fg_dim })
h('PmenuSel', { bg = p.dimmed3, blend = 0 })

-- Syntax
h('Character', { fg = p.upper2 }) -- A character constant: 'c', '\n'
h('Boolean', { fg = p.orange, italic = true }) -- true-false True-False If not setup it uses Constant fg colors
h('Comment', { fg = p.dimmed3, italic = true })
h('Constant', { fg = p.maroon }) -- NOTE: to self, this changes the name in -> TODO(santigo-zero):
h('String', { fg = p.dimmed1 })
h('Number', { fg = p.maroon })
h('Float', { fg = p.orange })
h('Conditional', { fg = p.violet }) -- if, then, else, endif, switch, etc.
h('Repeat', { fg = p.violet }) -- for, while
h('Delimiter', { fg = p.upper2 }) -- . and ,
h('Directory', { fg = p.blue }) -- Directories in NetRW
-- h('Debug', { fg = p.fg })
-- h('Define', { fg = 'blue' })
-- h('Exception', { fg = 'red' })
h('Error', { fg = p.red }) -- Errors
h('Function', { fg = p.violet }) -- The name of the function, my_func(), not the keyword
h('Keyword', { fg = p.violet, italic = true }) -- Like function, or local
-- h('Identifier', { fg = p.fg_reg })
h('Include', { fg = p.violet }) -- from ... import ...
-- h('Label', { fg = p.fg_reg })
-- h('Macro', { fg = p.fg })
-- h('Operator', { fg = p.fg })
-- h('PreCondit', { fg = p.fg_reg })
-- h('PreProc', { fg = p.fg_reg })
h('Special', { fg = p.upper3 })
h('SpecialChar', { fg = p.violet })
h('SpecialComment', { fg = p.violet })
h('SpecialKey', { fg = p.upper3 })
h('Statement', { fg = p.red }) -- The = and ==
h('StorageClass', { fg = p.violet })
h('Structure', { fg = p.violet })
h('Tag', { fg = p.upper3 })
h('Todo', { fg = p.violet, bold = true }) -- INUPPERCASE: FIXME / TODO(santigo-zero):
h('Type', { fg = p.violet }) -- The name of a class, not the class keyword
h('Typedef', { fg = p.upper1 })

-- Treesitter syntax
h('TSBoolean', { link = 'Boolean' })
h('TSCharacter', { link = 'Character' })
h('TSConstant', { link = 'Constant' })
h('TSConstBuiltin', { fg = p.maroon })
h('TSComment', { link = 'Comment' })
h('TSField', { fg = p.strong_green }) -- Elements of a table or api in vim.api and ui in vim.ui, or bold in bold = true
h('TSInclude', { link = 'Include' })
h('TSFunction', { fg = p.blue }) -- The name of the function, my_func(), not the keyword
h('TSKeywordFunction', { link = 'Function' }) -- The function or def keyword
h('TSKeyword', { link = 'Keyword' })
h('TSKeywordReturn', { link = 'Keyword' }) -- The return keyword
h('TSConditional', { link = 'Conditional' }) -- If, then, else, endif, switch, case, etc.
h('TSRepeat', { link = 'Repeat' }) -- for, while
h('TSFuncBuiltin', { fg = p.green }) -- Try use a purple color in here
h('TSVariableBuiltin', { fg = p.upper3 })
-- h('TSLabel', { link = 'Label' })
-- h('TSMethod', { fg = p.fg_reg })
-- h('TSNote', { fg = p.accent })
h('TSNumber', { link = 'Number' })
h('TSParameter', { fg = p.maroon })
h('TSPunctBracket', { fg = p.dimmed2 })
h('TSConstructor', { fg = p.upper1 })
h('TSPunctDelimiter', { link = 'Delimiter' })
h('TSPunctSpecial', { link = 'Special' })
h('TSString', { link = 'String' })
h('TSFuncMacro', { link = 'String' })
h('TSStringSpecial', { link = 'String' })
h('TSTag', { link = 'Tag' })
h('TSTagDelimiter', { link = 'Delimiter' })
h('TSTitle', { link = 'Title' })
h('TSType', { link = 'Type' }) -- The name of a class, not the class keyword
h('TSURI', { link = 'String' }) -- Links
h('TSVariable', { fg = p.dimmed1 })
-- h('TSWarning', { link = 'Todo' }) -- Is this actually a treesitter hl group?
h('TSKeywordOperator', { fg = p.violet })

-- Diagnostics
-- LspCodeLens LspCodeLensSeparator
h('DiagnosticError', { fg = p.red })
h('DiagnosticHint', { fg = p.blue })
h('DiagnosticInfo', { fg = p.violet })
h('DiagnosticWarn', { fg = p.yellow })
h('DiagnosticUnderlineError', { undercurl = true, sp = p.red })
h('DiagnosticUnderlineHint', { undercurl = true, sp = p.blue })
h('DiagnosticUnderlineInfo', { undercurl = true, sp = p.violet })
h('DiagnosticUnderlineWarn', { undercurl = true, sp = p.yellow })
h('GitSignsChange', { fg = p.violet }) -- Don't set up a background for GitSigns
h('GitSignsAdd', { fg = p.blue })
h('GitSignsDelete', { fg = p.red })
h('LspReferenceRead', { fg = p.orange }) -- When you call a function or use a method/class
h('LspReferenceText', { fg = p.orange })
h('LspReferenceWrite', { fg = p.orange }) -- When you define a variable or function

-- -- Plugins -- TODO remove IndentBlankline
-- h('IndentBlanklineChar', { fg = p.fg_dim })
-- h('IndentBlanklineContextChar', { fg = p.blue })

h('IndentScopeSymbol', { fg = p.fg_dim })
h('IndentScopePrefix', { fg = p.blue })
