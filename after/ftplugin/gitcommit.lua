local options = {
    textwidth = 80, -- Delimit text blocks to N columns
    colorcolumn = '+1', -- Limiter line, + line more than textwidth
    conceallevel = 2, -- Show text normally
    wrap = true,
    spell = true,
}

for k, v in pairs(options) do
    vim.o[k] = v
end
