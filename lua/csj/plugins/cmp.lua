-- Setup nvim-cmp.
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
  return
end

require('luasnip/loaders/from_vscode').lazy_load()

local check_backspace = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

local kind_icons = {
  Text = '',
  Method = '',
  Constructor = '', -- 
  Field = '', -- ﰠ
  Variable = '',
  Class = '', -- ﴯ
  Property = '', -- ﰠ
  Unit = '塞', -- 
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '', -- 
  Color = '', --   
  File = '', -- 
  Reference = '', -- 
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '', -- ﯟ   פּ
  Event = '',
  Operator = '',
  TypeParameter = '',
  Function = '',
  Interface = '',
  Module = '',
}

-- Add some colors
local set_hl = require("csj.core.utils").set_hl
set_hl('CmpItemAbbrDeprecated', { strikethrough = true, fg = '#808080' })
set_hl('CmpItemAbbrMatch', { bold = true, fg = '#d7827e' })
set_hl('CmpItemAbbrMatchFuzzy', { bold = true, fg = '#d7827e' })
set_hl('CmpItemKindVariable', { fg = '#9ccfd8' })
set_hl('CmpItemKindInterface', { fg = '#9ccfd8' })
set_hl('CmpItemKindText', { fg = '#9ccfd8' })
set_hl('CmpItemKindFunction', { fg = '#c4a7e7' })
set_hl('CmpItemKindMethod', { fg = '#c4a7e7' })
set_hl('CmpItemKindKeyword', { fg = '#c4a7e7' })
set_hl('CmpItemKindProperty', { fg = '#e0def4' })
set_hl('CmpItemKindUnit', { fg = '#e0def4' })

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },

  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-3), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(3), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<Cr>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      -- vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind]) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        luasnip = 'Snippet',
        nvim_lsp = 'LSP',
        nvim_lua = 'NVIM_LUA',
        path = 'Path',
        buffer = 'Buffer',
      })[entry.source.name]
      return vim_item
    end,
  },

  sources = {
    { name = 'luasnip', keyword_lenght = 3 },
    { name = 'nvim_lua', keyword_lenght = 3 },
    { name = 'nvim_lsp', keyword_lenght = 3 },
    { name = 'buffer', keyword_lenght = 3 },
    { name = 'path', keyword_lenght = 3 },
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  documentation = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
  },
}

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer', Keyword_length = 3 },
  },
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path', keyword_lenght = 6 },
    { name = 'cmdline', keyword_lenght = 3 },
  },
})
