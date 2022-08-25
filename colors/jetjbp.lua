-- TODO(santigo-zero): colors for diff (-d flag)
vim.cmd.highlight { args = { 'clear' } }

if 1 == vim.fn.exists('syntax_on') then
  vim.cmd.syntax('reset')
end

vim.opt.termguicolors = true
vim.g.colors_name = 'jetjbp'

vim.fn.matchadd('ErrorMsg', '\\s\\+$') -- Extra whitespaces will be highlighted

local jet = {}

---@deprecated
-- orange1 = '#FA9336', -- Give accent to things that need attention
-- yellow2 = '#e0af68',
-- goaway  = '#AABCA8',
-- teal    = "#1abc9c",
-- blue0   = "#3d59a1",
-- blue    = '#4682B4',
-- purple2 = "#9d7cd8",
-- green2 = "#9ece6a",
-- green3 = "#73daca",
-- green4 = '#41a6b5',
-- purple_high  = '#B877DB',

--stylua: ignore start
-- Color palette :so $VIMRUNTIME/syntax/hitest.vim
jet.jbp = {
  red0              = '#EBA0AC', -- constants, function paramaters and booleans
  red1              = '#EB6F92', -- errors, statements like = and ==, and linting from lsp and gitsigns
  red2              = '#E9436F',
  red3              = '#E95678',
  orange1           = '#FF9E64', -- matching paren
  lorange           = '#FAB387', -- highlight current word with lsp
  yellow            = '#F6C177', -- numbers, warnings and other linting
  green1            = '#93C88E', -- searches and variables from the language like `this` and `self`
  green             = '#559A8B', -- table elements in lua, or labels in json, or `api` in vim.api or `bold` in bold = true
  blue              = '#87B0F9', -- cursor search, and inc search, direcories, linting, name of the function, not the function
  magenta           = '#BB9AF7',
  purple            = '#9D86B9', -- Used in info and diagnostics too
  upper3            = '#C6D0F5',
  upper2            = '#B6BEE3',
  upper1            = '#A5ABD2',
  grey              = '#8689B9',
  dimmed1           = '#74749C',
  dimmed2           = '#63618B',
  dimmed3           = '#534F79', -- Used for comments, foldtext and identation/whitespaces spaces
  fg_dim            = '#3D3A56',
  bg_high           = '#26233A',
  bg_med            = '#1F1D2E',
  bg_base           = '#1A1724',
  bg_low            = '#15121D',
}

jet.groups = {
  Normal            = { bg = jet.jbp.bg_base, fg = jet.jbp.upper3 }, -- Background of the entire buffer.
  NormalFloat       = { link = 'Normal' },
  InactiveWindow    = { bg = jet.jbp.bg_low }, -- used by NormalNC, for winhighlight
  EndOfBuffer       = { link = 'Normal' },
  CursorColumn      = { bg = jet.jbp.bg_med },
  CursorLine        = { link = 'CursorColumn' },
  CursorLineNr      = { link = 'CursorColumn', fg = jet.jbp.dimmed2 }, -- Current position on gutter.
  CursorLineSign    = { link = 'CursorLineNr' },
  CursorLineFold    = { link = 'CursorLineNr' },
  LineNr            = { bg = jet.jbp.bg_base, fg = jet.jbp.fg_dim }, -- Line number column, gutter.
  FoldColumn        = { link = 'LineNr' },
  Folded            = { fg = jet.jbp.dimmed3 }, -- When a fold is close you see this line.
  Visual            = { bg = jet.jbp.bg_high },
  VisualNOS         = { link = 'Visual' }, -- When vim is not owning the visual selection.
  VertSplit         = { bg = jet.jbp.bg_base, fg = jet.jbp.grey }, -- Used for splits, also used for completion menus
  -- WinSeperator      = { bg = 'red' },
  -- ColorColumn       = { bg = jet.jbp.dimmed3, fg = jet.jbp.bg_med },
  ColorColumn       = {},
  Conceal           = {},
  Title             = { fg = jet.jbp.upper1 }, -- Titles for output from ':set all', ':autocmd' etc.
  TSTitle           = { link = 'Title' },
  Constant          = { fg = jet.jbp.red0 }, -- NOTE: to self, this changes the name in -> TODO(santigo-zero):
  Todo              = { fg = jet.jbp.purple, bold = true }, -- INUPPERCASE: FIXME / TODO(santigo-zero):
  TSNote            = { fg = jet.jbp.blue }, -- NOTE: INUPPERCASE:
  Whitespace        = { fg = jet.jbp.fg_dim }, -- Whitespaces, listchars, etc etc.
  IncSearch         = { bg = jet.jbp.bg_high, fg = jet.jbp.blue }, -- Current search pattern when searching with /
  CurSearch         = { bg = jet.jbp.bg_high, fg = jet.jbp.blue }, -- Current search match under the cursor
  Search            = { bg = jet.jbp.bg_high, fg = jet.jbp.green1 }, -- Last search pattern
  Substitute        = { bg = jet.jbp.bg_high, fg = jet.jbp.purple }, -- :substitute or :s///gc replacement text highlighting
  SignColumn        = { bg = jet.jbp.bg_low }, -- Where linting and errors popup
  ErrorMsg          = { link = 'Error' }, -- Error messages in the cmdline
  WarningMsg        = { fg = jet.jbp.yellow }, -- Warning messages
  ModeMsg           = { fg = jet.jbp.upper1 }, -- The 'showmode' message (e.g., '-- INSERT --') uses this
  MsgArea           = { link = 'ModeMsg' }, -- Area for messages and cmdline, / and :
  MsgSeparator      = { link = 'ModeMsg' },
  MatchParen        = { bg = jet.jbp.orange1 },
  TSType            = { fg = jet.jbp.green1 },
  TSTypeBuiltin     = { fg = jet.jbp.green1 },

  -- StatusLine and Winbar
  StatusLine        = { bg = jet.jbp.bg_low, fg = jet.jbp.dimmed1 },
  -- WinBar            = { bg = jet.jbp.bg_low, fg = jet.jbp.dimmed1 },

  StatusLineBlue    = { bg = jet.jbp.bg_low, fg = jet.jbp.blue },
  -- WinBarBlue        = { bg = jet.jbp.bg_low, fg = jet.jbp.blue },

  StatusLineNC      = { link = 'InactiveWindow' },
  -- WinBarNC          = {},

  -- Syntax
  Comment           = { fg = jet.jbp.dimmed3, italic = true },
  SpecialComment    = { link = 'SpecialChar' },
  TSComment         = { link = 'Comment' },
  Directory         = { fg = jet.jbp.blue }, -- Directories in NetRW
  Error             = { fg = jet.jbp.red1 },
  TSPunctBracket    = { fg = jet.jbp.dimmed2 }, -- All ( and )
  Delimiter         = { fg = jet.jbp.dimmed1 }, -- . and ,
  TSPunctDelimiter  = { link = 'Delimiter' },
  Special           = { fg = jet.jbp.dimmed2 }, -- All { and }
  SpecialChar       = { fg = jet.jbp.violet },
  SpecialKey        = { fg = jet.jbp.upper3 },
  TSPunctSpecial    = { link = 'Special' },
  Include           = { fg = jet.jbp.violet }, -- from ... import ...
  TSField           = { fg = jet.jbp.green }, -- Elements of a table or api in vim.api and ui in vim.ui, or bold in bold = true
  Label             = { fg = jet.jbp.green }, -- Used a lot in json files
  TSLabel           = { link = 'Label' },
  TSVariable        = { fg = jet.jbp.dimmed1 }, -- All variables, globals or locals
  Function          = { fg = jet.jbp.purple }, -- Function keyword (also: methods for classes)
  TSFunction        = { fg = jet.jbp.blue }, -- The name of the function, my_func(), not the keyword
  TSKeywordFunction = { link = 'Function' }, -- The function or def keyword
  TSKeyword         = { link = 'Function' }, -- Other builtin keywords from the language in use.
  Conditional       = { link = 'Function' }, -- if, then, else, endif, switch, etc.
  Repeat            = { link = 'Function' }, -- for and while loops
  TSRepeat          = { link = 'Repeat' },
  TSKeywordReturn   = { fg = jet.jbp.purple }, -- This color gets overwritten if you are using treesitter concealment
  String            = { fg = jet.jbp.upper1 },
  Number            = { fg = jet.jbp.yellow },
  TSParameter       = { fg = jet.jbp.red0 }, -- The parameters inside the parens of a function when defining it.
  Character         = { fg = jet.jbp.upper2 }, -- A character constant: 'c', '\n'
  Boolean           = { fg = jet.jbp.red0, italic = true }, -- true-false True-False If not setup it uses Constant fg colors
  TSVariableBuiltin = { fg = jet.jbp.green1 },
  Statement         = { fg = jet.jbp.red1 }, -- The = and ==
  NonText           = { link = 'CursorLineNr' }, -- Used in showbreak, listchars and virtualtext
  Question          = { fg = jet.jbp.upper1 }, -- hit-enter prompts and yes/no questions
  Identifier        = { fg = jet.jbp.magenta }, -- (preferred) any variable name
  TSFuncBuiltin     = { fg = jet.jbp.purple }, -- Like `require`

  -- Completion menu
  Pmenu             = { bg = jet.jbp.bg_base, fg = jet.jbp.upper1 }, -- The non-selected entries of a completion menu, normal item
  PmenuSel          = { bg = jet.jbp.bg_high, fg = jet.jbp.upper1, blend = 0 }, -- Selected item.
  PmenuThumb        = { bg = jet.jbp.grey }, -- Thumb of the scrollbar.

  -- Diagnostics
  DiagnosticError   = { fg = jet.jbp.red1 },
  DiagnosticHint    = { fg = jet.jbp.blue },
  DiagnosticInfo    = { fg = jet.jbp.purple },
  DiagnosticWarn    = { fg = jet.jbp.yellow },
  DiagnosticUnderlineError = { undercurl = true, sp = jet.jbp.red1 },
  DiagnosticUnderlineHint = { undercurl = true, sp = jet.jbp.blue },
  DiagnosticUnderlineInfo = { undercurl = true, sp = jet.jbp.purple },
  DiagnosticUnderlineWarn = { undercurl = true, sp = jet.jbp.yellow },
  GitSignsChange    = { fg = jet.jbp.purple },
  GitSignsAdd       = { fg = jet.jbp.blue },
  GitSignsDelete    = { fg = jet.jbp.red1 },
  LspReferenceRead  = { fg = jet.jbp.lorange, bg = jet.jbp.bg_high }, -- When you call a function or use a method/class
  LspReferenceText  = { link = 'LspReferenceRead' },
  LspReferenceWrite = { link = 'LspReferenceRead' },
}
--stylua: ignore end

for key, value in pairs(jet.groups) do
  vim.api.nvim_set_hl(0, key, value)
end

return jet
