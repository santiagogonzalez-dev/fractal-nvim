local options = {
    textwidth = 88, -- Delimit text blocks to N columns
    colorcolumn = '+1', -- Limiter line, + line more than textwidth
    conceallevel = 2, -- Show text normally
}

for k, v in pairs(options) do
    vim.o[k] = v
end

-- Enter the python virtual environment without having sourced the file before entering neovim
if vim.fn.exists('$VIRTUAL_ENV') == 1 then
    vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system('which -a python | head -n2 | tail -n1'), '\n', '', 'g')
else
    vim.g.python3_host_prog = vim.fn.substitute(vim.fn.system('which python'), '\n', '', 'g')
end
