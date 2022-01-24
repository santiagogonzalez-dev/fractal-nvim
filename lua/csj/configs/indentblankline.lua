local status_ok, indent_blankline = pcall(require, 'indent_blankline')
if not status_ok then
    return
end

indent_blankline.setup({
    show_current_context = true,
    -- show_current_context_start = true,
    show_end_of_line = false,
    buftype_exclude = { 'terminal', 'nofile', 'NvimTree' },
    filetype_exclude = { 'help', 'packer', 'NvimTree' },
})

vim.g.indent_blankline_show_trailing_blankline_indent = false
-- vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_enabled = false
vim.g.indent_blankline_context_patterns = {
    'class',
    'return',
    'function',
    'method',
    '^if',
    '^while',
    'jsx_element',
    '^for',
    '^object',
    '^table',
    'block',
    'arguments',
    'if_statement',
    'else_clause',
    'jsx_element',
    'jsx_self_closing_element',
    'try_statement',
    'catch_clause',
    'import_statement',
    'operation_type',
}
