-- local dead_keys = vim.iter({
vim.keymap.set({ "n", "v", "x" }, "<BS>", "<Nop>")
vim.keymap.set({ "n", "v", "x" }, "<CR>", "<Nop>")
vim.keymap.set({ "n", "v", "x" }, "<Down>", "<Nop>")
vim.keymap.set({ "n", "v", "x" }, "<Left>", "<Nop>")
vim.keymap.set({ "n", "v", "x" }, "<Right>", "<Nop>")
vim.keymap.set({ "n", "v", "x" }, "<Space>", "<Nop>")
vim.keymap.set({ "n", "v", "x" }, "<Up>", "<Nop>")
-- })
-- dead_keys:map(function(value)
-- 	vim.keymap.set({ "n", "v", "x" }, value, "<Nop>")
-- end)

-- local break_points = vim.iter({ "!", ",", "-", ".", "<CR>", "<Space>", "=", "?", "_" })
-- break_points:map(function(value)
-- 	vim.keymap.set("i", value, string.format("%s%s", value, "<C-g>u"))
-- end)
vim.keymap.set("i", "!", "!<C-g>u")
vim.keymap.set("i", ",", "!<C-g>u")
vim.keymap.set("i", "-", "!<C-g>u")
vim.keymap.set("i", ".", "!<C-g>u")
vim.keymap.set("i", "<CR>", "!<C-g>u")
vim.keymap.set("i", "<Space>", "!<C-g>u")
vim.keymap.set("i", "=", "!<C-g>u")
vim.keymap.set("i", "?", "!<C-g>u")
vim.keymap.set("i", "_", "!<C-g>u")

-- Remap space as leader key
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

vim.keymap.set("n", "<C-n>", vim.cmd.bnext, { desc = "Switch to next buffer" })
vim.keymap.set("n", "<C-p>", vim.cmd.bprevious, { desc = "Switch to prev buffer" })

vim.keymap.set("n", "<Tab>", vim.cmd.bnext, { desc = "Switch to next buffer" })
vim.keymap.set("n", "<S-Tab>", vim.cmd.bprevious, { desc = "Switch to prev buffer" })

vim.keymap.set("n", "'", "`", { desc = "Swap ' with `" })
vim.keymap.set("n", "`", "'", { desc = "Swap ` with '" })

-- vim.keymap.set("n", ";", ":", { desc = "Swap ; with :" })
-- vim.keymap.set("n", ":", ";", { desc = "Swap : with ;" })
vim.keymap.set("c", "q!", "<CMD>q!<CR>")
vim.keymap.set("c", "qa", "<CMD>qa<CR>")
vim.keymap.set("c", "qa!", "<CMD>qa!<CR>")
vim.keymap.set("c", "wqa", "<CMD>wqa<CR>")

vim.keymap.set("n", "J", "mzJ`z", { desc = "Center J" })

vim.keymap.set("n", "<A-n>", vim.cmd.nohlsearch, { desc = "Disable highlight" })

vim.keymap.set({ "n", "v" }, "$", "g_", {
	desc = "Better $, behaves as expected",
})

vim.keymap.set("n", "gvp", "'`[' . strpart(getregtype(), 0, 1) . '`]'", { expr = true })

vim.keymap.set("n", "cg*", "*Ncgn", {
	desc = "Find and replace next match of the word under cursor",
})

vim.keymap.set({ "n", "x", "o" }, "n", '"Nn"[v:searchforward]', {
	expr = true,
	desc = "n is always next",
})

vim.keymap.set({ "n", "x", "o" }, "N", '"nN"[v:searchforward]', {
	expr = true,
	desc = "N is always previous",
})

vim.keymap.set({ "n", "v", "x" }, "<Leader>p", '"_dP', { desc = "Paste without overriding the paste register" })
-- vim.keymap.set({ "n", "v", "x" }, "<Leader>d", '"_dP', { desc = "Paste without overriding the paste register" })

vim.keymap.set("n", "y<Leader>", "yy", { desc = "Use leader key, avoid double taps" })

vim.keymap.set("n", "dd", function()
	return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
end, {
	desc = "If the line is blank(empty, or whitespace) do not override the delete register",
	noremap = true,
	expr = true,
	nowait = false,
})

vim.keymap.set("n", "<C-Up>", ":resize +1<CR>", {
	desc = "Resize windows",
})

vim.keymap.set("n", "<C-Down>", ":resize -1<CR>", {
	desc = "Resize windows",
})

vim.keymap.set("n", "<C-Left>", ":vertical resize +1<CR>", { desc = "Resize windows" })

vim.keymap.set("n", "<C-Right>", ":vertical resize -1<CR>", { desc = "Resize windows" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move selected block up/down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move selected block up/down" })

vim.keymap.set({ "v", "x" }, "<A-j>", ":m '>+1<CR>gv=gv", {
	desc = "Move block of text up and down",
}) -- Visual mode

vim.keymap.set({ "v", "x" }, "<A-k>", ":m '<-2<CR>gv=gv", {
	desc = "Move block of text up and down",
})

vim.keymap.set("n", "<Space>", "za", { desc = "Toggle folds with space" })
vim.keymap.set({ "v", "x", "o" }, "<Space>", "zf", { desc = "Toggle folds with space" })

vim.keymap.set({ "v", "x" }, "<", "<gv", { desc = "Keep visual selection after shifting codeblock" })
vim.keymap.set({ "v", "x" }, ">", ">gv", { desc = "Keep visual selection after shifting codeblock" })
vim.keymap.set({ "v", "x" }, "<Tab>", ">gv", { desc = "In visual mode use tabs for indentation" })
vim.keymap.set({ "v", "x" }, "<S-Tab>", "<gv", { desc = "In visual mode use tabs for indentation" })

vim.keymap.set("n", "//", "/<C-r>/", {
	desc = "Better search",
})

vim.keymap.set("c", "<C-j>", "<Down>", {
	desc = "Better history cmdline navigation",
})
vim.keymap.set("c", "<C-k>", "<Up>", {
	desc = "Better history cmdline navigation",
})

vim.keymap.set("c", "wqa", vim.cmd.wqa, {
	desc = "Write all and quit without hitting <CR>",
})

vim.keymap.set("n", "<Leader>e", vim.cmd.EvalYankRegister, { desc = "Eval whatever it is that the yank register has" })

vim.keymap.set("n", "<A-t>", function()
	vim.opt_local.conceallevel = vim.opt_local.conceallevel:get() == 2 and 0 or 2
	vim.lsp.inlay_hint(0, nil)
end)

vim.keymap.set('n', 'ZW', vim.cmd.w)
