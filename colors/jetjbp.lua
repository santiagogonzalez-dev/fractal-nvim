-- TODO(santigo-zero): colors for diff (-d flag)
vim.cmd.highlight { args = { 'clear' } }

if 1 == vim.fn.exists('syntax_on') then
  vim.cmd.syntax('reset')
end

vim.opt.termguicolors = true
vim.g.colors_name = 'jetjbp'

vim.fn.matchadd('ErrorMsg', '\\s\\+$') -- Extra whitespaces will be highlighted

-- -- Color palette
-- -- :so $VIMRUNTIME/syntax/hitest.vim
-- local p = {
--   bg_low = '#1a1724',
--   bg_med = '#1f1d2e',
--   bg_high = '#26233a',

--   upper3 = '#C6D0F5',
--   upper2 = '#B6BEE3',
--   upper1 = '#A5ABD2',
--   dimmed1 = '#74749C',
--   dimmed2 = '#63618B',
--   dimmed3 = '#534f79', -- Used for comments, foldtext and identation/whitespaces spaces
--   fg_dim = '#3d3a56',

--   red = '#eb6f92',
--   maroon = '#EBA0AC',
--   orange = '#FAB387',
--   yellow = '#f6c177',
--   accent = '#FA9336', -- Give accent to things that need attention
--   green = '#93c88e',
--   strong_green = '#559a8b',
--   blue = '#87B0F9',
--   purple = '#8689b9',
--   violet = '#9d86b9', -- Used in info and diagnostics too
-- }

-- local h = function(...)
--   return vim.api.nvim_set_hl(0, ...)
-- end

-- -- Interface
-- h('CursorColumn', { bg = p.bg_med }) -- The column of the crosshair of the cursor
-- h('CursorLine', { bg = p.bg_med }) -- The line of the crosshair of the cursor
-- h('CursorLineNr', { bg = p.bg_med, fg = p.dimmed2 }) -- Current position of the cursor but in the gutter
-- h('Cursor', { bg = p.upper2, fg = p.bg_low }) -- This doesn't seem to do anything
-- h('lCursor', { bg = p.upper2, fg = p.bg_low }) -- This doesn't seem to do anything
-- h('WarningMsg', { fg = p.yellow }) -- Warning messages
-- h('ErrorMsg', { link = 'Error' }) -- Error messages on the command line
-- h('MsgArea', { fg = p.upper1 }) -- Area for messages and cmdline, / and :
-- h('ModeMsg', { fg = p.upper1 }) -- The 'showmode' message (e.g., '-- INSERT --') uses this
-- h('LineNr', { bg = p.bg_low, fg = p.fg_dim }) -- The gutter, where relativenumbers and numbers show
-- h('FoldColumn', { bg = p.bg_low, fg = p.fg_dim }) -- Column to the right of the gutter, shows folds present
-- h('Folded', { fg = p.dimmed3 }) -- Line that shows foldtext
-- h('ColorColumn', {}) -- Column that shows limit of characters
-- h('Conceal', {}) -- Replacement hl group for concealed characters
-- h('MatchParen', { bg = p.accent, fg = p.bg_low }) -- The character under the cursor or just before it, if it is a paired bracket, and its match
-- h('NonText', { fg = p.fg_dim }) -- Used in showbreak, listchars and virtualtext
-- h('Whitespace', { fg = p.fg_dim }) -- Whitespaces, listchars, etc etc.
-- h('Normal', { bg = p.bg_low, fg = p.upper1 }) -- Normal text
-- h('NormalFloat', { bg = p.bg_low, fg = p.upper1 }) -- Normal text in floating windows
-- h('InactiveWindow', { bg = p.bg_med, fg = p.fg }) -- Check why this works and NormalNC doesn't
-- h('NormalNC', { bg = p.bg_med, fg = p.fg }) -- Normal text in non-current windows
-- h('EndOfBuffer', { bg = p.bg_low, fg = p.upper1 }) -- Where ~ appear
-- h('Question', { fg = p.upper1 }) -- hit-enter prompts and yes/no questions
-- h('IncSearch', { bg = p.bg_high, fg = p.blue }) -- Current search pattern when searching with /
-- h('CurSearch', { bg = p.bg_high, fg = p.blue }) -- Current search match under the cursor
-- h('Search', { bg = p.bg_high, fg = p.orange }) -- Last search pattern
-- h('Substitute', { bg = p.bg_high, fg = p.violet }) -- :substitute or :s///gc replacement text highlighting
-- h('SignColumn', { bg = p.bg_low }) -- Where linting and errors popup
-- h('Title', { fg = p.upper1 }) -- Titles for output from ':set all', ':autocmd' etc.
-- h('Visual', { bg = p.bg_high }) -- Visual mode uses this
-- h('VisualNOS', { reverse = true }) -- When vim is not owning the selection
-- h('VertSplit', { fg = p.fg_dim }) -- The column separating vertically split windows
-- h('WinSeperator', { fg = p.fg_dim }) -- The line separating split windows
-- h('Ignore', {})
-- h('Bold', { bold = true })
-- h('Italic', { italic = true })
-- h('Underline', { underline = true })
-- h('Pmenu', { bg = p.bg_low, fg = p.upper1 })
-- h('PmenuSbar', { bg = p.dimmed3 })
-- h('PmenuThumb', { bg = p.fg_dim })
-- h('PmenuSel', { bg = p.dimmed3, blend = 0 })

-- -- StatusLine
-- h('StatusLine', { bg = p.bg_low, fg = p.dimmed1 }) -- The statusline
-- h('StatusLineAccent', { bg = p.bg_high }) -- The same as Visual
-- h('StatusLineAccentBlue', { fg = p.blue }) -- The statusline

-- -- Syntax
-- h('Character', { fg = p.upper2 }) -- A character constant: 'c', '\n'
-- h('Boolean', { fg = p.orange, italic = true }) -- true-false True-False If not setup it uses Constant fg colors
-- h('Comment', { fg = p.dimmed3, italic = true })
-- h('Constant', { fg = p.maroon }) -- NOTE: to self, this changes the name in -> TODO(santigo-zero):
-- h('String', { fg = p.dimmed1 })
-- h('Number', { fg = p.maroon })
-- h('Float', { fg = p.orange })
-- h('Conditional', { fg = p.violet }) -- if, then, else, endif, switch, etc.
-- h('Repeat', { fg = p.violet }) -- for, while
-- h('Delimiter', { fg = p.upper2 }) -- . and ,
-- h('Directory', { fg = p.blue }) -- Directories in NetRW
-- -- h('Debug', { fg = p.fg })
-- -- h('Define', { fg = 'blue' })
-- -- h('Exception', { fg = 'red' })
-- h('Error', { fg = p.red }) -- Errors
-- h('Function', { fg = p.violet }) -- The name of the function, my_func(), not the keyword
-- h('Keyword', { fg = p.violet }) -- Like function, or local
-- -- h('Identifier', { fg = p.fg_reg })
-- h('Include', { fg = p.violet }) -- from ... import ...
-- -- h('Label', { fg = p.fg_reg })
-- -- h('Macro', { fg = p.fg })
-- -- h('Operator', { fg = p.fg })
-- -- h('PreCondit', { fg = p.fg_reg })
-- -- h('PreProc', { fg = p.fg_reg })
-- h('Special', { fg = p.upper3 })
-- h('SpecialChar', { fg = p.violet })
-- h('SpecialComment', { fg = p.violet })
-- h('SpecialKey', { fg = p.upper3 })
-- h('Statement', { fg = p.red }) -- The = and ==
-- h('StorageClass', { fg = p.violet })
-- h('Structure', { fg = p.violet })
-- h('Tag', { fg = p.upper3 })
-- h('Todo', { fg = p.violet, bold = true }) -- INUPPERCASE: FIXME / TODO(santigo-zero):
-- h('Type', { fg = p.violet }) -- The name of a class, not the class keyword
-- h('Typedef', { fg = p.upper1 })

-- -- Treesitter syntax
-- h('TSBoolean', { link = 'Boolean' })
-- h('TSCharacter', { link = 'Character' })
-- h('TSConstant', { link = 'Constant' })
-- h('TSConstBuiltin', { fg = p.maroon })
-- h('TSComment', { link = 'Comment' })
-- h('TSField', { fg = p.strong_green }) -- Elements of a table or api in vim.api and ui in vim.ui, or bold in bold = true
-- h('TSInclude', { link = 'Include' })
-- h('TSFunction', { fg = p.blue }) -- The name of the function, my_func(), not the keyword
-- h('TSKeywordFunction', { link = 'Function' }) -- The function or def keyword
-- h('TSKeyword', { link = 'Keyword' })
-- h('TSKeywordReturn', { link = 'Keyword' }) -- The return keyword
-- h('TSConditional', { link = 'Conditional' }) -- If, then, else, endif, switch, case, etc.
-- h('TSRepeat', { link = 'Repeat' }) -- for, while
-- h('TSFuncBuiltin', { fg = p.green }) -- Try use a purple color in here
-- h('TSVariableBuiltin', { fg = p.upper3 })
-- -- h('TSLabel', { link = 'Label' })
-- -- h('TSMethod', { fg = p.fg_reg })
-- -- h('TSNote', { fg = p.accent })
-- h('TSNumber', { link = 'Number' })
-- h('TSParameter', { fg = p.maroon })
-- h('TSPunctBracket', { fg = p.dimmed2 })
-- h('TSConstructor', { fg = p.upper1 })
-- h('TSPunctDelimiter', { link = 'Delimiter' })
-- h('TSPunctSpecial', { link = 'Special' })
-- h('TSString', { link = 'String' })
-- h('TSFuncMacro', { link = 'String' })
-- h('TSStringSpecial', { link = 'String' })
-- h('TSTag', { link = 'Tag' })
-- h('TSTagDelimiter', { link = 'Delimiter' })
-- h('TSTitle', { link = 'Title' })
-- h('TSType', { link = 'Type' }) -- The name of a class, not the class keyword
-- h('TSURI', { link = 'String' }) -- Links
-- h('TSVariable', { fg = p.dimmed1 })
-- -- h('TSWarning', { link = 'Todo' }) -- Is this actually a treesitter hl group?
-- h('TSKeywordOperator', { fg = p.violet })
-- h('TSProperty', { fg = p.strong_green })
-- h('TSTagDelimiter', { fg = p.dimmed1 })
-- h('TSNone', { fg = p.dimmed1 })
-- h('TSTag', { fg = p.dimmed1 })

-- -- Diagnostics
-- -- LspCodeLens LspCodeLensSeparator
-- h('DiagnosticError', { fg = p.red })
-- h('DiagnosticHint', { fg = p.blue })
-- h('DiagnosticInfo', { fg = p.violet })
-- h('DiagnosticWarn', { fg = p.yellow })
-- h('DiagnosticUnderlineError', { undercurl = true, sp = p.red })
-- h('DiagnosticUnderlineHint', { undercurl = true, sp = p.blue })
-- h('DiagnosticUnderlineInfo', { undercurl = true, sp = p.violet })
-- h('DiagnosticUnderlineWarn', { undercurl = true, sp = p.yellow })
-- h('GitSignsChange', { fg = p.violet }) -- Don't set up a background for GitSigns
-- h('GitSignsAdd', { fg = p.blue })
-- h('GitSignsDelete', { fg = p.red })
-- h('LspReferenceRead', { fg = p.orange, bg = p.bg_high }) -- When you call a function or use a method/class
-- h('LspReferenceText', { fg = p.orange, bg = p.bg_high })
-- h('LspReferenceWrite', { fg = p.orange, bg = p.bg_high }) -- When you define a variable or function

-- -- Plugins
-- -- IndentBlankline
-- h('IndentBlanklineChar', { fg = p.fg_dim })
-- h('IndentBlanklineContextChar', { fg = p.blue })

-- -- CMP
-- h('CmpItemAbbrDeprecated', { strikethrough = true, fg = p.strong_green })
-- h('CmpItemAbbrMatch', { bold = true, fg = p.maroon })
-- h('CmpItemAbbrMatchFuzzy', { bold = true, fg = p.maroon })
-- h('CmpItemKindVariable', { fg = p.green })
-- h('CmpItemKindInterface', { fg = p.green })
-- h('CmpItemKindFunction', { fg = p.violet })
-- h('CmpItemKindMethod', { fg = p.violet })
-- h('CmpItemKindKeyword', { fg = p.violet })
-- h('CmpItemKindProperty', { fg = p.upper3 })
-- h('CmpItemKindUnit', { fg = p.upper3 })
-- --  {
-- --   PmenuSel = { bg = "#282C34", fg = "NONE" },
-- --   Pmenu = { fg = "#C5CDD9", bg = "#22252A" },

-- --   CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", fmt = "strikethrough" },
-- --   CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
-- --   CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
-- --   CmpItemMenu = { fg = "#C792EA", bg = "NONE", fmt = "italic" },

-- --   CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
-- --   CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
-- --   CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

-- --   CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
-- --   CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
-- --   CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

-- --   CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
-- --   CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
-- --   CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

-- --   CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
-- --   CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
-- --   CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
-- --   CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
-- --   CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

-- --   CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
-- --   CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

-- --   CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
-- --   CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
-- --   CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

-- --   CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
-- --   CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
-- --   CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

-- --   CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
-- --   CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
-- --   CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
-- -- }
-- -- vim.cmd([[
-- --   " gray
-- --   highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
-- --   " blue
-- --   highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
-- --   highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
-- --   " light blue
-- --   highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
-- --   highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
-- --   highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
-- --   " pink
-- --   highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
-- --   highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
-- --   " front
-- --   highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
-- --   highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
-- --   highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
-- -- ]])

local jet = {}

-- Color palette :so $VIMRUNTIME/syntax/hitest.vim
jet.jbp = {
  red0 = '#EBA0AC',
  red1 = '#EB6F92',
  red2 = '#E9436F',
  red3 = '#E95678',
  -- orange1 = '#FA9336', -- Give accent to things that need attention
  -- orange2 = "#ff9e64",
  lorange = '#FAB387',
  yellow = '#F6C177',
  -- yellow2 = '#e0af68',
  -- goaway  = '#AABCA8',
  green1 = '#93C88E',
  green = '#559A8B',
  -- teal    = "#1abc9c",
  -- blue0   = "#3d59a1",
  blue = '#87B0F9',
  blue2 = '#7aa2f7',
  -- blue    = '#4682B4',
  magenta = "#bb9af7",
  -- purple2 = "#9d7cd8",
  -- green2 = "#9ece6a",
  -- green3 = "#73daca",
  -- green4 = '#41a6b5',
  -- purple_high  = '#B877DB',
  purple = '#9D86B9', -- Used in info and diagnostics too
  upper3 = '#C6D0F5',
  upper2 = '#B6BEE3',
  upper1 = '#A5ABD2',
  grey = '#8689B9',
  dimmed1 = '#74749C',
  dimmed2 = '#63618B',
  dimmed3 = '#534F79', -- Used for comments, foldtext and identation/whitespaces spaces
  fg_dim = '#3D3A56',
  bg_high = '#26233a',
  bg_med = '#1f1d2e',
  bg_base = '#1A1724',
  bg_low = '#15121d',
}

jet.groups = {
  Normal = { bg = jet.jbp.bg_base, fg = jet.jbp.upper3 }, -- Background of the entire buffer.
  NormalFloat = { link = 'Normal' },
  InactiveWindow = { bg = jet.jbp.bg_low }, -- used by NormalNC, for winhighlight
  EndOfBuffer = { link = 'Normal' },
  CursorColumn = { bg = jet.jbp.bg_med },
  CursorLine = { link = 'CursorColumn' },
  CursorLineNr = { link = 'CursorColumn', fg = jet.jbp.dimmed2 }, -- Current position on gutter.
  CursorLineSign = { link = 'CursorLineNr' },
  CursorLineFold = { link = 'CursorLineNr' },
  LineNr = { bg = jet.jbp.bg_base, fg = jet.jbp.fg_dim }, -- Line number column, gutter.
  FoldColumn = { link = 'LineNr' },
  Folded = { fg = jet.jbp.dimmed3 }, -- When a fold is close you see this line.
  Visual = { reverse = true },
  VisualNOS = { link = 'Visual' }, -- When vim is not owning the visual selection.
  VertSplit = { bg = jet.jbp.bg_base, fg = jet.jbp.grey }, -- Used for splits, also used for completion menus
  WinSeperator = { bg = jet.jbp.fg_dim },
  ColorColumn = {},
  Conceal = {},
  Title = { fg = jet.jbp.upper1 }, -- Titles for output from ':set all', ':autocmd' etc.
  TSTitle = { link = 'Title' },
  Constant = { fg = jet.jbp.red0 }, -- NOTE: to self, this changes the name in -> TODO(santigo-zero):
  Todo = { fg = jet.jbp.purple, bold = true }, -- INUPPERCASE: FIXME / TODO(santigo-zero):
  TSNote = { fg = jet.jbp.blue2 }, -- NOTE: INUPPERCASE:
  Whitespace = { fg = jet.jbp.fg_dim }, -- Whitespaces, listchars, etc etc.
  IncSearch = { bg = jet.jbp.bg_high, fg = jet.jbp.blue }, -- Current search pattern when searching with /
  CurSearch = { bg = jet.jbp.bg_high, fg = jet.jbp.blue }, -- Current search match under the cursor
  Search = { bg = jet.jbp.bg_high, fg = jet.jbp.green1 }, -- Last search pattern
  Substitute = { bg = jet.jbp.bg_high, fg = jet.jbp.purple }, -- :substitute or :s///gc replacement text highlighting
  SignColumn = { bg = jet.jbp.bg_low }, -- Where linting and errors popup
  ErrorMsg = { link = 'Error' },
  WarningMsg = { fg = jet.jbp.yellow }, -- Warning messages
  ModeMsg = { fg = jet.jbp.upper1 }, -- The 'showmode' message (e.g., '-- INSERT --') uses this
  MsgArea = { link = 'ModeMsg' }, -- Area for messages and cmdline, / and :
  MsgSeparator = { link = 'ModeMsg' },
  MatchParen = { bg = jet.jbp.orange1 },

  -- StatusLine
  StatusLine = { bg = jet.jbp.bg_low, fg = jet.jbp.dimmed1 },
  StatusLineNC = { bg = jet.jbp.bg_low, fg = jet.jbp.dimmed1 },

  -- Syntax
  Comment = { fg = jet.jbp.dimmed3, italic = true },
  SpecialComment = { link = 'SpecialChar' },
  TSComment = { link = 'Comment' },
  Directory = { fg = jet.jbp.blue }, -- Directories in NetRW
  Error = { fg = jet.jbp.red1 },
  TSPunctBracket = { fg = jet.jbp.dimmed2 }, -- All ( and )
  Delimiter = { fg = jet.jbp.dimmed1 }, -- . and ,
  TSPunctDelimiter = { link = 'Delimiter' },
  Special = { fg = jet.jbp.dimmed2 }, -- All { and }
  SpecialChar = { fg = jet.jbp.violet },
  SpecialKey = { fg = jet.jbp.upper3 },
  TSPunctSpecial = { link = 'Special' },
  Include = { fg = jet.jbp.violet }, -- from ... import ...
  TSField = { fg = jet.jbp.green }, -- Elements of a table or api in vim.api and ui in vim.ui, or bold in bold = true
  TSVariable = { fg = jet.jbp.dimmed1 }, -- All variables, globals or locals
  Function = { fg = jet.jbp.purple }, -- Function keyword (also: methods for classes)
  TSFunction = { fg = jet.jbp.blue }, -- The name of the function, my_func(), not the keyword
  TSKeywordFunction = { link = 'Function' }, -- The function or def keyword
  TSKeyword = { link = 'Function' }, -- Other builtin keywords from the language in use.
  Conditional = { link = 'Function' }, -- if, then, else, endif, switch, etc.
  Repeat = { link = 'Function' }, -- for and while loops
  TSRepeat = { link = 'Repeat' },
  TSKeywordReturn = { fg = jet.jbp.purple }, -- This color gets overwritten if you are using treesitter concealment
  String = { fg = jet.jbp.upper1 },
  Number = { fg = jet.jbp.yellow },
  TSParameter = { fg = jet.jbp.red0 }, -- The parameters inside the parens of a function when defining it.
  Character = { fg = jet.jbp.upper2 }, -- A character constant: 'c', '\n'
  Boolean = { fg = jet.jbp.red0, italic = true }, -- true-false True-False If not setup it uses Constant fg colors
  TSVariableBuiltin = { fg = jet.jbp.green1 },
  Statement = { fg = jet.jbp.red1 }, -- The = and ==
  NonText = { link = 'CursorLineNr' }, -- Used in showbreak, listchars and virtualtext
  Question = { fg = jet.jbp.upper1 }, -- hit-enter prompts and yes/no questions
  Identifier = { fg = jet.jbp.magenta }, -- (preferred) any variable name

  Pmenu = { bg = jet.jbp.bg_base, fg = jet.jbp.upper1 }, -- The non-selected entries of a completion menu, normal item
  PmenuSel = { bg = jet.jbp.bg_high, fg = jet.jbp.upper1, blend = 0 }, -- Selected item.
  PmenuThumb = { bg = jet.jbp.grey }, -- Thumb of the scrollbar.

  -- Diagnostics
  DiagnosticError = { fg = jet.jbp.red1 },
  DiagnosticHint = { fg = jet.jbp.blue },
  DiagnosticInfo = { fg = jet.jbp.purple },
  DiagnosticWarn = { fg = jet.jbp.yellow },
  DiagnosticUnderlineError = { undercurl = true, sp = jet.jbp.red1 },
  DiagnosticUnderlineHint = { undercurl = true, sp = jet.jbp.blue },
  DiagnosticUnderlineInfo = { undercurl = true, sp = jet.jbp.purple },
  DiagnosticUnderlineWarn = { undercurl = true, sp = jet.jbp.yellow },
  GitSignsChange = { fg = jet.jbp.purple },
  GitSignsAdd = { fg = jet.jbp.blue },
  GitSignsDelete = { fg = jet.jbp.red1 },
  LspReferenceRead = { fg = jet.jbp.lorange, bg = jet.jbp.bg_high }, -- When you call a function or use a method/class
  LspReferenceText = { link = 'LspReferenceRead' },
  LspReferenceWrite = { link = 'LspReferenceRead' },
}

for key, value in pairs(jet.groups) do
  vim.api.nvim_set_hl(0, key, value)
end

return jet
