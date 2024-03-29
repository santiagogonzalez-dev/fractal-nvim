local readable = require("utils").readable

local session_opts = vim.api.nvim_create_augroup("session_opts", {})

vim.api.nvim_create_autocmd("Filetype", {
	desc = "Open help and man pages in a vertical split if there's not enough space",
	group = session_opts,
	pattern = { "help", "man" },
	callback = function()
		if vim.opt.lines:get() * 4 < vim.opt.columns:get() and not vim.w.help_is_moved then
			vim.cmd("wincmd L")
			vim.w.help_is_moved = true
		end
	end,
})

vim.api.nvim_create_autocmd("FocusGained", {
	command = "silent! checktime",
	desc = "Check if any file has changed when Vim is focused",
	group = session_opts,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
	desc = "Actions when the file is changed outside of Neovim",
	group = session_opts,
	callback = function()
		vim.notify("File changed, reloading the buffer", vim.log.levels.WARN)
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Create directories before saving a buffer, should come by default",
	group = session_opts,
	callback = function()
		return vim.fn.mkdir(vim.fn.expand("%:p:h"), "p")
	end,
})

local first_load = vim.api.nvim_create_augroup("first_load", {})

vim.api.nvim_create_autocmd("UIEnter", {
	desc = "Print the output of flag --startuptime startuptime.txt",
	group = first_load,
	once = true,
	pattern = "*.lua",
	callback = function()
		vim.defer_fn(function()
			if readable("startuptime.txt") then
				vim.cmd(":!tail -n3 startuptime.txt")
				vim.fn.delete("startuptime.txt")
			end
		end, 1000)
	end,
})

-- Globals
local buffer_settings = vim.api.nvim_create_augroup("buffer_settings", {})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Quit with q in this filetypes",
	group = buffer_settings,
	pattern = {
		"help",
		"lspinfo",
		"man",
		"netrw",
		"qf",
	},
	callback = function()
		vim.keymap.set("n", "q", "<CMD>close<CR>", { buffer = 0 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Quit! with q! in this filetypes",
	group = buffer_settings,
	pattern = "TelescopePrompt",
	callback = function()
		vim.keymap.set("n", "q", ":q!<CR>", { buffer = 0 })
	end,
})

vim.api.nvim_create_user_command("RemoveWhitespace", function()
	if not vim.o.binary and vim.o.filetype ~= "diff" then
		local current_view = vim.fn.winsaveview()
		vim.cmd([[keeppatterns %s/\s\+$//e]])
		return vim.fn.winrestview(current_view)
	end
end, {})

vim.api.nvim_create_autocmd("VimResized", {
	command = "tabdo wincmd =",
	desc = "Autoresize, ensures splits are equal width when resizing vim",
	group = session_opts,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 600 })
	end,
	desc = "Highlight on yank",
	group = session_opts,
})

local mouse_original_value = vim.api.nvim_get_option("mouse")
vim.api.nvim_create_autocmd("InsertEnter", {
	desc = "Disable mouse in insert mode",
	group = session_opts,
	callback = function()
		vim.opt.mouse = ""
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	desc = "Restore default values for mouse",
	group = session_opts,
	callback = function()
		vim.opt.mouse = mouse_original_value
	end,
})

-- from https://github.com/omega-nvim/omega-nvim
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	callback = function(data)
		require("user.config.highlight_undo").setup(data.buf)
	end,
})

local CustomSettingsGroup = vim.api.nvim_create_augroup("CustomSettingsGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	group = CustomSettingsGroup,
	pattern = "*",
	callback = function()
		local not_executable = vim.fn.getfperm(vim.fn.expand("%")):sub(3, 3) ~= "x"
		local has_shebang = string.match(vim.fn.getline(1), "^#!")
		local has_bin = string.match(vim.fn.getline(1), "/bin/")
		if not_executable and has_shebang and has_bin then
			vim.notify("File made executable")
			vim.cmd([[!chmod +x <afile>]])
		end
	end,
	once = false,
})
