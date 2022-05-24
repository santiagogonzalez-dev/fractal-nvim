local colors = {}
vim.cmd('highlight clear')

if 1 == vim.fn.exists('syntax_on') then
   vim.cmd('syntax reset')
end

vim.opt.termguicolors = true
vim.g.colors_name = 'jetjbp'

vim.fn.matchadd('ErrorMsg', '\\s\\+$') -- Extra whitespaces will be highlighted

-- Color palette
colors.palette = {
   -- Background
   bg = '#1a1724',
   bg2 = '#211f2c',

   -- Foreground
   fg = '#aeacc0',
   fg2 = '#c1bfd5',
   fg_dim = '#3d3a56',
   fg_dim2 = '#534f79', -- Used for comments, foldtext and identation/whitespaces spaces
   fg_grey = '#646186',

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
h('CursorColumn', { bg = colors.palette.bg2 }) -- The column of the crosshair of the cursor
h('CursorLine', { bg = colors.palette.bg2 }) -- The line of the crosshair of the cursor
h('CursorLineNr', { bg = colors.palette.bg2, fg = colors.palette.orange }) -- Current position of the cursor but in the gutter
h('Cursor', { bg = colors.palette.fg2, fg = colors.palette.bg }) -- This doesn't seem to do anything
h('lCursor', { bg = colors.palette.fg2, fg = colors.palette.bg }) -- This doesn't seem to do anything
h('WarningMsg', { fg = colors.palette.yellow }) -- Warning messages
h('ErrorMsg', { link = 'Error' }) -- Error messages on the command line
h('MsgArea', { fg = colors.palette.fg }) -- Area for messages and cmdline, / and :
h('ModeMsg', { fg = colors.palette.fg }) -- The 'showmode' message (e.g., '-- INSERT --') uses this
h('LineNr', { bg = colors.palette.bg, fg = colors.palette.fg_dim }) -- The gutter, where relativenumbers and numbers show
h('FoldColumn', { bg = colors.palette.bg, fg = colors.palette.fg_dim }) -- Column to the right of the gutter, shows folds present
h('Folded', { fg = colors.palette.fg_dim2 }) -- Line that shows foldtext, TODO: Do we want folds to be just like comments?
h('ColorColumn', {}) -- Column that shows limit of characters
h('Conceal', {}) -- Replacement hl group for concealed characters
h('MatchParen', { bg = colors.palette.orange, fg = colors.palette.bg }) -- The character under the cursor or just before it, if it is a paired bracket, and its match
h('NonText', { fg = colors.palette.fg_dim }) -- Used in showbreak, listchars and virtualtext
h('Whitespace', { bg = colors.palette.bg, fg = colors.palette.fg_dim2 }) -- Whitespaces
h('Normal', { bg = colors.palette.bg, fg = colors.palette.fg }) -- Normal text
h('NormalFloat', { bg = colors.palette.bg, fg = colors.palette.fg }) -- Normal text in floating windows
h('InactiveWindow', { bg = colors.palette.bg2, fg = colors.palette.fg }) -- Check why this works and NormalNC doesn't
h('NormalNC', { bg = colors.palette.bg2, fg = colors.palette.fg }) -- Normal text in non-current windows
h('EndOfBuffer', { bg = colors.palette.bg, fg = colors.palette.fg }) -- Where ~ appear
h('Question', { fg = colors.palette.fg }) -- hit-enter prompts and yes/no questions
h('IncSearch', { fg = colors.palette.orange, bold = true }) -- Current search pattern when searching with /
h('CurSearch', { link = 'IncSearch' }) -- Current search match under the cursor
h('Search', { bg = colors.palette.orange, fg = colors.palette.fg_dim }) -- Last search pattern
h('Substitute', { fg = colors.palette.orange, bold = true, underline = true }) -- :substitute or :s///gc replacement text highlighting
h('SignColumn', { bg = colors.palette.bg }) -- Where linting and errors popup
h('StatusLine', { bg = colors.palette.bg, fg = colors.palette.fg }) -- The statusline
h('StatusLineNC', { bg = colors.palette.bg, fg = colors.palette.fg }) -- The non-current statusline
h('Title', { fg = colors.palette.fg }) -- Titles for output from ':set all', ':autocmd' etc.
h('Visual', { reverse = true }) -- Visual mode uses this
h('VisualNOS', { reverse = true }) -- When vim is not owning the selection
h('VertSplit', { fg = colors.palette.fg_dim }) -- The column separating vertically split windows
h('WinSeperator', { fg = colors.palette.fg_dim }) -- The line separating split windows
h('Ignore', {})
h('Bold', { bold = true })
h('Italic', { italic = true })
h('Underline', { underline = true })
h('Pmenu', { bg = colors.palette.bg, fg = colors.palette.fg })
h('PmenuSbar', { bg = colors.palette.fg_dim2 })
h('PmenuThumb', { bg = colors.palette.fg_dim })
h('PmenuSel', { bg = colors.palette.fg_dim2, blend = 0 })

-- Syntax
h('Character', { fg = colors.palette.fg2 }) -- A character constant: 'c', '\n'
h('Boolean', { fg = colors.palette.yellow, italic = true }) -- true-false True-False If not setup it uses Constant fg colors
h('Comment', { fg = colors.palette.fg_dim2, italic = true })
h('Constant', { fg = colors.palette.red }) -- NOTE: to self, this changes the name in -> TODO(santigo-zero):
h('String', { fg = colors.palette.pink })
h('Number', { fg = colors.palette.red })
h('Float', { fg = colors.palette.red })
h('Keyword', { fg = colors.palette.purple_td }) -- Like function, or local
h('Conditional', { fg = colors.palette.fg_grey }) -- if, then, else, endif, switch, etc.
h('Repeat', { fg = colors.palette.fg_grey }) -- for, while
-- h('Debug', { fg = p.fg })
-- h('Define', { fg = p.fg })
h('Delimiter', { fg = colors.palette.fg2 }) -- . and ,
-- h('Directory', { fg = p.fg_reg })
-- h('Exception', { fg = p.fg })
h('Error', { bg = colors.palette.red_bg, fg = colors.palette.red }) -- Errors
h('Function', { fg = colors.palette.blue_alt }) -- The name of the function, my_func(), not the keyword
-- h('Identifier', { fg = p.fg_reg })
h('Include', { fg = colors.palette.fg2 }) -- from ... import ...
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
h('Todo', { fg = colors.palette.purple, bold = true }) -- INUPPERCASE: FIXME / TODO(santigo-zero):
h('Type', { fg = colors.palette.purple }) -- The name of a class, not the class keyword
-- h('Typedef', { fg = p.fg })
h('Statement', { fg = colors.palette.fg }) -- The = and ==

-- Treesitter syntax
h('TSBoolean', { link = 'Boolean' })
h('TSCharacter', { link = 'Character' })
h('TSConstant', { link = 'Constant' })
h('TSConstBuiltin', { fg = colors.palette.red })
h('TSComment', { link = 'Comment' })
h('TSField', { fg = colors.palette.light_blue }) -- Elements of a table or api in vim.api and ui in vim.ui, or bold in bold = true
h('TSInclude', { link = 'Include' })
h('TSFunction', { link = 'Function' }) -- The name of the function, my_func(), not the keyword
-- h('TSKeyword', { link = 'Keyword' })
h('TSKeywordReturn', { fg = colors.palette.purple_td, bold = true }) -- The return keyword
h('TSKeywordFunction', { fg = colors.palette.fg_grey }) -- The function or def keyword
h('TSConditional', { link = 'Conditional' }) -- If, then, else, endif, switch, case, etc.
h('TSRepeat', { link = 'Repeat' }) -- for, while
h('TSFuncBuiltin', { link = 'Keyword' }) -- Try use a purple color in here
h('TSVariableBuiltin', { fg = colors.palette.purple })
-- h('TSLabel', { link = 'Label' })
-- h('TSMethod', { fg = p.fg_reg })
-- h('TSNote', { fg = p.accent })
h('TSNumber', { link = 'Number' })
h('TSParameter', { fg = colors.palette.purple })
-- h('TSProperty', { link = 'TSField' })
h('TSPunctBracket', { fg = colors.palette.fg })
h('TSConstructor', { fg = colors.palette.green })
h('TSPunctDelimiter', { link = 'Delimiter' })
h('TSPunctSpecial', { link = 'Special' })
h('TSString', { link = 'String' })
h('TSFuncMacro', { link = 'String' })
h('TSStringSpecial', { link = 'String' })
-- h('TSTag', { link = 'Tag' })
h('TSTagDelimiter', { link = 'Delimiter' })
h('TSTitle', { link = 'Title' })
h('TSType', { link = 'Type' }) -- The name of a class, not the class keyword
h('TSURI', { link = 'String' }) -- Links
h('TSVariable', { fg = colors.palette.purple_td })
-- h('TSWarning', { link = 'Todo' }) -- Is this actually a treesitter hl group?
h('TSKeywordOperator', { fg = colors.palette.purple })

-- Diagnostics
-- LspCodeLens LspCodeLensSeparator
h('DiagnosticError', { bg = colors.palette.red_bg, fg = colors.palette.red })
h('DiagnosticHint', { bg = colors.palette.green_bg, fg = colors.palette.green })
h('DiagnosticInfo', { bg = colors.palette.purple_td_bg, fg = colors.palette.purple_td })
h('DiagnosticWarn', { bg = colors.palette.yellow_bg, fg = colors.palette.yellow })
h('DiagnosticUnderlineError', { undercurl = true, sp = colors.palette.red })
h('DiagnosticUnderlineHint', { undercurl = true, sp = colors.palette.green })
h('DiagnosticUnderlineInfo', { undercurl = true, sp = colors.palette.purple_td })
h('DiagnosticUnderlineWarn', { undercurl = true, sp = colors.palette.yellow })
h('GitSignsChange', { fg = colors.palette.purple_td }) -- Don't set up a background for GitSigns
h('GitSignsAdd', { fg = colors.palette.green })
h('GitSignsDelete', { fg = colors.palette.red })
h('LspReferenceRead', { bg = colors.palette.purple_td_bg, fg = colors.palette.purple_td }) -- When you call a function or use a method/class
h('LspReferenceText', { bg = colors.palette.purple_td_bg, fg = colors.palette.purple_td })
h('LspReferenceWrite', { bg = colors.palette.purple_td_bg, fg = colors.palette.purple_td }) -- When you define a variable or function

-- Plugins
h('IndentBlanklineChar', { fg = colors.palette.fg_dim })
h('IndentBlanklineContextChar', { fg = colors.palette.green })

return colors
