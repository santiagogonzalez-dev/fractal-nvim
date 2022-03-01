local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
   return
end

local hide_in_width = function()
   return vim.fn.winwidth(0) > 80
end

--   git add
--   git mod
--   git remove
--   git ignore
--   git rename
--   error
--   info
--   question
--   warning
--   lightbulb

local diagnostics = {
   'diagnostics',
   sources = { 'nvim_diagnostic' },
   sections = { 'error', 'warn' },
   symbols = { error = ' ', warn = ' ' },
   colored = true,
   update_in_insert = true,
   always_visible = false,
}

local diff = {
   'diff',
   colored = false,
   symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
   cond = hide_in_width,
}

local filetype = {
   'filetype',
   icons_enabled = true,
}

local branch = {
   'branch',
   icons_enabled = true,
   icon = '',
}

local cursor_location = {
   'location',
   padding = 0,
}

-- Progress through the file
local position = function()
   local current_line = vim.fn.line('.')
   local total_lines = vim.fn.line('$')
   local chars = { 'Top', 'Mid', 'Bot' }
   local line_ratio = current_line / total_lines
   local index = math.ceil(line_ratio * #chars)
   return chars[index]
end

lualine.setup({
   options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = ' ' },
      disabled_filetypes = { 'alpha', 'dashboard', 'NvimTree', 'Outline', 'toggleterm' },
      always_divide_middle = false,
   },
   sections = {
      lualine_a = { branch },
      lualine_b = { filetype },
      lualine_c = { diagnostics },
      lualine_x = { diff },
      lualine_y = { cursor_location },
      lualine_z = { position },
   },
})
