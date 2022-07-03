-- Load core modules: Keymaps, fold settings, notifications, netrw settings,
-- autocommands, virtual column, statusline and other modifications to modal
-- editing.

require('csj.core.netrw') -- NetRW config.
require('csj.core.autocmds') -- Some common autocommands.
require('csj.core.settings') -- General settings.
require('csj.core.folds') -- Settings and keybinds related to folds.
require('csj.core.virt-column') -- Use virtual text instead of the normal colorcolumn.
require('csj.core.statusline') -- Pure lua statusline.
require('csj.core.notifications') -- Integrate notifications with your DE/WM. Overrides vim.notify to use notify-send instead.
require('csj.core.keymaps') -- Common keybinds and remappings.
require('csj.core.sdmog') -- Show where the . mark is in the file with an icon on the sign column(gutter).
require('csj.core.strict_cursor') -- Adds a second mode cursor.
require('csj.core.afiolb') -- Ask user for input if there is only one active normal buffer..
require('csj.core.skeletons') -- Apply a template(skeleton) to new files
