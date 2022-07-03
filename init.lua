local utils = require('csj.utils')
pcall(require, 'impatient')

utils.disable()
utils.session()
utils.colorscheme('jetjbp')
utils.conditionals()

require('csj.plugins')
require('csj.core')
