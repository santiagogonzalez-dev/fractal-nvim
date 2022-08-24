-- Override default icons and settings related to folds.

local folds = {}

-- When a block of code is folded some text appears in the line of the fold,
-- this function reformats the code to be "smarter"
---@return string
function folds.foldtext_header()
  local AVOID = {
    import = 'imports',
    from = 'imports',
  }

  local function start_fold()
    local header_fold =
      vim.api.nvim_buf_get_lines(0, vim.v.foldstart - 1, vim.v.foldstart, false)
    for key, header in pairs(AVOID) do
      if header_fold[1]:match(key) then
        return header -- For example instead of seeing "from pathlib import Path" we just see "imports"
      else
        local clean_string =
          header_fold[1]:gsub('%(%)', ''):gsub('%{', ''):gsub('%=', ''):gsub('%:', ' ')
        return clean_string
      end
    end
  end

  -- local function end_fold()
  -- TODO(santigo-zero): Match the return statement and do something about it, maybe use treesitter
  --    -- To match a return statement
  --    return 'NOTHING'
  -- end

  -- return start_fold() .. end_fold()
  return start_fold()
end

function folds.fold_this_block()
  -- TODO(santigo-zero): redo everything in this function
  local ok_ts, ts = pcall(require, 'vim.treesitter')
  local ok_get_parser, parser = pcall(ts.get_parser, 0, vim.bo.filetype)
  if not ok_ts or not ok_get_parser or not parser then
    -- If treesitter or the parser are not installed just use the ip motion
    vim.api.nvim_feedkeys('zfip', 'n', 'v:false')
    return
  end

  local ts_utils = require('nvim-treesitter.ts_utils') -- Treesitter utilities
  local node = ts_utils.get_node_at_cursor() -- Get the node under cursor

  local NODES = {
    'if_statement',
    'for_statement',
    'function_declaration',
    'function_definition',
    'class_definition',
  }

  local function create_fold_on_node()
    local start_line, _, end_line, _ = ts_utils.get_node_range(node)
    start_line = start_line + 1 -- Treesitter reads lines from 0 instead of 1 like in neovim
    end_line = end_line + 1

    vim.api.nvim_win_set_cursor(0, { start_line, 0 }) -- Move to the start of the function
    vim.cmd('norm {') -- And we get the comments or whatever that it is on top of the function

    local start_block = vim.api.nvim_win_get_cursor(0)

    vim.api.nvim_win_set_cursor(0, { end_line, 0 }) -- Now we move to the end of the function
    vim.cmd('norm }') -- And we get whatever it is that it's under the function
    local end_block = vim.api.nvim_win_get_cursor(0)

    vim.notify(
      'Fold created from ' .. start_block[1] + 1 .. ' to ' .. end_block[1] - 1,
      vim.log.levels.INFO
    )
    vim.cmd(':' .. start_block[1] + 1 .. ',' .. end_block[1] - 1 .. 'fold') -- Create the fold
    return vim.api.nvim_win_set_cursor(0, { start_line, 0 }) -- And put the cursor on the fold line
  end

  for _, current_node in ipairs(NODES) do
    if current_node == node:type() then
      create_fold_on_node()
      break
    elseif current_node == node:parent():type() then
      node = node:parent()
      create_fold_on_node()
    end
  end
end

function folds.fold_block()
  -- Check if treesitter is working
  local ok_ts, ts = pcall(require, 'vim.treesitter')
  local ok_get_parser, parser = pcall(ts.get_parser, 0, vim.bo.filetype)
  if not ok_ts or not ok_get_parser or not parser then
    -- TODO(santigo-zero): If treesitter or the parser are not installed just
    -- use the ip motion
    return
  end

  local ts_utils = require('nvim-treesitter.ts_utils') -- Treesitter utilities
  local node = ts_utils.get_node_at_cursor() -- Get the node under cursor

  local NODES = {
    'if_statement',
    'for_statement',
    'function_declaration',
    'function_definition',
    'class_definition',
  }
end

vim.keymap.set('n', 'test', function()
  return folds.fold_block()
end)

-- Fold settings
vim.opt.jumpoptions = 'stack,view'
vim.opt.foldtext = 'v:lua.require("csj.modules.folds").foldtext_header()'
vim.opt.foldcolumn = 'auto:3' -- Folds column
vim.opt.foldmethod = 'manual'
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.opt.fillchars:append {
  fold = ' ', -- Filling foldtext
  -- foldsep = '🮍',
  foldclose = '',
  -- foldclose = '',
  foldsep = '▎',
  foldopen = '▎',
}

return folds
