local gutter = {}

-- DESCRIPTION: An attempt to give the gutter or number column a nicer look

-- Enable `relativenumber` after `waiting_time` on startup
---@param waiting_time number @ In milliseconds, e.g. 1 second would be 1000
---@return nil
function gutter.delay_set_relativenumber(waiting_time)
  vim.defer_fn(function()
    vim.opt.relativenumber = true
  end, waiting_time)
end

-- Disable `relativenumber` when we are using the cmdline, this way it's easier
-- to work with ranges
---@return nil
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

-- Disable `relativenumber` when we are in insert mode
---@return nil
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
