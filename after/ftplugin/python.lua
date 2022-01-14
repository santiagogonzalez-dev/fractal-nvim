local options = {
    textwidth = 88, -- Delimit text blocks to N columns
    colorcolumn = '+1', -- Limiter line, + line more than textwidth
    conceallevel = 2, -- Show text normally
}

for k, v in pairs(options) do
    vim.o[k] = v
end
