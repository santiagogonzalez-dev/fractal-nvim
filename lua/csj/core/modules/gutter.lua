local gutter = {}

-- This enables relativenumber after a `waiting_time` when starting neovim, this
-- way we see numbers first, mostly because of looks.
---@param waiting_time number
---@return nil
function gutter.delay_set_relativenumber(waiting_time)
  vim.defer_fn(function()
    vim.opt.relativenumber = true
  end, waiting_time)
end

function gutter.only_numbers_cmdline()
  vim.api.nvim_create_autocmd('CmdlineEnter', {
    callback = function()
      vim.opt.relativenumber = false
    end,
  })
  vim.api.nvim_create_autocmd('CmdlineLeave', {
    callback = function()
      vim.opt.relativenumber = true
    end,
  })
end

function gutter.disable_on_insert()
  vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function()
      vim.opt.relativenumber = false
    end,
  })
  vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function()
      vim.opt.relativenumber = true
    end,
  })
end

vim.opt.number = true -- First enable just the numbers
vim.opt.relativenumber = false -- And disable relativenumbers if they are setup on user.opts
gutter.delay_set_relativenumber(3000)
gutter.only_numbers_cmdline()
gutter.disable_on_insert()

-- TODO(santigo-zero): Maybe notify if the user have both relativenumber and
-- this module enabled and do something about it.

return gutter
