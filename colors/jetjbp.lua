-- TODO(santigo-zero): colors for diff (-d flag)
vim.cmd.highlight { args = { 'clear' } }

if vim.fn.exists 'syntax_on' == 1 then
   vim.cmd.syntax 'reset'
end

vim.opt.termguicolors = true
vim.g.colors_name = 'jetjbp'

require('csj.jetjbp').setup()

-- local jet = {}

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

-- -- Color palette :so $VIMRUNTIME/syntax/hitest.vim
-- jet.jbp = {
--    red0 = '#EBA0AC', -- constants, function paramaters and booleans
--    red1 = '#EB6F92', -- errors, statements like = and ==, and linting from lsp and gitsigns
--    red2 = '#E9436F',
--    red3 = '#E95678',
--    orange1 = '#FF9E64', -- matching paren
--    lorange = '#FAB387', -- highlight current word with lsp
--    yellow = '#F6C177', -- numbers, warnings and other linting
--    green1 = '#93C88E', -- searches and variables from the language like `this` and `self`
--    green = '#559A8B', -- table elements in lua, or labels in json, or `api` in vim.api or `bold` in bold = true
--    blue = '#87B0F9', -- cursor search, and inc search, direcories, linting, name of the function, not the function
--    magenta = '#BB9AF7',
--    purple = '#9D86B9', -- Used in info and diagnostics too
--    upper3 = '#C6D0F5',
--    upper2 = '#B6BEE3',
--    upper1 = '#A5ABD2',
--    grey = '#8689B9',
--    dimmed1 = '#74749C',
--    dimmed2 = '#63618B',
--    dimmed3 = '#534F79', -- Used for comments, foldtext and identation/whitespaces spaces
--    fg_dim = '#3D3A56',
--    bg_high = '#26233A',
--    bg_med = '#1F1D2E',
--    bg_base = '#1A1724',
--    bg_low = '#15121D',
-- }

-- jet.groups = {
--    -- VertSplit = { bg = jet.jbp.bg_base, fg = jet.jbp.grey }, -- Used for splits, also used for completion menus
--    -- -- WinSeperator      = { bg = 'red' },
--    -- -- ColorColumn       = { bg = jet.jbp.dimmed3, fg = jet.jbp.bg_med },

--    -- SpecialComment = { link = 'SpecialChar' },
--    -- SpecialChar = { fg = jet.jbp.violet },
--    -- SpecialKey = { fg = jet.jbp.upper3 },
--    -- TSPunctSpecial = { link = 'Special' },
--    -- Include = { fg = jet.jbp.violet }, -- from ... import ...
--    -- TSField = { fg = jet.jbp.green }, -- Elements of a table or api in vim.api and ui in vim.ui, or bold in bold = true
--    -- Label = { fg = jet.jbp.green }, -- Used a lot in json files
--    -- TSLabel = { link = 'Label' },
--    -- TSVariable = { fg = jet.jbp.dimmed1 }, -- All variables, globals or locals
--    -- Function = { fg = jet.jbp.purple }, -- Function keyword (also: methods for classes)
--    -- TSFunction = { fg = jet.jbp.blue }, -- The name of the function, my_func(), not the keyword
--    -- TSKeywordFunction = { link = 'Function' }, -- The function or def keyword
--    -- TSKeyword = { link = 'Function' }, -- Other builtin keywords from the language in use.
--    -- Conditional = { link = 'Function' }, -- if, then, else, endif, switch, etc.
--    -- Repeat = { link = 'Function' }, -- for and while loops
--    -- TSRepeat = { link = 'Repeat' },
--    -- TSKeywordReturn = { fg = jet.jbp.purple }, -- This color gets overwritten if you are using treesitter concealment
--    -- String = { fg = jet.jbp.upper1 },
--    -- Number = { fg = jet.jbp.yellow },
--    -- TSParameter = { fg = jet.jbp.red0 }, -- The parameters inside the parens of a function when defining it.
--    -- Character = { fg = jet.jbp.upper2 }, -- A character constant: 'c', '\n'
--    -- Boolean = { fg = jet.jbp.red0, italic = true }, -- true-false True-False If not setup it uses Constant fg colors
--    -- TSVariableBuiltin = { fg = jet.jbp.green1 },
--    -- Statement = { fg = jet.jbp.red1 }, -- The = and ==
--    -- NonText = { fg = jet.jbp.upper2 }, -- Used in showbreak, listchars and virtualtext
--    -- Question = { fg = jet.jbp.upper1 }, -- hit-enter prompts and yes/no questions
