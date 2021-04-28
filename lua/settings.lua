vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
vim.cmd('set inccommand=split') -- Make substitution work in realtime
vim.o.pastetoggle="<F3>" -- Add map to enter paste mode
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.o.title = true -- Window title
TERMINAL = vim.fn.expand('$TERMINAL')
vim.cmd('let &titleold="'..TERMINAL..'"')
vim.o.titlestring="%<%F%=%l/%L - nvim"
vim.wo.wrap = false -- Display long lines as just one line
vim.cmd('set whichwrap+=<,>,[,],h,l') -- Move to next line with theses keys
vim.cmd('syntax on') -- Syntax highlighting
vim.cmd('set scrolloff=8') -- Cursor does not go all the way up/bottom, leaves 8 rows
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.cmd('set colorcolumn=88') -- fix indentline for now
vim.o.mouse = "a" -- Make mouse useful
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.o.conceallevel = 0 -- So that I can see `` in markdown files
vim.cmd('set ts=4') -- Insert 4 spaces for a tab
vim.cmd('set sw=4') -- Change the number of space characters inserted for indentation
vim.bo.expandtab = true -- Converts tabs to spaces
vim.bo.smartindent = true -- Makes indenting smart
vim.o.ignorecase = true -- Case insesitive searching UNLESS /C or capital in search
vim.o.smartcase = true -- Smart case
vim.wo.number = true -- Set numbered lines
vim.wo.relativenumber = true -- Set relative number
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.showtabline = 2 -- Always show tabs
vim.o.showmode = false -- We don't need to see things like -- INSERT -- anymore
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 100 -- By default timeoutlen is 1000 ms
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
-- vim.o.cmdheight = 2 -- More space for displaying messages
vim.wo.signcolumn = "yes" -- always show the signcolumn, otherwise it would shift the text each time
vim.o.hlsearch = true -- set highlight on search
vim.o.incsearch = true -- incremental search
vim.o.breakindent = true -- enable break indent
-- vim.cmd('let $nvim_tui_enable_true_color=1') -- true color
vim.o.t_co = "256" -- support 256 colors
vim.o.termguicolors = true -- set term gui colors most terminals support this
vim.cmd[[set background=dark]] -- set to light for light theme
vim.cmd[[colorscheme palenight]] -- change colorscheme
-- vim.cmd[[colorscheme onedark]]
-- vim.cmd[[hi normal guibg=#2a2331]] -- change background color
-- vim.g.onedark_terminal_italics = 2 -- italics for one-dark colorscheme
vim.o.guifont = "Iosevka nerd font:h19"
-- vim.o.guifont = "SauceCodeProMono Nerd Font:h19"
-- vim.o.guifont = "Hack Nerd Font:h19"
-- vim.o.guifont = "mononoki nerd font:h18"
-- vim.o.guifont = "fantasquesansmono nerd font:h18"
-- vim.cmd[[let g:neovide_transparency=0.96]]
-- vim.cmd[[let g:neovide_fullscreen=v:true]]

togglemouse = function()
  if vim.o.mouse == 'a' then
    vim.cmd[[indentblanklinedisable]]
    vim.wo.signcolumn='no'
    vim.o.mouse = 'v'
    vim.wo.number = false
    print("mouse disabled")
  else
    vim.cmd[[indentblanklineenable]]
    vim.wo.signcolumn='yes'
    vim.o.mouse = 'a'
    vim.wo.number = true
    print("mouse enabled")
  end
end -- toggle to disable mouse mode and indentlines for easier paste

vim.api.nvim_exec([[
  augroup yankhighlight
    autocmd!
    autocmd textyankpost * silent! lua vim.highlight.on_yank()
  augroup end
]], false) -- highlight on yank
