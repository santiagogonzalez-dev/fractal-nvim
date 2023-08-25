local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufEnter",
	cmd = "Gitsigns",
}

M.config = function()
	local icons = require("user.modules.icons")
	local gitsigns = require("gitsigns")

	gitsigns.setup({
		signs = {
			add = {
				hl = "GitSignsAdd",
				text = icons.ui.BoldLineLeft,
				numhl = "GitSignsAddNr",
				linehl = "GitSignsAddLn",
			},
			change = {
				hl = "GitSignsChange",
				text = icons.ui.BoldLineLeft,
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
			delete = {
				hl = "GitSignsDelete",
				text = icons.ui.TriangleShortArrowRight,
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			topdelete = {
				hl = "GitSignsDelete",
				text = icons.ui.TriangleShortArrowRight,
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			changedelete = {
				hl = "GitSignsChange",
				text = icons.ui.BoldLineLeft,
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		update_debounce = 200,
		max_file_length = 40000,
		preview_config = {
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},

		signcolumn = false,
		numhl = true,
		linehl = false,
		word_diff = true,
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- eol, overlay, right_align
			delay = 6000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter_opts = { relative_time = true },
		sign_priority = 6,
		status_formatter = nil, -- Use default
		yadm = { enable = false },
		on_attach = function(bufnr)
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gitsigns.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gitsigns.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true })

			-- Actions
			-- map({ "n", "v" }, "<Leader>hs", ":Gitsigns stage_hunk<CR>")
			-- map({ "n", "v" }, "<Leader>hr", ":Gitsigns reset_hunk<CR>")
			-- map("n", "<Leader>hS", gitsigns.stage_buffer)
			-- map("n", "<Leader>hu", gitsigns.undo_stage_hunk)
			-- map("n", "<Leader>hR", gitsigns.reset_buffer)
			-- map("n", "<Leader>hp", gitsigns.preview_hunk)
			-- map("n", "<Leader>hb", function() gitsigns.blame_line({ full = true }) end)
			-- map("n", "<Leader>tb", gitsigns.toggle_current_line_blame)
			-- map("n", "<Leader>hd", gitsigns.diffthis)
			-- map("n", "<Leader>hD", function() gitsigns.diffthis("~") end)
			-- map("n", "<Leader>td", gitsigns.toggle_deleted)

			-- Text object
			-- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

			map("n", "ghr", gitsigns.reset_hunk)
			map("n", "ghb", gitsigns.reset_buffer)
			map("n", "ghj", gitsigns.next_hunk)
			map("n", "ghk", gitsigns.prev_hunk)
			map("n", "ghp", gitsigns.preview_hunk)
		end,
	})
end

return M
