-- Settings
local tab_lenght = 3

local options = {
   autoindent = true, -- Copy indent from current line when starting a new line
   autoread = true, -- If a file has been changed, reload the file in neovim
   backspace = 'indent,start,eol', -- Make backspace behave like normal again
   breakindent = true, -- Every wrapped line will continue visually indented (same amount of
   clipboard = 'unnamedplus', -- Uses the system clipboard
   cmdheight = 1, -- Space for displaying messages in the command line
   colorcolumn = '81', -- Limiter line, + line more than textwidth
   conceallevel = 2, -- Show concealed text when the cursor is not on top
   confirm = true, -- Confirm dialogs
   cursorcolumn = true, -- Draw line on cursor
   cursorline = true, -- Draw line on cursor
   diffopt = 'internal,filler,closeoff,foldcolumn:0,hiddenoff',
   expandtab = true, -- Convert tabs to spaces
   exrc = false, -- Use local .nvimrc or .exrc
   grepprg = 'rg --hidden --no-heading --vimgrep', -- Grep command
   hidden = true, -- It keeps buffers open in memory
   history = 100, -- Saved spaces in each table of history
   hlsearch = true, -- Highlighting search
   ignorecase = true, -- Ignore case
   inccommand = 'split', -- Shows just like nosplit, but partially off-screen
   incsearch = true, -- Incremental search
   joinspaces = false, -- No double spaces with join after a dot
   laststatus = 0, -- Mode of the status bar
   lazyredraw = true, -- Lazy redraw the screen
   matchtime = 1, -- Time for showing matching brace
   mouse = 'a', -- Mouse options, all enabled
   mousefocus = true, -- Focusing cursor on the window with the keyboard focus
   number = true, -- Display line number on the side
   path = '**', -- Search files recursively
   pumblend = 9, -- Transparency for the pop up menu, disabled because it messess up Nerd Font icons
   pumheight = 6, -- Pop up menu height
   redrawtime = 333, -- Time for redrawing the display
   relativenumber = true, -- Display line number relative to the cursor
   ruler = true, -- Show the line and column number of the cursor position
   scrolloff = 8, -- Cursor does not reach top/bottom
   secure = true, -- Self-explanatory
   shell = 'zsh', -- Shell to use for `!`, `:!`, `system()` etc.
   shiftround = true, -- Round indent to multiple of "shiftwidth"
   shiftwidth = tab_lenght, -- Size of a > or < when indenting
   showbreak = '↪', -- Shows when text is being wrapped
   showmatch = false, -- Show match brace, set to false because :DoMatchParen does enough
   showmode = false, -- Show or hide the mode you are on in the status line
   showtabline = 0, -- Show top tab bar
   sidescrolloff = 8, -- Cursor does not reach sides
   signcolumn = 'yes', -- Always show signcolumn
   smartcase = true, -- Smart case
   smartindent = true, -- Smart indentation
   smarttab = true, -- Smart indentation
   softtabstop = -1, -- Tab length, if negative shiftwidth value is used
   spelllang = 'en,cjk', -- Spell check: English - PascalCase and camelCase
   spelloptions = 'camel', -- Options for spell checking
   splitbelow = true, -- Force splits to go below current window
   splitright = true, -- Force vertical splits to go to the right of current window
   swapfile = false, -- It does (not) creates a swapfileWage
   tabstop = tab_lenght, -- Tab length
   termguicolors = true, -- Enable colors in the terminal
   textwidth = 120, -- Delimit text blocks to N columns
   timeoutlen = 333, -- Time given for doing a sequence
   title = true, -- Set the window title based on the value of titlestring
   undofile = true, -- Persistent undo - undo after you re-open the file
   undolevels = 10000, -- Levels of undoing
   updatetime = 234, -- Faster completion
   virtualedit = 'all', -- Be able to put the cursor where there's not actual text
   whichwrap = '<,>,[,],h,l,b,s', -- Keys that can make you jump lines if you reach wrap
   wildcharm = 26, -- Trigger completion in macros
   wildignore = '*.o,*.rej,*.so', -- File patterns to ignore
   wildignorecase = true, -- Ignore case command completion menu
   wildmenu = true, -- Enables 'enhanced mode' of command-line completion
   wildmode = 'longest:full,full', -- Options for wildmenu
   winblend = 9, -- Enable transparency in floating windows and menus
   winhighlight = 'NormalNC:WinNormalNC',
   wrap = false, -- Wrap text
}

for k, v in pairs(options) do
   vim.o[k] = v
end

-- Other settings
vim.opt.cpoptions:append('nm') -- See :help cpoptions, this are the defaults aABceFs_
vim.opt.shortmess:append('IFawsc') -- Less and shorter messages in command line
vim.opt.iskeyword:remove('_') -- A word separated by _ is being separated in multiple ones

-- Formatoptions
vim.opt.formatoptions:append('ct')
vim.opt.formatoptions:remove('o')
vim.api.nvim_create_autocmd('BufEnter', {
   desc = 'Load formatoptions options in all buffers',
   callback = function()
      vim.opt.formatoptions:append('ct')
      vim.opt.formatoptions:remove('o')
   end,
})

-- Match pairs
vim.opt.matchpairs:append({
   '<:>',
   '=:;',
})

-- -- Folds
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldcolumn = '1'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.opt.foldtext = [[substitute(getline(v:foldstart),'\\\\t',repeat('\\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

-- Search for tags
vim.opt.tags:append({ './tags', 'tags' })

-- Cursor settings for GUIs
vim.opt.guicursor:append({ 'v:hor50' })

-- Completion menu options
vim.opt.completeopt:append({ 'menuone', 'noinsert', 'noselect' })

-- Non visible characters
vim.opt.list = true -- Show invisible characters
vim.opt.listchars:append({
   -- eol = '↴',
   extends = '◣',
   nbsp = '␣',
   precedes = '◢',
   tab = '-->',
   trail = '█',
})

-- To appropriately highlight codefences
vim.g.markdown_fenced_languages = {
   'ts=typescript',
   'tsx=typescriptreact',
   'js=javascript',
   'jsx=javascriptreact',
}

-- See https://github.com/neovim/neovim/pull/16251 for more info on cmdheight=0
-- vim.opt.lines:append '1' -- Hide command line, currently very buggy
-- https://github.com/neovim/neovim/pull/17266 for laststatus = 3
