local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

local status_gps_ok, gps = pcall(require, 'nvim-gps')
if not status_gps_ok then
  return
end

local nvim_gps = function()
  if gps.is_available() == false then
    return ''
  else
    return gps.get_location()
  end
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 90
end

local progress = function()
  local current_line = vim.fn.line('.')
  local total_lines = vim.fn.line('$')
  local line_ratio = current_line / total_lines
  local chars = { '██', '▇▇', '▆▆', '▅▅', '▄▄', '▃▃', '▂▂', '▁▁' }
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

lualine.setup {
  options = {
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'packer', 'NvimTree', 'toggleterm' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { { 'branch', separator = { right = '' } } },
    lualine_b = { { 'buffers', separator = { right = '' } } },
    lualine_c = { { nvim_gps, cond = require('csj.core.utils').hide_at_vp } },

    lualine_x = {},
    lualine_y = { 'diff', 'diagnostics' },
    lualine_z = { progress, 'location' },
  },
}
