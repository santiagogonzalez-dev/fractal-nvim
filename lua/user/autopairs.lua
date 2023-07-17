local M = {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
}

M.config = function()
	require("nvim-autopairs").setup({
		check_ts = true,
		ts_config = { javascript = { "template_string" } },
		disable_filetype = { "TelescopePrompt" },
		enable_afterquote = false, -- To use bracket pairs inside quotes
		enable_check_bracket_line = true, -- Check for closing brace so it will not add a close pair
		disable_in_macro = false,
		fast_wrap = {
			map = "<C-f>",
			chars = { "{", "[", "(", '"', "'", "<" },
			pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
			offset = -1, -- Offset from pattern match, with -1 you can insert before the comma
			keys = "aosenuth", -- Because I use dvorak BTW
			check_comma = true,
			highlight = "Search",
			highlight_grey = "IncSearch",

			map_char = {
				all = "(",
				tex = "{",
			},
			enable_check_bracket_line = false,
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
			enable_moveright = true,
			disable_in_macro = false,
			enable_afterquote = true,
			map_bs = true,
			map_c_w = false,
			disable_in_visualblock = false,
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0, -- Offset from pattern match
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		},
	})
	pcall(function()
		local function on_confirm_done(...) require("nvim-autopairs.completion.cmp").on_confirm_done()(...) end
		require("cmp").event:off("confirm_done", on_confirm_done)
		require("cmp").event:on("confirm_done", on_confirm_done)
	end)
end

return M
