-- Settings
local tab_lenght = 3

local options = {
   autoindent = true, -- Copy indent from current line when starting a new line
   autoread = true, -- If a file has been changed, reload the file in neovim
   backspace = 'indent,start,eol', -- Make backspace behave like normal again
   clipboard = 'unnamedplus', -- Uses the system clipboard
   cmdheight = 1, -- Space for displaying messages in the command line
   colorcolumn = '81', -- Limiter line, + line more than textwidth
   conceallevel = 2, -- Show concealed text when the cursor is not on top
   confirm = true, -- Confirm dialogs
   cursorcolumn = true, -- Draw line on cursor
   cursorline = true, -- Draw line on cursor
   diffopt = 'foldcolumn:0,hiddenoff,vertical',
   tabstop = tab_lenght, -- Tab length
   shiftround = true, -- Round indent to multiple of "shiftwidth"
   shiftwidth = tab_lenght, -- Size of a > or < when indenting
   expandtab = true, -- Convert tabs to spaces
   smartcase = true, -- Smart case
   smartindent = true, -- Smart indentation
   smarttab = true, -- Smart indentation
   softtabstop = -1, -- Tab length, if negative shiftwidth value is used
   grepprg = 'rg --hidden --no-heading --vimgrep', -- Grep command
   hidden = true, -- It keeps buffers open in memory
   history = 100, -- Saved spaces in each table of history
   hlsearch = true, -- Highlighting search
   ignorecase = true, -- Ignore case
   inccommand = 'split', -- Shows just like nosplit, but partially off-screen
   incsearch = true, -- Incremental search
   joinspaces = true, -- Join commands like 'gq' insert two spaces on punctuation
   laststatus = 0, -- Mode of the status bar
   lazyredraw = true, -- Lazy redraw the screen
   matchtime = 1, -- Time for showing matching brace
   mouse = 'a', -- Mouse options, all enabled
   mousefocus = true, -- Focusing cursor on the window with the keyboard focus
   number = true, -- Display line number on the side
   pumblend = 9, -- Transparency for the pop up menu, disabled because it messess up Nerd Font icons
   winblend = 9,
   redrawtime = 300, -- Time for redrawing the display
   ruler = true, -- Ruler
   scrolloff = 999, -- Cursor does not reach top/bottom
   secure = true, -- Self-explanatory
   selection = 'inclusive', -- Don't include \n at the eol in v-mode
   showbreak = '↪ ', -- Shows when text is being wrapped
   showmatch = false, -- Show match brace, set to false because :DoMatchParen does enough
   showmode = false, -- Show or hide the mode you are on in the status line
   showtabline = 0, -- Show top tab bar
   sidescrolloff = 9, -- Cursor does not reach sides
   spelllang = 'en,cjk', -- Spell check: English - PascalCase and camelCase
   spelloptions = 'camel', -- Options for spell checking
   splitbelow = true, -- Force splits to go below current window
   splitright = true, -- Force vertical splits to go to the right of current window
   suffixesadd = '.', -- Used when searching for a file with 'gf'
   swapfile = false, -- It does (not) creates a swapfileWage
   textwidth = 120, -- Delimit text blocks to N columns
   timeoutlen = 300, -- Time given for doing a sequence
   title = true, -- Set the window title based on the value of titlestring
   undofile = true, -- Persistent undo - undo after you re-open the file
   undolevels = 600, -- Levels of undoing
   updatetime = 150, -- Faster completion
   virtualedit = 'all', -- Be able to put the cursor where there's not actual text
   whichwrap = '<,>,[,],h,l,b,s', -- Keys that can make you jump lines if you reach wrap
   wildcharm = 26, -- Trigger completion in macros
   wildignore = '*.o,*.rej,*.so', -- File patterns to ignore
   wildignorecase = true, -- Ignore case command completion menu
   wildmenu = true, -- Enables 'enhanced mode' of command-line completion
   wildmode = 'longest:full,full', -- Options for wildmenu
   winhighlight = 'NormalNC:WinNormalNC',
   wrap = false, -- Wrap text
}

for k, v in pairs(options) do
   vim.opt[k] = v
end

vim.opt.completeopt:append { 'menuone', 'noinsert', 'noselect' } -- Completion menu options
vim.opt.guicursor:append('v:hor50') -- Cursor settings for GUIs
vim.opt.iskeyword:remove('_') -- A word separated by _ is being separated in multiple ones
vim.opt.matchpairs:append { '<:>', '=:;' } -- Match pairs
vim.opt.shortmess:append('IFawsc') -- Less and shorter messages in command line
vim.opt.path:append('**') -- Search files recursively

-- Formatoptions
local buffer_opts = function()
   vim.opt.formatoptions:append('ct')
   vim.opt.formatoptions:remove('o')
   vim.cmd([[syntax match doublequotes '\"' conceal]])
   vim.cmd([[syntax match singlequotes '\'' conceal]])
end

vim.api.nvim_create_autocmd('BufEnter', {
   desc = 'Load some options in all buffers',
   group = '_session_opts',
   callback = buffer_opts,
})

buffer_opts()

-- Non visible characters
vim.opt.list = true
vim.opt.listchars:append {
   extends = '◣',
   nbsp = '␣',
   precedes = '◢',
   tab = '-->',
   trail = '█',
   -- eol = '↴',
}

-- To appropriately highlight codefences
vim.g.markdown_fenced_languages = {
   'js=javascript',
   'jsx=javascriptreact',
   'ts=typescript',
   'tsx=typescriptreact',
}
