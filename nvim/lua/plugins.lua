local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
end

--- Check if a file or directory exists in this path
local function require_plugin(plugin)
    local plugin_prefix = fn.stdpath("data") .. "/site/pack/packer/opt/"

    local plugin_path = plugin_prefix .. plugin .. "/"
    --	print('test '..plugin_path)
    local ok, err, code = os.rename(plugin_path, plugin_path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    --	print(ok, err, code)
    if ok then
        vim.cmd("packadd " .. plugin)
    end
    return ok, err, code
end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup(
    function(use)
        -- Packer can manage itself as an optional plugin
        use "wbthomason/packer.nvim"
        -- Colorizer for color codes and names
        use 'norcalli/nvim-colorizer.lua'
        -- Comments
        use 'terrortylor/nvim-comment'
        -- Colorschemes
        use 'joshdick/onedark.vim'
        use 'kyazdani42/nvim-web-devicons'
        use 'glepnir/galaxyline.nvim'
        -- Autopairs
        use 'windwp/nvim-autopairs'
        -- Bar bar
        use 'romgrk/barbar.nvim'
        -- Dashboard
        use 'glepnir/dashboard-nvim'
    end
)
