vim.o.termguicolors = true -- Enable colors in the terminal

vim.cmd([[
   try
      set background=dark
      colorscheme csjcolors
      " colorscheme rose-pine
   catch /^Vim\%((\a\+)\)\=:E185/
      colorscheme default
      set background=dark
   endtry
]])

-- -- :so $VIMRUNTIME/syntax/hitest.vim
local set_hl = require('csj.utils').set_hl
-- vim.fn.matchadd('errorMsg', '\\s\\+$') -- Show trail character in red
-- set_hl('PmenuSel', { bg = '#313552', blend = 0 }) -- Make selected option in popup menu being solid color
-- set_hl('Visual', { reverse = true })
-- set_hl('Search', { fg = 'orange', bg = 'purple' })
-- set_hl('Number', { italic = true, fg = '#ea9d34' })
-- set_hl('InactiveWindow', { bg = '#15131e' }) -- 1f1d2e 15131e
-- set_hl({ 'LineNr', 'FoldColumn', 'StatusLine' }, { fg = '#44415a' })
-- set_hl('Folded', { fg = '#575279' })
-- set_hl('Comment', { italic = true, fg = '#575279' })
-- set_hl('CursorLineNr', { bg = vim.api.nvim_get_hl_by_name('CursorColumn', true).background })
-- set_hl('NonText', { fg = '#44415a' })

-- set_hl('TSVariable', { fg = '#908caa' })
-- set_hl('TSFuncBuiltin', { fg = '#3e8fb0' })

-- -- set_hl('TSPunctBracket', { fg = 'red', bg = 'black' })
-- local variants = {
--     rose_pine = {
--         l = {
--             error = '#b4637a',
--             accent = '#907aa9',
--             on_accent = '#ffffff',
--             bg_low = '#faf4ed',
--             bg_med = '#fffaf3',
--             bg_high = '#f2e9e1',
--             fg_low = '#9893a5',
--             fg_med = '#797593',
--             fg_high = '#575279',
--         },
--         d = {
--             error = '#eb6f92',
--             accent = '#c4a7e7',
--             on_accent = '#ffffff',
--             bg_low = '#191724',
--             bg_med = '#1f1d2e',
--             bg_high = '#26233a',
--             fg_low = '#6e6a86',
--             fg_med = '#908caa',
--             fg_high = '#e0def4',
--         },
--     },
--     neutral = {
--         l = {
--             error = '#c75c6a',
--             accent = '#f2cea5',
--             on_accent = '#ffffff',
--             bg_low = '#ffffff',
--             bg_med = '#f3f3f3',
--             bg_high = '#dfdfdf',
--             fg_low = '#8f8f8f',
--             fg_med = '#6f6f6f',
--             fg_high = '#171717',
--         },
--         d = {
--             error = '#c75c6a',
--             accent = '#a58058',
--             on_accent = '#ffffff',
--             bg_low = '#1c1c1c',
--             bg_med = '#232323',
--             bg_high = '#323232',
--             fg_low = '#707070',
--             fg_med = '#a0a0a0',
--             fg_high = '#f2f2f2',
--         },
--     },
--     stone = {
--         l = {
--             error = '#c75c6a',
--             accent = '#f2cea5',
--             on_accent = '#ffffff',
--             bg_low = '#fafaf9',
--             bg_med = '#f5f5f4',
--             bg_high = '#d6d3d1',
--             fg_low = '#a8a29e',
--             fg_med = '#57534e',
--             fg_high = '#1c1917',
--         },
--         d = {
--             error = '#c75c6a',
--             accent = '#a58058',
--             on_accent = '#ffffff',
--             bg_low = '#1c1917',
--             bg_med = '#292524',
--             bg_high = '#44403c',
--             fg_low = '#78716c',
--             fg_med = '#a8a29e',
--             fg_high = '#f5f5f4',
--         },
--     },
-- }
