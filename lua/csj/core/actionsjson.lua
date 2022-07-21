local json = {}

json.show = function()
  return vim.fn.json_decode(table.concat(vim.fn.readfile('/home/st/.config/nvim/user/example.json'), '\n'))
end

return json
