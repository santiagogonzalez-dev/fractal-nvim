-- Modified version of lukas-reineke virt-column.nvim, overrides the colorcolumn.

local ffi = require('ffi')
local utils = {}
local commands = {}
local M = {
  config = {
    -- char = '┃',
    char = '│',
    virtcolumn = '',
  },
  buffer_config = {},
}

function utils.concat_table(t1, t2)
  for _, v in ipairs(t2) do
    t1[#t1 + 1] = v
  end
  return t1
end

function commands.refresh(bang)
  if bang then
    local win = vim.api.nvim_get_current_win()
    vim.cmd('noautocmd windo lua require("csj.core.virtcolumn").refresh()')
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_set_current_win(win)
      M.refresh()
    end
  else
    M.refresh()
  end
end

ffi.cdef('int curwin_col_off(void);')

function M.clear_buf(bufnr)
  if M.namespace then vim.api.nvim_buf_clear_namespace(bufnr, M.namespace, 0, -1) end
end

function M.setup(config)
  M.config = vim.tbl_deep_extend('force', M.config, config or {})
  M.namespace = vim.api.nvim_create_namespace('virtcolumn')

  vim.api.nvim_create_user_command('VirtColumnRefresh', function() commands.refresh('<bang> == !') end, { bang = true })

  -- vim.api.nvim_set_hl(0, 'VirtColumn', { fg = vim.api.nvim_get_hl_by_name('CursorColumn', true).background })
  -- vim.api.nvim_set_hl(0, 'ColorColumn', {})
  csj.set_hl('VirtColumn', { fg = vim.api.nvim_get_hl_by_name('CursorColumn', true).background })
  csj.set_hl('ColorColumn', {})

  vim.api.nvim_create_augroup('_virtcolumn', {})
  vim.api.nvim_create_autocmd({
    'BufWinEnter',
    'CompleteChanged',
    'FileChangedShellPost',
    'InsertLeave',
    'TextChanged',
    'TextChangedI',
    'UIEnter',
    'WinEnter',
  }, { group = '_virtcolumn', command = 'VirtColumnRefresh' })
  -- vim.schedule_wrap(vim.cmd('VirtColumnRefresh'))
end

function M.setup_buffer(config)
  M.buffer_config[vim.api.nvim_get_current_buf()] = config
  M.refresh()
end

function M.refresh()
  local bufnr = vim.api.nvim_get_current_buf()

  if not vim.api.nvim_buf_is_loaded(bufnr) then return end

  local config = vim.tbl_deep_extend('force', M.config, M.buffer_config[bufnr] or {})
  local winnr = vim.api.nvim_get_current_win()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local width = vim.api.nvim_win_get_width(winnr) - ffi.C.curwin_col_off()
  local textwidth = vim.opt.textwidth:get()
  local colorcolumn = utils.concat_table(vim.opt.colorcolumn:get(), vim.split(config.virtcolumn, ','))

  for i, c in ipairs(colorcolumn) do
    if vim.startswith(c, '+') then
      if textwidth ~= 0 then
        colorcolumn[i] = textwidth + tonumber(c:sub(2))
      else
        colorcolumn[i] = nil
      end
    elseif vim.startswith(c, '-') then
      if textwidth ~= 0 then
        colorcolumn[i] = textwidth - tonumber(c:sub(2))
      else
        colorcolumn[i] = nil
      end
    else
      colorcolumn[i] = tonumber(c)
    end
  end

  table.sort(colorcolumn, function(a, b) return a > b end)

  M.clear_buf(bufnr)

  for i = 1, #lines, 1 do
    for _, column in ipairs(colorcolumn) do
      local line = lines[i]:gsub('\t', string.rep(' ', vim.opt.tabstop:get()))
      if width > column and vim.api.nvim_strwidth(line) < column then
        vim.api.nvim_buf_set_extmark(bufnr, M.namespace, i - 1, 0, {
          virt_text = { { config.char, 'VirtColumn' } },
          virt_text_pos = 'overlay',
          hl_mode = 'combine',
          virt_text_win_col = column - 1,
          priority = 1,
        })
      end
    end
  end
end

vim.schedule_wrap(function()
  M.setup {}
  -- vim.api.nvim_cmd({ cmd = 'VirtColumnRefresh' }, {})
  vim.cmd.VirtColumnRefresh()
end)()

return M, utils, commands
