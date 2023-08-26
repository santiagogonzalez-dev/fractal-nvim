local utils = require("utils")

local point_restore = function()
	pcall(vim.cmd.loadview) -- Load the view for the opened buffer

	-- Restore cursor position
	local markpos = vim.api.nvim_buf_get_mark(0, '"') -- Get position of last saved edit
	local line = markpos[1]
	local col = markpos[2]
	-- If the cursor line position is less than 1, but not bigger than the lines of the buffer then
	if line <= vim.api.nvim_buf_line_count(0) then
		vim.api.nvim_win_set_cursor(0, { line, col }) -- Set the position
		if vim.fn.foldclosed(line) ~= -1 then -- And check if there's a closed fold
			return vim.cmd.normal("zo")
		end
	end
end

point_restore()

-- Setup the initial load and maintain some settings between buffers
local save_sessions = vim.api.nvim_create_augroup("save_sessions", {})

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Load buffer view and cursor position",
	group = save_sessions,
	callback = function()
		if not utils.avoid_filetype() then point_restore() end
	end,
})

vim.api.nvim_create_autocmd("BufWinLeave", {
	desc = "Save the view of the buffer",
	group = save_sessions,
	callback = function()
		if not utils.avoid_filetype() then return vim.cmd.mkview() end
	end,
})
