-- Load plugin modules in order.

require 'kickstart.plugins.guess-indent'
require 'kickstart.plugins.gitsigns'
require 'kickstart.plugins.which-key'
require 'kickstart.plugins.tokyonight'
require 'kickstart.plugins.todo-comments'
require 'kickstart.plugins.mini'
require 'kickstart.plugins.telescope'
require 'kickstart.plugins.lspconfig'
require 'kickstart.plugins.conform'
require 'kickstart.plugins.blink-cmp'
require 'kickstart.plugins.treesitter'
require 'kickstart.plugins.indent_line'
require 'kickstart.plugins.autopairs'
require 'kickstart.plugins.neo-tree'

-- Personal plugins from lua/custom/plugins/*.lua
require 'custom.plugins'

-- vim: ts=2 sts=2 sw=2 et
