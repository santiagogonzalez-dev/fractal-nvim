local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
   return
end

local previewers = require "telescope.previewers"
local previewers_utils = require "telescope.previewers.utils"

telescope.setup({
   defaults = {
      vimgrep_arguments = {
         "rg",
         "--column",
         "--hidden",
         "--line-number",
         "--no-heading",
         "--smart-case",
         "--vimgrep",
         "--with-filename",
         "--color=never",
         "--line-number",
         "--trim",
      },
      path_display = { "smart" },
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      color_devicons = true,
      prompt_prefix = " ",
      selection_caret = " ",
      entry_prefix = "  ",
      selection_strategy = "reset",
      initial_mode = "insert",
      preview = {
         filesize_hook = function(filepath, bufnr, opts)
            -- If the file is very big only print the head of the it
            local cmd = { "head", "-c", 1000000, filepath }
            previewers_utils.job_maker(cmd, bufnr, opts)
         end,
      },
      sorting_strategy = "ascending",
      winblend = 9,
   },
})

telescope.load_extension "projects"

vim.keymap.set(
   "n",
   "<Leader>gr",
   "<CMD>Telescope lsp_references theme=dropdown<CR>"
)
vim.keymap.set("n", "<Leader>t/", "<CMD>Telescope live_grep theme=dropdown<CR>")
vim.keymap.set(
   "n",
   "<Leader>t//",
   "<CMD>Telescope current_buffer_fuzzy_find theme=dropdown<CR>"
)
vim.keymap.set("n", "<Leader>tf", "<CMD>Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>tg", "<CMD>Telescope grep_string<CR>")
vim.keymap.set("n", "<Leader>tp", "<CMD>Telescope projects<CR>")
vim.keymap.set("n", "<Leader>tt", "<CMD>Telescope<CR>")
