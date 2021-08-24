vim.opt.ignorecase = true -- Ignore case
vim.opt.smartcase = true -- Smart case
vim.opt.smartindent = true -- Smart identation

vim.opt.conceallevel = 0 -- Show text normally
vim.opt.pumheight = 10 -- Pop up menu height
vim.opt.showmode = true -- Hides/shows mode status below status line
vim.opt.timeoutlen = 333 -- Time given for doing a sequence
vim.opt.updatetime = 333 -- Faster completion - CursorHold interval
vim.opt.title = true -- Set the window title based on the value of titlestring
vim.opt.wrap = false -- Do not wrap
vim.opt.number = true -- Display line number on the side
vim.opt.relativenumber = true -- Display line number relative to the cursor
vim.opt.list = true -- Show whitespace
vim.opt.backspace= 'indent,start,eol' -- Make backspace behave like normal again
vim.opt.clipboard = 'unnamedplus' -- Uses the system clipboard
vim.opt.fileencoding = 'utf-8' -- The encode used in the file
vim.opt.wildignore  = '*.o,*.rej,*.so'
vim.opt.hidden = true -- It keeps buffers open in memory
vim.opt.hlsearch = true -- ingremental search
vim.opt.mouse = 'a' -- mouse can select, paste and
vim.opt.colorcolumn = '83' -- Limiter line
vim.opt.cursorline = true -- Draw line on cursor
vim.opt.cmdheight = 1 -- Space for displaying messages in the command line
-- vim.opt.guifont = 'JetBrainsMono Nerd Font:h18'
vim.opt.signcolumn = 'yes' -- Show/hide signs column
vim.api.nvim_exec('highlight visual cterm=reverse gui=reverse', false) -- Visual mode reversed colors
vim.opt.termguicolors = false -- set term gui colors (most terminals support this)
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' } -- Menu options
vim.opt.lazyredraw = false -- Faster scrolling
vim.opt.inccommand = 'split' -- Live preview of :s results
vim.opt.scrolloff = 8 -- Cursor does not reach top/bottom
vim.opt.sidescrolloff = 8 -- Cursor does not reach sides
vim.opt.splitbelow = true -- Force splits to go below current window
vim.opt.splitright = true -- Force all vertical splits to go to the right of current window

vim.opt.swapfile = false -- It does (not) creates a swapfile
vim.opt.undofile = true -- Persistent undo - undo after you re-open the file

vim.opt.showtabline = 2 -- Show top tab bar
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftround = true
vim.opt.shiftwidth = 4 -- Number of spaces per tab for indentation
vim.opt.tabstop = 4 -- Tab length

-- The function on vimscript/init.vim works better without moving your cursor to the whitespace on :w so I'll use that
vim.api.nvim_exec('set list listchars=nbsp:¬,tab:»·,trail:·,extends:>', false) -- Show whitespaces
-- vim.cmd([[au BufWritePre * :%s/\s\+$//e]]) -- Remove whitespace on save
-- vim.cmd 'autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=grey' -- Show whitespace

vim.opt.listchars = {
    nbsp        = '⦸',  -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
    extends     = '»',  -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
    precedes    = '«',  -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
    tab         = '▷-', -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
    trail       = '•',  -- BULLET (U+2022, UTF-8: E2 80 A2)
    space       = ' ',
}
vim.opt.fillchars = {
    diff        = '∙', -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
    eob         = ' ', -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
    fold        = '·', -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    vert        = ' ', -- remove ugly vertical lines on window division
}

vim.cmd 'filetype plugin on'
vim.cmd 'set path+=**'
vim.cmd 'set tags+=./tags;,tags'
vim.cmd 'set iskeyword+=-'

-- Jump to the last position when reopening a file instead of typing '. to go to the last mark
vim.cmd([[
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
]])

-- 2 spaces for selected filetypes
vim.cmd([[ autocmd FileType xml,xhtml,dart setlocal shiftwidth=2 tabstop=2 ]])
-- 4 spaces for selected filetypes
vim.cmd([[ autocmd FileType html,css,scssjavascript,lua,dart,python,c,cpp,md,sh setlocal shiftwidth=4 tabstop=4 ]])
-- 8 spaces for Go files
vim.cmd([[ autocmd FileType go setlocal shiftwidth=8 tabstop=8 ]])
