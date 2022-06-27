local M = {}

function M.init()
   require('csj.manners.modules.sdmog').init()
   require('csj.manners.modules.strict_cursor').init() -- Use stricter cursor movements, only enable virtualedit cursor when pressing <Esc><Esc>
   require('csj.manners.modules.afiolb').init() -- Ask user for input if there is only one active normal buffer
end

return M
