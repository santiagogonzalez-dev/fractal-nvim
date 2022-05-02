-- -- Palette
-- local p = {
--     background = '#191724',
--     background_inactive = '#15131d',

--     foreground = '#908CAA',

--     dimmed = '#3D3B51',
--     dimmed_less = '#575279',

--     overlay = '#26233A',
--     overlay_accent = '#FF9F65',

--     -- red
--     danger = '#EB6F92',
--     danger_less = '#f68fb9',

--     -- tangerines
--     tangerine = '#F28500',
--     tangerine_less = '#F9A255',
--     -- banana = '#FFCF61',
--     -- not_so_old_paper = '#EFBF9C',
--     old_paper = '#ea9d34',

--     -- pinky
--     pinky = '#BB9AF7',

--     -- tinky winky
--     tinky_winky = '#816acb',
--     tinky_winky_tonned_down = '#A093C7', -- tonned down

--     -- green
--     green = '#B1E3AD',
--     green_blue = '#3e8fb0',

--     green_ocean = '#007F74',

--     green_green = '#73DACA',

--     -- blue
--     grumpy_care_bear = '#A4B9EF',
--     blue = '#7AA2F7',
-- -- }

-- -- Highlight groups
-- local groups = {
--     Normal = { bg = p.background, fg = p.foreground },
--     ColorColumn = {}, -- Empty for now, I'm usign virt-column.nvim
--     Cursor = { fg = p.background, bg = p.foreground }, -- Character under the cursor, invert the colors
--     Comment = { fg = p.dimmed_less, italic = true },

--     -- TODO Am I even going to use this?
--     -- Conceal = { fg = 'blue', bg = 'red' },

--     -- lCursor = { fg = c.bg, bg = c.fg }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
--     -- CursorIM = { fg = c.bg, bg = c.fg }, -- like Cursor, but used when in IME mode |CursorIM|
--     -- Directory = { fg = c.blue }, -- directory names (and other special names in listings)
--     -- DiffAdd = { bg = c.diff.add }, -- diff mode: Added line |diff.txt|
--     -- DiffChange = { bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
--     -- DiffDelete = { bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
--     -- DiffText = { bg = c.diff.text }, -- diff mode: Changed text within a changed line |diff.txt|
--     -- EndOfBuffer = { fg = c.bg }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
--     -- TermCursor  = { }, -- cursor in a focused terminal
--     -- TermCursorNC= { }, -- cursor in an unfocused terminal

--     LineNr = { bg = p.background, fg = p.dimmed }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
--     CursorColumn = { bg = p.overlay }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
--     CursorLine = { bg = p.overlay }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
--     CursorLineNr = { bg = p.overlay, fg = p.tangerine_less }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.

--     -- TODO(santigo-zero): which of the two are we going to use, I think reversing is better since we are using 'p00f/nvim-ts-rainbow' to highlight matching
--     -- parents, and treesitter by default highlights them on two colors
--     -- MatchParen = { fg = palette.overlay, bg = palette.overlay_accent, bold = true },
--     -- MatchParen = { reverse = true, bold = true },
--     MatchParen = { fg = p.dimmed_less },

--     ErrorMsg = { fg = p.danger, bold = true }, -- Error messages on the command line
--     Error = { fg = p.danger, bold = true }, -- Error messages on the command line

--     Todo = { fg = p.grumpy_care_bear },
--     VertSplit = { bg = p.background, fg = p.dimmed },
--     Folded = { bg = p.background, fg = p.dimmed_less },
--     FoldColumn = { bg = p.background, fg = p.dimmed },
--     SignColumn = {}, -- Where signs are displayed
--     SignColumnSB = {}, -- Where signs are displayed
--     Search = { bg = p.overlay_accent, fg = p.overlay }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
--     IncSearch = { bg = p.background, fg = p.grumpy_care_bear }, -- Used for the word under cursor when searching for anything, also used on :s///gc
--     Substitute = { link = 'Search' }, -- Replacement text highlighting
--     ModeMsg = { fg = p.dimmed },
--     MsgArea = { fg = p.foreground }, -- : and /
--     MsgSeparator = { fg = p.dimmed },
--     MoreMsg = { fg = p.dimmed },
--     NonText = { fg = p.dimmed }, -- Characters that are not part of the code, like virtualtext and listchar icons
--     -- NormalSB = { fg = c.fg_sidebar, bg = c.bg_sidebar }, -- normal text in non-current windows
--     -- NormalFloat = { fg = c.fg, bg = c.bg_float }, -- Normal text in floating windows.
--     -- FloatBorder = { fg = c.border_highlight, bg = c.bg_float },
--     -- Pmenu = { bg = c.bg_popup, fg = c.fg }, -- Popup menu: normal item.
--     -- PmenuSel = { bg = util.darken(c.fg_gutter, 0.8) }, -- Popup menu: selected item.
--     -- PmenuSbar = { bg = util.lighten(c.bg_popup, 0.95) }, -- Popup menu: scrollbar.
--     -- PmenuThumb = { bg = c.fg_gutter }, -- Popup menu: Thumb of the scrollbar.
--     -- Question = { fg = c.blue }, -- |hit-enter| prompt and yes/no questions
--     -- QuickFixLine = { bg = c.bg_visual, style = 'bold' }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
--     -- SpecialKey = { fg = c.dark3 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
--     -- SpellBad = { sp = c.error, style = 'undercurl' }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
--     -- SpellCap = { sp = c.warning, style = 'undercurl' }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
--     -- SpellLocal = { sp = c.info, style = 'undercurl' }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
--     -- SpellRare = { sp = c.hint, style = 'undercurl' }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.

--     -- TODO(santigo-zero): check this highlight group for inactive windows
--     -- NormalNC = { fg = c.fg, bg = config.transparent and c.none or c.bg }, -- normal text in non-current windows
--     -- StatusLineNC = { bg = palette.background_inactive },
--     -- StatusLineNC = { fg = c.fg_gutter, bg = c.bg_statusline }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
--     StatusLine = { bg = p.background, fg = p.foreground },
--     InactiveWindow = { bg = p.background_inactive },

--     -- TabLine = { bg = c.bg_statusline, fg = c.fg_gutter }, -- tab pages line, not active tab page label
--     -- TabLineFill = { bg = c.black }, -- tab pages line, where there are no labels
--     -- TabLineSel = { fg = c.black, bg = c.blue }, -- tab pages line, active tab page label

--     -- Title = { fg = c.blue, style = 'bold' }, -- titles for output from ":set all", ":autocmd" etc.
--     Visual = { reverse = true },
--     -- VisualNOS = { bg = c.bg_visual }, -- Visual mode selection when vim is "Not Owning the Selection".
--     -- WarningMsg = { fg = c.warning }, -- warning messages
--     -- Whitespace = { fg = c.fg_gutter }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
--     -- WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion

--     -- These groups are not listed as default vim groups,
--     -- but they are defacto standard group names for syntax highlighting.
--     -- commented out groups should chain up to their "preferred" group by
--     -- default,
--     -- Uncomment and edit if you want more specific syntax highlighting.

--     -- Constant = { fg = c.orange }, -- (preferred) any constant
--     -- String = { fg = c.green }, --   a string constant: "this is a string"
--     -- Character = { fg = c.green }, --  a character constant: 'c', '\n'
--     -- Number        = { }, --   a number constant: 234, 0xff

--     Number = { fg = p.old_paper },
--     -- Boolean       = { }, --  a boolean constant: TRUE, false

--     TSBoolean = { fg = p.green_ocean },
--     Boolean = { fg = p.green_ocean },
--     -- Float         = { }, --    a floating point constant: 2.3e10

--     -- Identifier = { fg = c.magenta, style = config.variableStyle }, -- (preferred) any variable name
--     -- Function = { fg = c.blue, style = config.functionStyle }, -- function name (also: methods for classes)

--     -- Statement = { fg = c.magenta }, -- (preferred) any statement
--     Statement = { fg = p.blue },
--     -- Repeat        = { }, --   for, do, while, etc.
--     -- Label         = { }, --    case, default, etc.
--     -- Operator = { fg = c.blue5 }, -- "sizeof", "+", "*", etc.
--     -- Keyword = { fg = c.cyan, style = config.keywordStyle }, --  any other keyword
--     -- Exception     = { }, --  try, catch, throw

--     -- PreProc = { fg = c.cyan }, -- (preferred) generic Preprocessor
--     -- Include       = { }, --  preprocessor #include
--     -- Define        = { }, --   preprocessor #define
--     -- Macro         = { }, --    same as Define
--     -- PreCondit     = { }, --  preprocessor #if, #else, #endif, etc.

--     -- Type = { fg = c.blue1 }, -- (preferred) int, long, char, etc.
--     -- StorageClass  = { }, -- static, register, volatile, etc.
--     -- Structure     = { }, --  struct, union, enum, etc.
--     -- Typedef       = { }, --  A typedef

--     -- Special = { fg = c.blue1 }, -- (preferred) any special symbol
--     -- SpecialChar   = { }, --  special character in a constant
--     -- Tag           = { }, --    you can use CTRL-] on this
--     -- Delimiter     = { }, --  character that needs attention
--     -- SpecialComment= { }, -- special things inside a comment
--     -- Debug         = { }, --    debugging statements

--     -- Underlined = { style = 'underline' }, -- (preferred) text that stands out, HTML links
--     -- Bold = { style = 'bold' },
--     -- Italic = { style = 'italic' },

--     -- ("Ignore", below, may be invisible...)
--     -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|

--     -- qfLineNr = { fg = c.dark5 },
--     -- qfFileName = { fg = c.blue },

--     -- These groups are for the native LSP client. Some other LSP clients may
--     -- use these groups, or use their own. Consult your LSP client's
--     -- documentation.
--     -- LspReferenceText = { bg = c.fg_gutter }, -- used for highlighting "text" references
--     -- LspReferenceRead = { bg = c.fg_gutter }, -- used for highlighting "read" references
--     -- LspReferenceWrite = { bg = c.fg_gutter }, -- used for highlighting "write" references

--     -- DiagnosticError = { fg = c.error }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
--     -- DiagnosticWarn = { fg = c.warning }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
--     -- DiagnosticInfo = { fg = c.info }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default
--     -- DiagnosticHint = { fg = c.hint }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default

--     -- DiagnosticVirtualTextError = { bg = util.darken(c.error, 0.1), fg = c.error }, -- Used for "Error" diagnostic virtual text
--     -- DiagnosticVirtualTextWarn = { bg = util.darken(c.warning, 0.1), fg = c.warning }, -- Used for "Warning" diagnostic virtual text
--     -- DiagnosticVirtualTextInfo = { bg = util.darken(c.info, 0.1), fg = c.info }, -- Used for "Information" diagnostic virtual text
--     -- DiagnosticVirtualTextHint = { bg = util.darken(c.hint, 0.1), fg = c.hint }, -- Used for "Hint" diagnostic virtual text

--     -- DiagnosticUnderlineError = { style = 'undercurl', sp = c.error }, -- Used to underline "Error" diagnostics
--     -- DiagnosticUnderlineWarn = { style = 'undercurl', sp = c.warning }, -- Used to underline "Warning" diagnostics
--     -- DiagnosticUnderlineInfo = { style = 'undercurl', sp = c.info }, -- Used to underline "Information" diagnostics
--     -- DiagnosticUnderlineHint = { style = 'undercurl', sp = c.hint }, -- Used to underline "Hint" diagnostics

--     -- LspSignatureActiveParameter = { fg = c.orange },
--     -- LspCodeLens = { fg = c.comment },
--     -- TSVariableBuiltin
--     -- Include
--     TSVariableBuiltin = { fg = p.pinky },

--     -- TSVariable
--     TSVariable = { fg = p.foreground },

--     -- TSURI
--     -- TSTitle
--     -- TSText
--     -- TSTagDelimiter
--     -- TSTag
--     -- TSProperty

--     -- TSStringEscape
--     -- String

--     -- TSPunctSpecial
--     -- TSPunctDelimiter
--     TSPunctSpecial = { fg = p.foreground },
--     TSPunctDelimiter = { fg = p.foreground },

--     -- TSPunctBracket
--     TSPunctBracket = { fg = p.dimmed_less },
--     TSConstructor = { fg = p.dimmed_less },

--     -- TSConstBuiltin
--     -- TSConstant
--     -- TSConstructor

--     -- Function
--     -- TSFuncBuiltin
--     TSFuncBuiltin = { fg = p.grumpy_care_bear }, -- The keyword: function, def

--     -- TSFuncMacro

--     -- Conditional   = { }, --  if, then, else, endif, switch, etc.
--     TSConditional = { fg = p.grumpy_care_bear },
--     TSRepeat = { fg = p.grumpy_care_bear },

--     -- TSField
--     -- TSInclude
--     -- TSLabel
--     -- TSOperator
--     -- TSParameter
--     TSField = { fg = p.grumpy_care_bear }, -- For the table table.item item is TSField

--     -- TSKeywordOperator
--     TSKeywordOperator = { fg = p.green_green, italic = true },

--     -- TSKeywordFunction
--     TSFunction = { fg = p.pinky }, -- The keyword: function, def
--     -- TSFunction
--     TSKeywordFunction = { fg = p.grumpy_care_bear },

--     -- TSKeyword
--     TSKeyword = { fg = p.green_blue }, -- Words like local
--     -- TSKeyword = { fg = p.green_ocean }, -- Words like local

--     -- TSNone
--     -- TSStrong
--     -- TSEmphasis
--     -- TSUnderline
--     -- TSStrike
-- }

-- for group, opts in pairs(groups) do
--     vim.api.nvim_set_hl(0, group, opts)
-- end

