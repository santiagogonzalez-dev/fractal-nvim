require('user.keymaps')

-- Settings for non-visible characters
vim.opt.fillchars:append {
  eob = ' ', -- Don't show the ~ at the eof
  -- Separator between the cmdline messages and the buffer window, doesn't work
  -- with vim.opt.cmdheight = 0
  msgsep = '🮑',
}

vim.opt.fillchars:append {
  -- horiz = '━',
  -- horizup = '┻',
  -- horizdown = '┳',
  -- vert = '┃',
  -- vertleft = '┫',
  -- vertright = '┣',
  -- verthoriz = '╋',

  horiz = '─',
  horizup = '┴',
  horizdown = '┬',
  vert = '│',
  vertleft = '┤',
  vertright = '├',
  verthoriz = '┼',

  -- horiz = ' ',
  -- horizup = ' ',
  -- horizdown = ' ',
  -- vert = ' ',
  -- vertleft = ' ',
  -- vertright = ' ',
  -- verthoriz = ' ',
}

vim.opt.listchars:append {
  -- eol = '↪',
  -- eol = '↲',
  -- eol = '↴',
  -- eol = '⏎',
  -- eol = '',
  -- space = '·',
  -- tab = '-->',
  -- trail = "·",
  -- trail = '␣',
  extends = '◣',
  nbsp = '␣',
  precedes = '◢',
  tab = '!·',
  trail = '█',
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

  -- vim.opt.cpoptions = vim.opt.cpoptions
  --   + 'n' -- Show `showbreak` icon in the number column

  vim.opt.cpoptions = vim.opt.cpoptions
    + 'n' -- Show the showbreak icon on the gutter

  -- There's a non-visible character at cchar= so watch
  vim.schedule(function()
    vim.cmd([[syntax match hidechars '\'' conceal " cchar= ]])
    vim.cmd([[syntax match hidechars '\"' conceal " cchar= ]])
    vim.cmd([[syntax match hidechars '\[\[' conceal " cchar= ]])
    vim.cmd([[syntax match hidechars '\]\]' conceal " cchar= ]])
    -- vim.cmd([[syntax match hidechars '{}' conceal cchar=]])
  end)
end

vim.api.nvim_create_autocmd('BufEnter', {
  group = 'session_opts',
  callback = _G.all_buffers_settings,
})
_G.all_buffers_settings()

-- TODO(santigo-zero): create a function that bootstraps packer

-- TODO(santigo-zero):
-- -- This is run after neovim loads, it checks if you started neovim into
-- -- an empty buffer and if you did it opens projects.nvim with telescope.
-- vim.api.nvim_create_autocmd('UIEnter', {
--   callback = function()
--     if vim.bo.filetype ~= '' then -- Check if the buffer has a filetype
--       return
--     end
--     -- If it doesn't we check if it's empty
--     if vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == '' then
--       vim.cmd.PackerLoad('telescope.nvim')
--       vim.cmd.Telescope('projects')
--     end
--   end,
-- })

require('user.plugins')
