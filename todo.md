# TODOs
- Add some kind of plugin to hide single quotes and double quotes to simplify
  the code
- Make ^ behave like \$, so that the cursor move at the first non-blank
  character of the line, something like j^ and k^.  Check Nvim-tree option
  vim.cmd "au CursorMoved NvimTree_* lua
  require'nvim-tree'.place_cursor_on_node()"
- Set up folds, with or without the help of a plugin
- If the file is under a git directory load certain plugins
- Don't open an empty buffer at startup
