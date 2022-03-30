# TODOs

- Make ^ behave like \$, so that the cursor move at the first non-blank
  character of the line, something like j^ and k^. Check Nvim-tree option
  vim cmd "au CursorMoved NvimTree\_\* lua
  require'nvim-tree'.place_cursor_on_node()"
- If the file is under a git directory load certain plugins, maybe use git_files
  from telescope, it will be easier that way
- Don't open an empty buffer at startup
- See https://github.com/neovim/neovim/pull/16251 for more info on cmdheight=0 vim.opt.lines:append '1' -- Hide command line, currently very buggy
- Update cmp
- Add something like https://git.sr.ht/~whynothugo/lsp_lines.nvim but to the gl keybind
- Expand the usage of <C-a> and <C-x> to switch between boolean values, and quit
  using dial.nvim
- Fix M.rename(), also add: if it's not supported by the LS use s/aoeu/stnh/gc
- Change the keybinding for the terminal of <C-t> in toggle term
- And maybe use the integrated terminal
- Learn how to use quickfix lists
- Make a command that highligths the pasted text, like gv, but gvp
- Set up skeletons
- Make user autocommands to load plugins at once instead of calling one by one
- If for example we press tS, and there's no S on that line(we can check this if
the cursor is at the same position), we move it to the line belowe and try to
change it there
