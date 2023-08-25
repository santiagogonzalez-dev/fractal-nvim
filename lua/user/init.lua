vim.loader.enable()

require("user.config.settings")
require("user.config.keymaps")
require("user.config.gutter")
require("user.config.hidden-statusline")

require("user.launch")

spec("user.modules.colorscheme")
spec("user.modules.rcd")
spec("user.modules.comment")
spec("user.modules.surround")
spec("user.modules.accelerated-jk")
spec("user.modules.treesitter")

require("user.lazy")
