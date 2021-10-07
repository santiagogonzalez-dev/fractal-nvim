-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/st/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/st/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/st/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/st/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/st/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["barbar.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/st/.local/share/nvim/site/pack/packer/opt/barbar.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\2�\5\0\0\4\0\20\0\0234\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\14\0003\2\4\0003\3\3\0:\3\5\0023\3\6\0:\3\a\0023\3\b\0:\3\t\0023\3\n\0:\3\v\0023\3\f\0:\3\r\2:\2\15\0013\2\16\0:\2\17\0013\2\18\0:\2\19\1>\0\2\1G\0\1\0\17watch_gitdir\1\0\1\rinterval\3�\a\fkeymaps\1\0\2\vbuffer\2\fnoremap\2\nsigns\1\0\4\18sign_priority\3\6\vlinehl\1\20update_debounce\3�\1\nnumhl\1\17changedelete\1\0\4\ttext\b▎\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\14topdelete\1\0\4\ttext\b契\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\vdelete\1\0\4\ttext\b契\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\ahl\19GitSignsDelete\vchange\1\0\4\ttext\b▎\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\ahl\19GitSignsChange\badd\1\0\0\1\0\4\ttext\b▎\nnumhl\18GitSignsAddNr\vlinehl\18GitSignsAddLn\ahl\16GitSignsAdd\nsetup\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/st/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/st/.local/share/nvim/site/pack/packer/start/impatient.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\1\2�\1\0\0\4\0\f\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\a\0003\3\6\0:\3\b\0023\3\t\0:\3\n\2:\2\v\1>\0\2\1G\0\1\0\14ts_config\15javascript\1\2\0\0\20template_string\blua\1\0\1\tjava\1\1\2\0\0\vstring\rmap_char\1\0\2\ball\6(\btex\6{\1\0\4\vinsert\1\16auto_select\2\rcheck_ts\2\vmap_cr\2\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/st/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-comment"] = {
    config = { "\27LJ\1\2�\1\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0>\0\2\1G\0\1\0\1\0\5\17line_mapping\bgcc\20create_mappings\2\19marker_padding\2\21operator_mapping\agc\18comment_empty\1\nsetup\17nvim_comment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/st/.local/share/nvim/site/pack/packer/opt/nvim-comment"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/st/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/st/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\1\2�\5\0\0\5\0\23\0\0274\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\n\0003\2\3\0003\3\4\0:\3\5\0023\3\6\0003\4\a\0:\4\b\3:\3\t\2:\2\2\0013\2\v\0:\2\f\0013\2\r\0:\2\14\0013\2\15\0:\2\16\0013\2\17\0003\3\18\0:\3\19\0023\3\20\0:\3\21\2:\2\22\1>\0\2\1G\0\1\0\nicons\vfolder\1\0\5\fdefault\b\15empty_open\b\topen\b\nempty\b\fsymlink\b\bgit\1\0\a\runstaged\b\fdeleted\b\14untracked\6U\fignored\b◌\runmerged\b\frenamed\b➜\vstaged\6S\1\0\2\fdefault\b\fsymlink\b\19auto_ignore_ft\1\3\0\0\rstartify\14dashboard\vignore\1\4\0\0\t.git\17node_modules\v.cache\15show_icons\1\0\5\nfiles\3\1\18folder_arrows\3\1\bgit\3\1\ffolders\3\1\15tree_width\3\30\1\0\5\17quit_on_open\3\0\vgit_hl\3\1\17allow_resize\3\1\18hide_dotfiles\3\1\25root_folder_modifier\a:t\tview\rmappings\1\0\1\16custom_only\1\1\0\3\16auto_resize\1\tside\tleft\nwidth\3\30\24update_focused_file\1\0\1\venable\3\1\1\0\4\14auto_open\3\0\rtab_open\3\0\15auto_close\3\1\20lsp_diagnostics\3\1\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/st/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\1\2I\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/st/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/st/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/st/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/st/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/st/.local/share/nvim/site/pack/packer/start/tokyonight.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\1\2I\0\0\2\0\3\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0002\1\0\0>\0\2\1G\0\1\0\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\1\2�\1\0\0\4\0\f\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\a\0003\3\6\0:\3\b\0023\3\t\0:\3\n\2:\2\v\1>\0\2\1G\0\1\0\14ts_config\15javascript\1\2\0\0\20template_string\blua\1\0\1\tjava\1\1\2\0\0\vstring\rmap_char\1\0\2\ball\6(\btex\6{\1\0\4\vinsert\1\16auto_select\2\rcheck_ts\2\vmap_cr\2\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\1\2�\5\0\0\5\0\23\0\0274\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\n\0003\2\3\0003\3\4\0:\3\5\0023\3\6\0003\4\a\0:\4\b\3:\3\t\2:\2\2\0013\2\v\0:\2\f\0013\2\r\0:\2\14\0013\2\15\0:\2\16\0013\2\17\0003\3\18\0:\3\19\0023\3\20\0:\3\21\2:\2\22\1>\0\2\1G\0\1\0\nicons\vfolder\1\0\5\fdefault\b\15empty_open\b\topen\b\nempty\b\fsymlink\b\bgit\1\0\a\runstaged\b\fdeleted\b\14untracked\6U\fignored\b◌\runmerged\b\frenamed\b➜\vstaged\6S\1\0\2\fdefault\b\fsymlink\b\19auto_ignore_ft\1\3\0\0\rstartify\14dashboard\vignore\1\4\0\0\t.git\17node_modules\v.cache\15show_icons\1\0\5\nfiles\3\1\18folder_arrows\3\1\bgit\3\1\ffolders\3\1\15tree_width\3\30\1\0\5\17quit_on_open\3\0\vgit_hl\3\1\17allow_resize\3\1\18hide_dotfiles\3\1\25root_folder_modifier\a:t\tview\rmappings\1\0\1\16custom_only\1\1\0\3\16auto_resize\1\tside\tleft\nwidth\3\30\24update_focused_file\1\0\1\venable\3\1\1\0\4\14auto_open\3\0\rtab_open\3\0\15auto_close\3\1\20lsp_diagnostics\3\1\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufWinEnter * ++once lua require("packer.load")({'barbar.nvim'}, { event = "BufWinEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-comment', 'gitsigns.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
