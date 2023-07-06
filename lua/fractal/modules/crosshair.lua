local M = {}

function M.setup()
	vim.opt.cursorline = true
	vim.opt.cursorcolumn = true

	local buffer_settings = vim.api.nvim_create_augroup("buffer_settings", {})
	vim.api.nvim_create_autocmd({
		"UIEnter",
		"BufWinEnter",
		"BufEnter",
		"FocusGained",
		"WinEnter",
	}, {
		group = buffer_settings,
		desc = "Make the cursorline appear only on the active focused window/pan",
		callback = function()
			local timer, cnt, blink_times = vim.uv.new_timer(), 0, 16
			timer:start(
				0,
				100,
				vim.schedule_wrap(function()
					vim.cmd("set cursorcolumn! cursorline!")
					cnt = cnt + 1
					if cnt == blink_times then timer:stop() end
				end)
			)
		end,
	})
end

return M
