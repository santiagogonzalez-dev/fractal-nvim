-- Switch between all line modes
vim.cmd([[
    function! Cycle_numbering() abort
        if exists('+relativenumber')
            execute {
                \ '00': 'set relativenumber     | set number',
                \ '01': 'set norelativenumber   | set number',
                \ '10': 'set norelativenumber   | set nonumber',
                \ '11': 'set norelativenumber   | set number', }[&number . &relativenumber]
        else
            set number!<Cr>
        endif
    endfunction
]])

-- Create command to format files using formatters
vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
