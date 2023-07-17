local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp",
		},
		{
			"hrsh7th/cmp-buffer",
		},
		{
			"hrsh7th/cmp-path",
		},
		{
			"hrsh7th/cmp-cmdline",
		},
		{
			"saadparwaiz1/cmp_luasnip",
		},
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
		{
			"hrsh7th/cmp-nvim-lua",
		},
	},
	event = "InsertEnter",
}

function M.config()
	local config = require("cmp")
	local luasnip = require("luasnip")
	require("luasnip/loaders/from_vscode").lazy_load()

	local check_backspace = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	end

	local icons = require("user.icons")

	config.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = config.mapping.preset.insert({
			["<C-k>"] = config.mapping(config.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = config.mapping(config.mapping.select_next_item(), { "i", "c" }),
			["<Down>"] = config.mapping(config.mapping.select_next_item(), { "i", "c" }),
			["<Up>"] = config.mapping(config.mapping.select_prev_item(), { "i", "c" }),
			["<C-b>"] = config.mapping(config.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = config.mapping(config.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = config.mapping(config.mapping.complete(), { "i", "c" }),
			["<C-e>"] = config.mapping({
				i = config.mapping.abort(),
				c = config.mapping.close(),
			}),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = config.mapping.confirm({ select = true }),
			["<Tab>"] = config.mapping(function(fallback)
				if config.visible() then
					config.select_next_item()
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
				"i",
				"s",
			}),
			["<S-Tab>"] = config.mapping(function(fallback)
				if config.visible() then
					config.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = icons.kind[vim_item.kind]
				vim_item.menu = ({
					nvim_lsp = "",
					nvim_lua = "",
					luasnip = "",
					buffer = "",
					path = "",
					emoji = "",
				})[entry.source.name]
				return vim_item
			end,
		},
		sources = {
			{ name = "copilot" },
			{
				name = "nvim_lsp",
				entry_filter = function(entry, ctx)
					local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
					if kind == "Snippet" and ctx.prev_context.filetype == "java" then return false end
					return true
				end,
			},
			{ name = "luasnip" },
			{ name = "cmp_tabnine" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "path" },
			{ name = "calc" },
			{ name = "emoji" },
			{ name = "treesitter" },
			{ name = "crates" },
			{ name = "tmux" },
		},
		confirm_opts = {
			behavior = config.ConfirmBehavior.Replace,
			select = false,
		},
		window = {
			completion = {
				border = "rounded",
				winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
				col_offset = -3,
				side_padding = 1,
				scrollbar = false,
				scrolloff = 8,
			},
			documentation = {
				border = "rounded",
				winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
			},
		},
		experimental = {
			ghost_text = false,
		},
	})
end

return M
