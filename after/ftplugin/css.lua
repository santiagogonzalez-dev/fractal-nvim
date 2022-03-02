local tab_lenght = 2

local options = {
   shiftwidth = tab_lenght, -- Size of a > or < when indenting
   tabstop = tab_lenght, -- Tab length
   softtabstop = -1, -- Tab length, if negative shiftwidth value is used
   textwidth = 80,
   colorcolumn = '+1',
}

for k, v in pairs(options) do
   vim.o[k] = v
end
