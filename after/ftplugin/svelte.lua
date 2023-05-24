local tab_lenght = 2
vim.opt_local.tabstop = tab_lenght
vim.opt_local.shiftwidth = tab_lenght
vim.opt_local.colorcolumn = '80,100'
vim.opt_local.textwidth = 90
vim.opt_local.conceallevel = 0

-- vim.keymap.set('i', '=', function()
--    -- The cursor location does not give us the correct node in this case, so we
--    -- need to get the node to the left of the cursor
--    local cursor = vim.api.nvim_win_get_cursor(0)
--    local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }
--
--    local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
--    local nodes_active_in = {
--       'attribute_name',
--       'directive_argument',
--       'directive_name',
--    }
--    if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
--       -- The cursor is not on an attribute node
--       return '='
--    end
--
--    return '=""<left>'
-- end, { expr = true, buffer = true })
