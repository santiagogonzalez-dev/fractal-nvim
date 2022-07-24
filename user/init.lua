require('keymaps')

-- Settings for non-visible characters
vim.opt.fillchars:append {
  eob = ' ', -- Don't show the ~ at the eof
  -- Separator between the cmdline messages and the buffer window, doesn't work
  -- with vim.opt.cmdheight = 0
  msgsep = '🮑',
}

csj.append_by_random(vim.opt.fillchars, {
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
