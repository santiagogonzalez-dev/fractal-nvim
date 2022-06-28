local utils = require('csj.utils')

-- Cursor settings
vim.opt.guicursor:append('v:hor50')
vim.opt.guicursor:append('i-ci-ve:ver25')
vim.opt.guicursor:append('r-cr-o:hor20')

-- Settings
-- local tab_lenght = 4
local opts = {
   -- shiftwidth = tab_lenght, -- Size of a > or < when indenting
   -- tabstop = tab_lenght, -- Tab length
   breakindent = true, -- Every wrapped line will continue visually indented
   clipboard = 'unnamedplus', -- Clipboard mode
   cmdheight = 0,
   conceallevel = 2, -- Show concealed text when the cursor is not on top
   confirm = true, -- Confirm dialogs
   cursorcolumn = true,
   cursorline = true,
   diffopt = 'foldcolumn:0,hiddenoff,vertical',
   expandtab = true, -- Convert tabs to spaces
   grepprg = 'rg --hidden --no-heading --vimgrep', -- Grep command
   ignorecase = true, -- Ignore case
   inccommand = 'split', -- Shows just like nosplit, but partially off-screen
   joinspaces = true, -- Commands like gq or J insert two spaces on punctuation
   lazyredraw = true, -- Lazy redraw the screen
   matchpairs = '(:),{:},[:],<:>,=:;', -- Match pairs
   mouse = 'ar', -- Mouse options, all enabled
   mousefocus = true, -- Focusing cursor on the window with the keyboard focus
   -- pumblend = 9, -- Transparency for the pop up menu
   pumheight = 6, -- Amount of lines shown in completion menus
   scrolloff = 9, -- Cursor does not reach top/bottom
   secure = true, -- Self-explanatory
   shiftround = true, -- Round indent to multiple of "shiftwidth"
   shortmess = 'oOstIFS', -- Style for displaying messages
   showbreak = '↪ ', -- Shows when text is being wrapped
   showmode = false, -- Show or hide the mode you are on in the status line
   showtabline = 0, -- Show top tab bar
   sidescrolloff = 9, -- Cursor does not reach sides
   signcolumn = 'number', -- Column for lsp/linting errors and warnings
   smartcase = true, -- Smart case
   smartindent = true, -- Smart indentation
   softtabstop = -1, -- Tab length, if negative shiftwidth value is used
   spelllang = 'en,cjk', -- Spell check: English - PascalCase and camelCase
   spelloptions = 'camel', -- Options for spell checking
   spellsuggest = 'best', -- Spelling suggestions
   splitbelow = true, -- Force splits to go below current window
   splitright = true, -- Force vertical splits to go to the right of current window
   swapfile = false, -- It does (not) creates a swapfileWage synmaxcol = 160, -- Column
   synmaxcol = 160, -- Column limit for syntax highlight
   textwidth = 80, -- Delimit text blocks to N columns
   timeoutlen = 300, -- Time given for doing a sequence
   undofile = true, -- Persistent undo - undo after you re-open the file
   undolevels = 6000, -- Levels of undoing
   updatetime = 300, -- Faster completion, it's the time for CursorHold event
   whichwrap = '<,>,[,],h,l,b,s,~', -- Jump to the next line if you reach eol
   -- winblend = 9, -- Transparency for windows
   winhighlight = 'Normal:ActiveWindow,NormalNC:InactiveWindow', -- Window local highlights
   wrap = false, -- Wrap lines
}

for k, v in pairs(opts) do
   vim.opt[k] = v
end

vim.opt.path:append('**') -- Search files recursively

-- Ensure this settings persist in all buffers
function _G.all_buffers_settings()
   vim.opt.iskeyword = '@,48-57,192-255'

   vim.opt.formatoptions = vim.opt.formatoptions
      + 'r' -- If the line is a comment insert another one below when hitting <CR>
      + 'c' -- Wrap comments at the char defined in textwidth
      + 'q' -- Allow formatting comments with gq
      + 'j' -- Remove comment leader when joining lines when possible
      - 'o' -- Don't continue comments after o/O

   -- There's a non-visible character at cchar= so watch
   vim.cmd([[syntax match hidechars '\'' conceal " cchar= ]])
   vim.cmd([[syntax match hidechars '\"' conceal " cchar= ]])
   vim.cmd([[syntax match hidechars '\[\[' conceal " cchar= ]])
   vim.cmd([[syntax match hidechars '\]\]' conceal " cchar= ]])
   -- vim.cmd([[syntax match hidechars '{}' conceal cchar=]])
end

vim.api.nvim_create_autocmd('BufEnter', {
   group = 'session_opts',
   callback = _G.all_buffers_settings,
})
_G.all_buffers_settings()

-- Settings for non-visible characters
vim.opt.list = true

vim.opt.fillchars:append {
   eob = ' ', -- Don't show the ~ at the eof
   msgsep = '🮑', -- Line that separates the cmdline from the buffer, doesn't work with cmdheight=0
}

utils.append_by_random(vim.opt.fillchars, {
   {
      horiz = '━',
      horizup = '┻',
      horizdown = '┳',
      vert = '┃',
      vertleft = '┫',
      vertright = '┣',
      verthoriz = '╋',
   },
   {
      horiz = '─',
      horizup = '┴',
      horizdown = '┬',
      vert = '│',
      vertleft = '┤',
      vertright = '├',
      verthoriz = '┼',
   },
   {
      horiz = ' ',
      horizup = ' ',
      horizdown = ' ',
      vert = ' ',
      vertleft = ' ',
      vertright = ' ',
      verthoriz = ' ',
   },
})

vim.opt.listchars:append {
   -- eol = '↴',
   -- eol = '⏎',
   -- eol = '',
   extends = '◣',
   nbsp = '␣',
   precedes = '◢',
   tab = '-->',
   trail = '█',
   -- space = '·',
}

-- To appropriately highlight codefences
vim.g.markdown_fenced_languages = {
   'js=javascript',
   'jsx=javascriptreact',
   'ts=typescript',
   'tsx=typescriptreact',
}

vim.api.nvim_create_autocmd('BufWritePre', {
   desc = 'Trim whitespace on save',
   group = 'session_opts',
   callback = function()
      if not vim.o.binary and vim.o.filetype ~= 'diff' then
         local current_view = vim.fn.winsaveview()
         vim.cmd([[keeppatterns %s/\s\+$//e]])
         return vim.fn.winrestview(current_view)
      end
   end,
})

vim.api.nvim_create_autocmd('VimResized', {
   desc = 'Autoresize, ensures splits are equal width when resizing vim',
   group = 'session_opts',
   command = 'tabdo wincmd =',
})

vim.api.nvim_create_autocmd('TextYankPost', {
   desc = 'Highlight on yank',
   group = 'session_opts',
   callback = function()
      pcall(vim.highlight.on_yank, { higroup = 'Visual', timeout = 600 })
   end,
})

vim.api.nvim_create_autocmd('CursorMoved', {
   desc = 'Enable crosshair when we are moving the cursor',
   group = 'session_opts',
   callback = function()
      vim.opt.cursorcolumn = true
      vim.opt.cursorline = true
      vim.g.cursor_show = true
   end,
})

vim.api.nvim_create_autocmd('CursorHold', {
   desc = 'Disable crosshair when we are not moving the cursor',
   group = 'session_opts',
   callback = function()
      vim.g.cursor_show = false
      vim.defer_fn(function()
         if vim.g.cursor_show == false then
            vim.opt.cursorcolumn = false
            vim.opt.cursorline = false
         end
      end, 3000)
   end,
})
