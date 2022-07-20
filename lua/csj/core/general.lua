-- Some general settings
local utils = require('csj.core.utils')

-- Default tab size, this is not applied if you specified a different one in
-- ftplugin
local tab_lenght = 4
vim.opt.shiftwidth = tab_lenght -- Size of a > or < when indenting
vim.opt.tabstop = tab_lenght -- Tab length

-- Cursor settings
vim.opt.guicursor:append('v:hor50')
vim.opt.guicursor:append('i-ci-ve:ver25')
vim.opt.guicursor:append('r-cr-o:hor20')

vim.opt.path:append('**') -- Search files recursively

-- Settings for non-visible characters
vim.opt.fillchars:append {
  eob = ' ', -- Don't show the ~ at the eof
  -- Separator between the cmdline messages and the buffer window, doesn't work
  -- with vim.opt.cmdheight = 0
  msgsep = '🮑',
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
  -- eol = '↪',
  -- eol = '↲',
  -- eol = '↴',
  -- eol = '⏎',
  -- eol = '',
  -- space = '·',
  -- tab = '-->',
  -- trail = "·",
  -- trail = '█',
  extends = '◣',
  nbsp = '␣',
  precedes = '◢',
  tab = '!·',
  trail = '␣',
}

-- To appropriately highlight codefences
vim.g.markdown_fenced_languages = {
  'js=javascript',
  'jsx=javascriptreact',
  'ts=typescript',
  'tsx=typescriptreact',
}
