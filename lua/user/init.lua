vim.loader.enable()

require("user.launch")

require("user.config")
spec("user.modules.colorscheme")
spec("user.modules.rcd")

spec("user.modules.devicons")
spec("user.modules.comment")
spec("user.modules.autopairs")
spec("user.modules.surround")
spec("user.modules.accelerated-jk")
spec("user.modules.treesitter")
spec("user.modules.harpoon")
spec("user.modules.telescope")
spec("user.modules.gitsigns")
spec("user.modules.project")

require("user.lazy")
