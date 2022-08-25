local utils = {}

-- Protected require, notifies if there's an error loading a module
---@return boolean|string|number @ Either nil or the value of require()
function utils.prequire(package)
  local status, lib = pcall(require, package)
  if status then
    return lib
  else
    vim.schedule(function()
      -- If you don't schedule this and you are using the notifications module
      -- the errors will still showup on the terminal
      vim.notify('Failed to require "' .. package .. '" from ' .. vim.log.levels.WARN)
      -- vim.notify('Failed to require "' .. package .. '" from ' .. debug.getinfo(2).source)
      -- This ^^ one will print the error in the terminal even when using the
      -- notification module
    end)
    return false
  end
end

-- Wrapper for setting highlights groups
---@param mode string|table
---@param table table
---@return nil
function utils.set_hl(mode, table)
  -- Highlights
  if type(mode) == 'table' then
    for _, groups in pairs(mode) do
      vim.api.nvim_set_hl(0, groups, table)
    end
  else
    vim.api.nvim_set_hl(0, mode, table)
  end
end

---@return boolean
function utils.not_interfere_on_float()
  -- Do not open floating windows if there's already one open
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      vim.notify('There is a floating window open already', vim.log.levels.WARN)
      return false
    end
  end

  return true
end

-- Wrapper for functions, it works like pcall
-- Varargs can't be used as an upvalue, so store them
-- in this table first.
---@param function_pointer function
---@param ... any
function utils.wrap(function_pointer, ...)
  local params = { ... }

  return function()
    function_pointer(unpack(params))
  end
end

---@param str string
---@return string|boolean @ Either an empty string or false
function utils.is_empty(str)
  return str == '' or str == nil
end

-- Check if the working directory is under git managment
---@return boolean
function utils.is_git()
  local is_git = vim.api.nvim_exec('!git rev-parse --is-inside-work-tree', true)
  if is_git:match('true') then
    vim.cmd.doautocmd('User IsGit') -- vim.cmd.doautocmd { args = { 'User', 'IsGit' } }
    -- vim.cmd('doautocmd User IsGit')
    return true
  else
    return false
  end
end

-- Filetypes to ignore
---@return table
utils.IGNORE_FT = {
  'TelescopePrompt',
  'gitcommit',
  'gitdiff',
  'netrw',
  'packer',
  'help',
  'startify',
}

-- If there's a filetype that I want to ignore return true, so you can do
-- something like:
-- if utils.avoid_filetype() then
--   return
-- end
---@return boolean @ Return false if the filetype of the buffer is matching the
---table utils.IGNORE_FT
function utils.avoid_filetype()
  if vim.tbl_contains(utils.IGNORE_FT, vim.bo.filetype) then
    return true
  else
    return false
  end
end

function utils.get_fg_hl(hl_group)
  return vim.api.nvim_get_hl_by_name(hl_group, true).foreground
end
function utils.get_bg_hl(hl_group)
  return vim.api.nvim_get_hl_by_name(hl_group, true).background
end

-- function utils.interpret_color()
--   -- vim.cmd([[
--   -- def InlineColors()
--   --     for row in range(1, line('$'))
--   --         var current = getline(row)
--   --         var cnt = 1
--   --         prop_clear(row)
--   --         var [hex, starts, ends] = matchstrpos(current, '#\x\{6\}', 0, cnt)
--   --         while starts != -1
--   --             var col_tag = "inline_color_" .. hex[1 : ]
--   --             var col_type = prop_type_get(col_tag)
--   --             if col_type == {}
--   --                 hlset([{ name: col_tag, guifg: hex}])
--   --                 prop_type_add(col_tag, {highlight: col_tag})
--   --             endif
--   --             prop_add(row, starts + 1, { length: ends - starts, text: " ● ", type: col_tag })
--   --             cnt += 1
--   --             [hex, starts, ends] = matchstrpos(current, '#\x\{6\}', 0, cnt)
--   --         endwhile
--   --     endfor
--   -- enddef
--   -- ]])

--   -- for row in ipairs(vim.fn.range(1, vim.fn.line('$'))) do
--   --   local line_str = vim.fn.getline(row)
--   --   local counter = 1
--   --   local T = vim.fn.matchstrpos(line_str, [[#\x\{6\}]], 0, counter)
--   --   local hex = T[1]
--   --   local starts = T[2]
--   --   local ends = T[3]

--   --   while starts ~= -1 do
--   --     local col_tag = string.format('%s%s', 'inline_color_', string.gsub(hex, '%#', ''))
--   --     print(col_tag)
--   --     counter = counter + 1
--   --   end
--   -- end
--   local bnr = vim.fn.bufnr('%')
--   local ns_id = vim.api.nvim_create_namespace('demo')

--   -- local line_num = 5
--   -- local col_num = 5
--   local cursor = vim.api.nvim_win_get_cursor(0)
--   local line_num = cursor[1]
--   local col_num = cursor[2]

--   local opts = {
--     end_line = 10,
--     id = 1,
--     virt_text = { { 'demo', 'IncSearch' } },
--     virt_text_pos = 'overlay',
--     -- virt_text_win_col = 20,
--   }

--   local mark_id = vim.api.nvim_buf_set_extmark(bnr, ns_id, line_num, col_num, opts)
-- end
-- Put this somewhere else
-- vim.keymap.set('n','<Leader>x', require('csj.core.utils').interpret_color)
-- -- '#EBA0AC' '#2B6F92' '#E9436F' '#BB9AF7',

return utils
