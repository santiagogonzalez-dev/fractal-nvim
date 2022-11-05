local M = {}
local utils = require "fractal.utils"

-- Set a colorscheme or notify if there's something wrong with it
---@param name string
---@return boolean
function M.colorscheme(name)
	-- Comprobation that `name` is a valid string
	if name == nil or utils.present_in_table(name, { "", vim.NIL }) then
		vim.notify "Colorscheme string not valid, check you user_settings.json"
		return false
	end

	local ok, _ = pcall(vim.cmd.colorscheme, name)
	if not ok then
		vim.notify "Could not find the colorscheme, check your settings.json"
		return false
	else
		vim.cmd.redraw()
		return true
	end
end

-- Apply settings using the settings from user.opts
---@param opts table
function M.opts(opts)
	for k, v in pairs(opts) do
		vim.opt[k] = v
	end
end

-- Restore session: Folds, view of the window, marks, command line history, and
-- cursor position.
---@param mode boolean
---@return boolean
function M.session(mode)
	if not mode then return false end

	-- Setup the initial load and maintain some settings between buffers
	local save_sessions = vim.api.nvim_create_augroup("save_sessions", {})

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
				return vim.cmd.normal "zo"
			end
		end
	end

	point_restore()

	vim.api.nvim_create_autocmd("BufWinEnter", {
		desc = "Load buffer view and cursor position",
		group = save_sessions,
		callback = function()
			if not utils.avoid_filetype() then point_restore() end
			-- return utils.avoid_filetype() and point_restore()
		end,
	})

	vim.api.nvim_create_autocmd("BufWinLeave", {
		desc = "Save the view of the buffer",
		group = save_sessions,
		callback = function()
			if not utils.avoid_filetype() then return vim.cmd.mkview() end
		end,
	})

	return true
end

function M.conditionals(mode)
	if not mode then return false end

	local function run_comprobations()
		-- Conditionals
		local conditionals = vim.api.nvim_create_augroup("conditionals", {})
		-- Run a comprobation for git, if the file is under git control there's no
		-- need to create an autocommand
		if utils.is_git() then
			return
		else
			-- If the current buffer wasn't under git version control run the
			-- comprobation each time you change of directory
			vim.api.nvim_create_autocmd("DirChanged", {
				group = conditionals,
				callback = function() return utils.is_git() end,
			})
		end
	end

	-- vim.schedule(run_comprobations)

	vim.defer_fn(function() run_comprobations() end, 300)

	return true
end

-- List of modules to be loaded, they can be found under
-- `./lua/modules` k is the name of the module and v is a boolean
---@param modules table @ Table containing the modules to be loaded
---@return nil
function M.modules(modules)
	if not modules then return end

	for k, v in pairs(modules) do
		if v then
			local mod_path = string.format("fractal.modules.%s", k)
			local msg = string.format(
				"Failed to load module %s, check your settings.json",
				k
			)
			utils.check({
				eval = utils.prequire(mod_path),
				status = true,
				status_msg = string.format("Success loading %s", mod_path),
				on_fail_msg = msg,
				callback = function(lib) lib.setup(v) end,
			})
		end
	end
end

return M
