local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
   return
end

treesitter.setup {
   -- ensure_installed = 'all',
   ensure_installed = {
      'comment',
      'lua',
      'python',
      'javascript',
      'java',
      'typescript',
      'bash',
      'vim',
   },
   sync_install = false,
   highlight = {
      enable = true,
      aditional_vim_regex_highlighting = false,
      disable = { 'latex' },
   },
   context_commentstring = {
      enable = true,
      enable_autocmd = true,
   },
   indent = {
      enable = true,
      disable = { 'yaml', 'python' },
   },
   autopairs = { enable = true },
   autotag = {
      enable = true,
      filetypes = {
         'css',
         'html',
         'javascript',
         'javascriptreact',
         'markdown',
         'svelte',
         'typescript',
         'typescriptreact',
         'vue',
         'xhtml',
         'xml',
      },
   },
   incremental_selection = {
      enable = true,
      keymaps = {
         init_selection = 'gnn', -- Start the selection by nodes
         node_incremental = 'gnn', -- Increment to the node with higher order
         node_decremental = 'gnp', -- Decrement to the node with lower order
         scope_incremental = 'gns', -- Select the entire group  of nodes including the braces
      },
   },
   textobjects = {
      select = {
         enable = true,
         lookahead = true, -- Automatically jump forward to textobj
         keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer', -- Include the function keyword/s
            ['if'] = '@function.inner', -- Select just the insides of the function
            ['ac'] = '@class.outer', -- Include the class keyword
            ['ic'] = '@class.inner', -- Select just the insides of the keyword
            ['i,'] = '@parameter.inner', -- Change between parameters
            ['a,'] = '@parameter.outer', -- Change paramater including the separator
         },
      },
      swap = {
         enable = false, -- Disabled for now, it's not that useful
         swap_next = { ['<Leader>a'] = '@parameter.inner' }, -- Move paramaters around
         swap_previous = { ['<Leader>A'] = '@parameter.inner' }, -- Move paramaters around
      },
      move = {
         enable = true,
         set_jumps = true, -- Whether to set jumps in the jumplist
         -- First [ means previous, first ] means next
         -- m is for function, M for function end
         goto_previous_start = {
            ['[m'] = '@function.outer', -- Move to the previous or actual node or function(not just keywords)
            ['[['] = '@class.outer', -- Move to the previous or actual class keyword
         },
         goto_next_start = {
            [']m'] = '@function.outer', -- Move to the function keyword
            [']]'] = '@class.outer', -- Move to the class keyword
         },
         goto_next_end = {
            [']M'] = '@function.outer', -- Move to the end of the function
            [']['] = '@class.outer', -- Move to the end of the class
         },
         goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
         },
      },
      lsp_interop = {
         enable = true,
         border = 'rounded',
         peek_definition_code = {
            ['gdf'] = '@function.outer',
            ['gdF'] = '@class.outer',
         },
      },
   },
}
