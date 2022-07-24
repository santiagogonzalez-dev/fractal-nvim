local gutter = {}

function gutter.delay_set_relativenumber()
  vim.api.nvim_create_autocmd('UIEnter', {
    callback = function() -- Wait 3 seconds to set relativenumbers
      return vim.defer_fn(function() vim.opt.relativenumber = true end, 3000)
    end,
  })
end

function gutter.only_numbers_cmdline()
  vim.api.nvim_create_autocmd('CmdlineEnter', {
    callback = function() vim.opt.relativenumber = false end,
  })
  vim.api.nvim_create_autocmd('CmdlineLeave', {
    callback = function() vim.opt.relativenumber = true end,
  })
end

vim.opt.number = true -- First enable just the numbers
vim.opt.relativenumber = false -- And disable relativenumbers if they are setup on user.opts
gutter.delay_set_relativenumber()
gutter.only_numbers_cmdline()

return gutter
