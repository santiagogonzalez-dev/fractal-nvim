# TODOs

- Add some kind of plugin to hide single quotes and double quotes to simplify
  the code
- Make ^ behave like \$, so that the cursor move at the first non-blank
  character of the line, something like j^ and k^. Check Nvim-tree option
  vim cmd "au CursorMoved NvimTree\_\* lua
  require'nvim-tree'.place_cursor_on_node()"
- Set up folds, with or without the help of a plugin
- If the file is under a git directory load certain plugins
- Don't open an empty buffer at startup
- See https://github.com/neovim/neovim/pull/16251 for more info on cmdheight=0
- vim.opt.lines:append '1' -- Hide command line, currently very buggy
- https://github.com/neovim/neovim/pull/17266 for laststatus = 3
- Update capabilities in cmp
- Add something like https://git.sr.ht/~whynothugo/lsp_lines.nvim but to the gl keybind
- Expand the usage of <C-a> and <C-x> to switch between boolean values


- TODO add this to filetype plugin for python
```lua
    local ts_utils = require('nvim-treesitter.ts_utils')
    toggle_fstring = function()
        local winnr = 0
        local cursor = vim.api.nvim_win_get_cursor(winnr)
        local node = ts_utils.get_node_at_cursor()

        while (node ~= nil) and (node:type() ~= 'string') do
            node = node:parent()
        end
        if node == nil then
            print('f-string: not in string node :(')
            return
        end

        local srow, scol, ecol, erow = ts_utils.get_vim_range { node:range() }
        vim.fn.setcursorcharpos(srow, scol)
        local char = vim.api.nvim_get_current_line():sub(scol, scol)
        local is_fstring = (char == 'f')

        if is_fstring then
            vim.cmd('normal x')
            -- if cursor is in the same line as text change
            if srow == cursor[1] then
                cursor[2] = cursor[2] - 1 -- negative offset to cursor
            end
        else
            vim.cmd('normal if')
            -- if cursor is in the same line as text change
            if srow == cursor[1] then
                cursor[2] = cursor[2] + 1 -- positive offset to cursor
            end
        end
        vim.api.nvim_win_set_cursor(winnr, cursor)
    end

    vim.keymap.set('n', 'F', toggle_fstring, { noremap = true })
```
