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

-- Search files recursively
vim.opt.path:append('**')

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

-- Ensure this settings persist in all buffers
function _G.all_buffers_settings()
  vim.opt.iskeyword = '@,48-57,192-255'

  vim.opt.formatoptions = vim.opt.formatoptions
    + 'r' -- If the line is a comment insert another one below when hitting <CR>
    + 'c' -- Wrap comments at the char defined in textwidth
    + 'q' -- Allow formatting comments with gq
    + 'j' -- Remove comment leader when joining lines when possible
    - 'o' -- Don't continue comments after o/O
    - 'l' -- Format in insert mode if the line is longer than textwidth

  -- There's a non-visible character at cchar= so watch
  vim.cmd([[syntax match hidechars '\'' conceal " cchar= ]])
  vim.cmd([[syntax match hidechars '\"' conceal " cchar= ]])
  vim.cmd([[syntax match hidechars '\[\[' conceal " cchar= ]])
  vim.cmd([[syntax match hidechars '\]\]' conceal " cchar= ]])
  -- vim.cmd([[syntax match hidechars '{}' conceal cchar=]])
end

vim.api.nvim_create_autocmd('BufEnter', {
  -- group = 'session_opts',
  callback = _G.all_buffers_settings,
})
_G.all_buffers_settings()
