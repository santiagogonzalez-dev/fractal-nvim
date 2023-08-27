local utils = require("utils")
local M = {}

function M.line_with_icons()
	-- Icon representing the line number position
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$") -- == tonumber(vim.api.nvim_eval_statusline('%L', {}).str)

	if vim.api.nvim_eval_statusline("%P", {}).str == "All" then
		return " "
	elseif current_line == 1 then
		return " "
	end

	local chars = { " ", " ", " " }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

function M.column_with_icons()
	-- Represent cursor column and length of the line
	local line_lenght = vim.fn.col("$") - 1
	local cursor_column = vim.fn.col(".") -- == tonumber(vim.api.nvim_eval_statusline('%c', {}).str)

	if line_lenght == cursor_column then
		return cursor_column, "␊"
	elseif line_lenght == 0 then
		return ""
	else
		return cursor_column, "↲", line_lenght
	end
end

function M.filepath()
	-- Return the filepath without the name of the file
	local filepath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	if filepath == "" or filepath == "." then return " " end

	-- if vim.bo.filetype == "lua" then
	-- 	-- For lua use . as a separator instead of /
	-- 	local replace_fpath = string.gsub(filepath, "/", ".")
	-- 	return string.format("%%<%s.", replace_fpath)
	-- end

	return string.format("%%<%s/", filepath)
end

function M.filename()
	-- local filename = vim.fn.expand("%:t")
	local filename = vim.api.nvim_eval_statusline("%t", {}).str
	if filename == "" then return " " end

	return filename
end

-- Position of the cursor, batteries included.
---@return string
function M.cursor_coordinates()
	return "%l" .. M.line_with_icons() .. M.column_with_icons()
end

function M.get()
	return table.concat({
		M.cursor_coordinates(),
		"%=",
		"%m ",
		"%#NonText#",
		M.filepath(),
		"%#StatusLine#",
		M.filename(),
	})
end

function M.setup()
	local winbar = '%{%v:lua.require("user.config.winbar").get()%}'
	vim.opt.winbar = winbar
end

return M
