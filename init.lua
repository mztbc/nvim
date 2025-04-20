vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'config.options'
require 'plugins.lazy'

require("lazy").setup({
	require 'plugins/telescope',
})
