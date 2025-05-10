vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'plugins.lazy'

require('lazy').setup({
	require 'plugins/telescope'
})

require 'config.options'
require 'config.keymaps'
