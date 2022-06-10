local utils = {}

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

function utils.session()
   vim.opt.number = true -- Display line number on the side

   -- Function to setup the initial load and maintain some settings between buffers
   local save_sessions = vim.api.nvim_create_augroup('save_sessions', {})

   vim.cmd('silent! loadview') -- Load the view for the current buffer

   vim.api.nvim_create_autocmd('BufWinEnter', {
      desc = 'Load the view of the buffer',
      group = save_sessions,
      callback = function()
         vim.cmd('silent! loadview') -- Load the view for the opened buffer
         return utils.restore_cursor_position() -- Restore the cursor position
      end,
   })

   vim.api.nvim_create_autocmd('BufWinLeave', {
      desc = 'Save the view of the buffer',
      group = save_sessions,
      callback = function()
         return vim.cmd('silent! mkview')
      end,
   })

   vim.opt.shadafile = ''
   vim.cmd('rshada!')
   return utils.restore_cursor_position()
end

function utils.restore_cursor_position()
   if vim.tbl_contains(utils.ignore_ft(), vim.bo.filetype) then
      return
   end

   local markpos = vim.api.nvim_buf_get_mark(0, '"') -- Get position of last saved edit
   local line = markpos[1]
   local col = markpos[2]
   -- If the cursor line position is less than 1, but not bigger than the lines of the buffer then
   if line <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, { line, col }) -- Set the position
      if vim.fn.foldclosed(line) ~= -1 then -- And check if there's a closed fold
         return vim.cmd('normal! zo')
      end
   end
end

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

function utils.append_by_random(option, T)
   -- Random set of items
   return option:append(T[math.random(1, #T)])
end

function utils.wrap(function_pointer, ...)
   -- Wrapper for functions, it works like pcall
   -- Varargs can't be used as an upvalue, so store them
   -- in this table first.
   local params = { ... }

   return function()
      function_pointer(unpack(params))
   end
end

function utils.is_empty(str)
   return str == '' or str == nil
end

function utils.is_git()
   local is_git = vim.api.nvim_exec('!git rev-parse --is-inside-work-tree', true)
   if is_git:match('true') then
      vim.cmd('doautocmd User IsGit')
      return true
   else
      return false
   end
end

function utils.ignore_ft()
   return {
      'TelescopePrompt',
      'gitcommit',
      'gitdiff',
      'netrw',
   }
end

function utils.conditionals()
   -- Conditionals
   local conditionals = vim.api.nvim_create_augroup('conditionals', {})

   -- Git
   -- Run a comprobation for git, if the file is under git control there's no need to create an autocommand
   if utils.is_git() then
      return
   else
      -- If the current buffer wasn't under git version control run the comprobation each time you change of directory
      vim.api.nvim_create_autocmd('DirChanged', {
         group = conditionals,
         callback = utils.wrap(vim.schedule_wrap, utils.is_git()),
      })
   end
end

-- function utils.is_bigger_than(filepath, size_in_kilobytes)
--     https://www.reddit.com/r/neovim/comments/uz0l9s/psa_if_youre_using_libuv_clean_up_after_yourself/
--     -- Fail if filepath is bigger than the provided size in kilobytes
--     vim.loop.fs_stat(filepath, function(_, stat)
--         if not stat then
--             return
--         end
--         if stat.size > size_in_kilobytes then
--             return
--         else
--             return true
--         end
--     end)
-- end

-- function utils.get_yanked_text()
--     -- Yanked text
--     return print(vim.fn.getreg('"'))
-- end

-- function utils.hide_at_term_width()
--     -- Conditional for width of the terminal
--     return vim.opt.columns:get() > 90
-- end

return utils
