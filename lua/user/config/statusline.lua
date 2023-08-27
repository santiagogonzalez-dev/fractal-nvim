local M = {}
local _kg_ns = vim.api.nvim_create_namespace("keypresses_global")

M.typed_letters = {}

local spec_table = {
	[9] = " ",
	[13] = "<CR>",
	[27] = "<ESC>",
	[32] = "␣",
	[127] = " ",
}

local function traduce(key)
	local b = key:byte()
	for k, v in pairs(spec_table) do
		if b == k then return v end
	end
	if b <= 126 and b >= 33 then return key end
end

-- Traduce the key and insert it on the table of used keys.
---@param key_code integer|string
function M.register_keys(key_code)
	local key = traduce(key_code)

	if key then
		if #M.typed_letters >= 13 then table.remove(M.typed_letters, 1) end

		table.insert(M.typed_letters, key)
	end
end

function M.start_registering()
	vim.on_key(function(key_code)
		M.register_keys(key_code)
	end, _kg_ns)
end
M.start_registering()

-- Get the pressed keys.
---@param as_string? boolean|true @ Whether to return the keys as a string or as a table.
---@return string|table
function M.current_keys(as_string)
	as_string = as_string or true
	local typed_letters = M.typed_letters
	if #typed_letters > 1 then
		return as_string and string.format("  %s", table.concat(typed_letters)) or typed_letters
	else
		return " "
	end
end

---@return string
function M.get()
	return table.concat({
		"%=",
		M.current_keys(),
		"%=",
	})
end

function M.setup()
	vim.opt.laststatus = 3
	vim.opt.cmdheight = 0

	local statusline = '%{%v:lua.require("user.config.statusline").get()%}'

	vim.api.nvim_create_autocmd({ "TabEnter", "BufEnter", "WinEnter" }, {
		callback = function()
			vim.opt.statusline = statusline
		end,
	})

	vim.api.nvim_create_autocmd({ "WinEnter", "FileType" }, {
		pattern = {
			"NetrwTreeListing",
			"TelescopePrompt",
			"gitcommit",
			"gitdiff",
			"help",
			"netrw",
		},
		callback = function()
			vim.opt.statusline = "%#StatusLineNC#" -- Disable statusline
		end,
	})
end

return M
