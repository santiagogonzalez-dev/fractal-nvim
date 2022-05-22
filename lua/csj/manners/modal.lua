local modals = {}
local utils = require('csj.utils')

function modals.show_dot_mark_on_gutter()
   -- TODO(santigo-zero): The . mark isn't going to be set on a buffer we have never entered, so don't set the extmark
   -- Other ideas -> use virtualtext, like a ticket '.    笠  mark
   local dot_mark_ns = vim.api.nvim_create_namespace('dot_mark_ns')
   function modals.show_dot()
      local mark_pos = vim.api.nvim_buf_get_mark(0, '.') -- Get the position of the . mark
      if mark_pos[1] == 0 and mark_pos[2] == 0 then
         return
      end

      local get_hl = vim.api.nvim_get_hl_by_name
      utils.set_hl('ShowDotMarkOnGutter', { fg = get_hl('CursorLineNr', true).foreground, bg = get_hl('Normal', true).background })
      vim.g.dot_mark_extmark = vim.api.nvim_buf_set_extmark(0, dot_mark_ns, mark_pos[1] - 1, 0, { sign_text = ' ', sign_hl_group = 'ShowDotMarkOnGutter' })
      return vim.g.dot_mark_extmark
   end

   function modals.remove_dot()
      if vim.g.dot_mark_extmark then
         return pcall(vim.api.nvim_buf_del_extmark, 0, dot_mark_ns, vim.g.dot_mark_extmark)
      end
   end

   local dot_mark_group = vim.api.nvim_create_augroup('dot_mark_group', {})
   vim.api.nvim_create_autocmd('InsertLeave', {
      group = dot_mark_group,
      callback = function()
         modals.remove_dot()
         return modals.show_dot()
      end,
   })

   vim.api.nvim_create_autocmd('InsertEnter', {
      group = dot_mark_group,
      callback = function()
         return modals.remove_dot()
      end,
   })

   vim.api.nvim_create_autocmd('CursorHold', {
      group = dot_mark_group,
      once = true,
      callback = function()
         modals.remove_dot()
         return modals.show_dot()
      end,
   })

   vim.api.nvim_create_autocmd('BufModifiedSet', {
      group = dot_mark_group,
      callback = function()
         -- We check the mode because BufModifiedSet gets triggered on insert and we don't want that
         if vim.api.nvim_get_mode().mode == 'n' then
            modals.remove_dot()
            return modals.show_dot()
         end
      end,
   })
end

function modals.strict_cursor()
   local function h_motion()
      local cursor_position = vim.api.nvim_win_get_cursor(0)
      local line = cursor_position[1]
      local column = cursor_position[2]

      vim.cmd('normal ^')
      local first_non_blank_char = vim.api.nvim_win_get_cursor(0)

      if column == 0 then
         return vim.cmd('normal! k') and vim.cmd('normal! $')
      elseif column <= first_non_blank_char[2] then
         return vim.api.nvim_win_set_cursor(0, { line, 0 })
      else
         return vim.api.nvim_win_set_cursor(0, { line, column - 1 })
      end
   end

   local function l_motion()
      local cursor_position = vim.api.nvim_win_get_cursor(0)
      local line = cursor_position[1]
      local column = cursor_position[2]

      local line_characters = vim.api.nvim_get_current_line()

      vim.cmd('normal ^')
      local first_non_blank_char = vim.api.nvim_win_get_cursor(0)

      if column == #line_characters - 1 or #line_characters == 0 then
         return vim.cmd('normal! j') and vim.cmd('normal! 0')
      elseif column < first_non_blank_char[2] then
         return
      else
         return vim.api.nvim_win_set_cursor(0, { line, column + 1 })
      end
   end

   local function switcher(mode)
      if mode then
         vim.keymap.set('n', 'h', function()
            h_motion()
         end)
         vim.keymap.set('n', 'l', function()
            l_motion()
         end)
         vim.opt.virtualedit = ''
         vim.g.strict_cursor = false
      else
         vim.opt.virtualedit = 'all' -- Be able to put the cursor where there's not actual text
         vim.keymap.del('n', 'h')
         vim.keymap.del('n', 'l')
         vim.g.strict_cursor = true
      end
   end

   switcher(true) -- Enable strict cursor when running the function for the first time
   vim.keymap.set('n', '<Esc><Esc>', function()
      return switcher(vim.g.strict_cursor)
   end)
end

function modals.ask_for_input_on_last_buffer()
   local function eval_buffers()
      local count_bufs_by_type = function(loaded_only)
         loaded_only = (loaded_only == nil and true or loaded_only)
         local COUNT = {
            normal = 0,
            acwrite = 0,
            help = 0,
            nofile = 0,
            nowrite = 0,
            quickfix = 0,
            terminal = 0,
            prompt = 0,
         }
         for _, bufname in pairs(vim.api.nvim_list_bufs()) do
            if not loaded_only or vim.api.nvim_buf_is_loaded(bufname) then
               local buf_type = vim.api.nvim_buf_get_option(bufname, 'buftype')
               buf_type = buf_type ~= '' and buf_type or 'normal'
               COUNT[buf_type] = COUNT[buf_type] + 1
            end
         end
         return COUNT
      end

      if count_bufs_by_type().normal <= 1 then
         vim.ui.select({ 'Delete the buffer', 'Quit neovim' }, {}, function(_, prompt)
            if tonumber(prompt) == 1 then
               return vim.cmd('bd')
            elseif tonumber(prompt) == 2 then
               return vim.cmd('q')
            end
         end)
      else
         return vim.cmd('bp | sp | bn | bd')
      end
   end
   vim.keymap.set('n', '<Leader>c', eval_buffers)
end

function modals.init()
   modals.show_dot_mark_on_gutter()
   modals.strict_cursor() -- Use stricter cursor movements, only enable virtualedit cursor when pressing <Esc><Esc>
   modals.ask_for_input_on_last_buffer() -- Ask user for input if there is only one active normal buffer
end

return modals
